import 'dart:math';

import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapLocationPicker extends StatefulWidget {
  final Position? initialPosition;
  final double radiusInMeters;
  final Function(LatLng) onLocationSelected;

  const MapLocationPicker({
    Key? key,
    required this.initialPosition,
    this.radiusInMeters = 500,
    required this.onLocationSelected,
  }) : super(key: key);

  @override
  State<MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  late LatLng _selectedLocation;
  late LatLng _centerPosition;
  late MapController _mapController;
  late final LatLngBounds _bounds;
  final _distance = const Distance();

  @override
  void initState() {
    super.initState();
    if (widget.initialPosition != null) {
      _centerPosition = LatLng(
          widget.initialPosition!.latitude, widget.initialPosition!.longitude);
      _selectedLocation = _centerPosition;
      _mapController = MapController();

      final metersPerDegree = 111320;
      final latDelta = widget.radiusInMeters / metersPerDegree;
      final lonDelta = widget.radiusInMeters /
          (metersPerDegree * cos(widget.initialPosition!.latitude * pi / 180));

      _bounds = LatLngBounds(
        LatLng(widget.initialPosition!.latitude - latDelta,
            widget.initialPosition!.longitude - lonDelta),
        LatLng(widget.initialPosition!.latitude + latDelta,
            widget.initialPosition!.longitude + lonDelta),
      );
    }
  }

  bool _isWithinRadius(LatLng point) {
    double distanceInMeters = _distance.as(
      LengthUnit.Meter,
      _centerPosition,
      point,
    );
    return distanceInMeters <= widget.radiusInMeters;
  }

  double _getZoomLevel() {
    return 19 - log(widget.radiusInMeters / 500) / log(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Verify Shop Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                      FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            initialCenter: _selectedLocation,
                            initialZoom: 18,
                            maxZoom: 18,
                            minZoom: 18,
                            initialCameraFit: CameraFit.bounds(
                                bounds: _bounds, padding: EdgeInsets.all(20)),
                            keepAlive: true,
                            interactionOptions: InteractionOptions(
                              flags: InteractiveFlag.none |
                                  InteractiveFlag.pinchZoom,
                            ),
                            onLongPress: (tapPosition, point) {
                              if (_isWithinRadius(point)) {
                                setState(() {
                                  _selectedLocation = point;
                                  widget.onLocationSelected(point);
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please select a location within 500 meters of your current position'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          ),
                          children: [
                            // TileLayer(
                            //   urlTemplate: 'https://tiles.stadiamaps.com/tiles/osm_bright/{z}/{x}/{y}.png',
                            //   additionalOptions: {
                            //     'api_key': '5a0cbc22-53b5-4b1d-a623-fe126f026e2e',
                            //   },
                            // ),
                            TileLayer(
                              urlTemplate:
                                  'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                              additionalOptions: {
                                'accessToken':
                                    '',
                                'id': 'mapbox/satellite-v9',
                              },
                            ),
                            // TileLayer(
                            //   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            //   userAgentPackageName: 'com.example.app',
                            // ),
                            CircleLayer(
                              circles: [
                                CircleMarker(
                                  point: _centerPosition,
                                  radius: widget.radiusInMeters,
                                  useRadiusInMeter: true,
                                  color: Colors.blue.withOpacity(0.2),
                                  borderColor: Colors.blue,
                                  borderStrokeWidth: 2,
                                ),
                              ],
                            ),
                            // Draw center point
                            CircleLayer(
                              circles: [
                                CircleMarker(
                                  point: _centerPosition,
                                  radius: 8,
                                  color: Colors.blue,
                                  borderColor: Colors.white,
                                  borderStrokeWidth: 2,
                                ),
                              ],
                            ),
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: _selectedLocation,
                                  width: 40,
                                  height: 40,
                                  child: Icon(
                                    Icons.location_pin,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Long press to select location',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}

class MapLocationPickerLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Loading Shop Location..',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            padding: EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  CustomProgressIndicatorWidget()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
