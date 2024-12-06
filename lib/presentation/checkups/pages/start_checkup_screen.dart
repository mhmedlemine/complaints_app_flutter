import 'package:complaintsapp/core/widgets/progress_indicator_widget.dart';
import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/presentation/checkups/pages/checkup_form_screen.dart';
import 'package:complaintsapp/presentation/shop/add_entreprise.dart';
import 'package:flutter/material.dart';
import 'package:complaintsapp/presentation/checkups/store/checkup_store.dart';
import 'package:complaintsapp/core/services/location_service.dart';
import 'package:complaintsapp/utils/dialogs/dialog_utils.dart';

class StartCheckupScreen extends StatefulWidget {
  @override
  _StartCheckupScreenState createState() => _StartCheckupScreenState();
}

class _StartCheckupScreenState extends State<StartCheckupScreen> {
  final LocationService _locationService = LocationService();
  final CheckupStore _checkupStore = getIt<CheckupStore>();

  @override
  void initState() {
    super.initState();
    _initializeCheckup();
  }

  Future<void> _initializeCheckup() async {
    try {
      final position = await _locationService.getCurrentPosition();
      await _startCheckup(position!.latitude, position.longitude);
    } catch (e) {
      if (mounted) {
        DialogUtils.buildInfoDialog(
          context: context,
          title: 'Location Error',
          msg: 'Unable to get location. Please try again.',
        );
      }
    }
  }

  Future<void> _startCheckup(double lat, double lon) async {
    try {
      await _checkupStore.startCheckup(
        type: 'regular',
        lat: lat,
        lon: lon,
      );
      
      if (_checkupStore.currentCheckup == null) {
        if (mounted) {
          final res = await DialogUtils.buildActionDialog(
            context: context,
            title: 'No Enterprise Found',
            msg: 'No registered enterprise found at this location. Would you like to add one?',
            confirmBtnText: 'Add Enterprise',
            cancelBtnText: 'Cancel',
          );
          if (res == true) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => AddEntrepriseScreen(),
              ),
            );
          } else {
              Navigator.pop(context);
          }
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CheckupFormScreen(
                checkup: _checkupStore.currentCheckup!,
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        DialogUtils.buildInfoDialog(
          context: context,
          title: 'Error',
          msg: 'Failed to start checkup. Please try again.',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomProgressIndicatorWidget(),
      ),
    );
  }
}