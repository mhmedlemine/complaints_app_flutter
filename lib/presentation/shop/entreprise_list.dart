import 'package:another_flushbar/flushbar_helper.dart';
import 'package:complaintsapp/core/widgets/image_preview_widget.dart';
import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
import 'package:complaintsapp/data/network/constants/endpoints.dart';
import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/domain/entity/shop/entreprise.dart';
import 'package:complaintsapp/presentation/shop/add_entreprise.dart';
import 'package:complaintsapp/presentation/shop/store/shop_store.dart';
import 'package:complaintsapp/utils/device/device_utils.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EntrepriseListScreen extends StatefulWidget {
  @override
  _EntrepriseListScreenState createState() => _EntrepriseListScreenState();
}

class _EntrepriseListScreenState extends State<EntrepriseListScreen> {
  //stores:---------------------------------------------------------------------
  final ShopStore _shopStore = getIt<ShopStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_shopStore.loading) {
      _shopStore.getMyEntreprises();
    }
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'open':
        return Colors.green;
      case 'summoned':
        return Colors.orange;
      case 'closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status) {
      case 'open':
        return 'Open';
      case 'summoned':
        return 'Summoned';
      case 'closed':
        return 'Closed';
      default:
        return 'Unknown';
    }
  }

  Widget _buildCheckupCard(Entreprise entreprise) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(entreprise.status),
                child: Icon(
                  entreprise.status == 'open'
                      ? Icons.check
                      : entreprise.status == 'summoned'
                          ? Icons.warning
                          : Icons.cancel,
                  color: Colors.white,
                ),
              ),
              title: Text(
                entreprise.name ?? 'Unknown Enterprise',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Wrap(
                direction: Axis.vertical,
                children: [
                  Text(
                    entreprise.address ?? 'No address',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Wrap(
                    children: [
                      Text('Code: '),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .6,
                        child: Text(
                          '${entreprise.code}',
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _getStatusText(entreprise.status),
                    style: TextStyle(
                      color: _getStatusColor(entreprise.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (true) ...[
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    Divider(
                      color: Colors.grey[300],
                    ),
                    IconButton(
                      onPressed: () => DeviceUtils.makePhoneCall(
                          entreprise.contact_number ?? ''),
                      icon: Icon(Icons.call),
                    ),
                    IconButton(
                      onPressed: () => DeviceUtils.openLocation(
                        latitude: entreprise.lat!,
                        longitude: entreprise.lon!,
                        label: entreprise.name,
                      ),
                      icon: Icon(Icons.map),
                    ),
                    if (entreprise.picture != null)
                      IconButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ImagePreview(
                              imageUrl:
                                  '${Endpoints.mainUrl}/storage/${entreprise.picture!.file_path}',
                            ),
                          ),
                        ),
                        icon: Icon(Icons.picture_in_picture),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shops'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _shopStore.getMyEntreprises();
        },
        child: Observer(
          builder: (context) {
            if (_shopStore.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (_shopStore.entrepriseList?.entreprises == null ||
                _shopStore.entrepriseList!.entreprises!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No Shops found',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () async {
                        await _shopStore.getMyEntreprises();
                      },
                      child: Text('Refresh'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: _shopStore.entrepriseList?.entreprises!.length,
              itemBuilder: (context, index) {
                final entreprise =
                    _shopStore.entrepriseList!.entreprises![index];
                return _buildCheckupCard(entreprise);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddEntrepriseScreen()));
        },
        child: Icon(Icons.add),
        tooltip: 'Register New Shop',
      ),
    );
  }
}
