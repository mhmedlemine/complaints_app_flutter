import 'package:complaintsapp/data/sharedpref/constants/preferences.dart';
import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/presentation/checkups/pages/checkup_list_screen.dart';
import 'package:complaintsapp/presentation/checkups/pages/summon_list_screen.dart';
import 'package:complaintsapp/presentation/complaints/complaint_list.dart';
import 'package:complaintsapp/presentation/login/store/login_store.dart';
import 'package:complaintsapp/presentation/shop/entreprise_list.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:complaintsapp/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {

  final UserStore _userStore = getIt<UserStore>();

  CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            UserAccountsDrawerHeader(
              accountName: Text('${_userStore.user?.name}'),
              accountEmail: Text('${_userStore.user?.phonenumber}'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Icon(Icons.person, size: 50),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
      
      
            // ListTile(
            //   leading: const Icon(Icons.report),
            //   title: Text(AppLocalizations.of(context).translate('drawer_my_complaints')),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => ComplaintListScreen()));
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.edit_document),
              title: Text(AppLocalizations.of(context).translate('drawer_my_checkups')),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => CheckupListScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.gavel),
              title: Text(AppLocalizations.of(context).translate('drawer_my_summons')),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SummonListScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pin_drop),
              title: Text(AppLocalizations.of(context).translate('drawer_my_registred_shops')),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => EntrepriseListScreen()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text(AppLocalizations.of(context).translate('drawer_logout')),
              onTap: () {
                SharedPreferences.getInstance().then((preference) {
                  preference.setBool(Preferences.is_logged_in, false);
                  preference.remove(Preferences.user);
                  preference.remove(Preferences.auth_token);
                  Navigator.of(context).pushReplacementNamed(Routes.login);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}