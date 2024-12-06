import 'package:complaintsapp/core/widgets/big_action_button_widget.dart';
import 'package:complaintsapp/core/widgets/custom_drawer.dart';
import 'package:complaintsapp/data/sharedpref/constants/preferences.dart';
import 'package:complaintsapp/di/service_locator.dart';
import 'package:complaintsapp/presentation/checkups/pages/add_checkup.dart';
import 'package:complaintsapp/presentation/checkups/pages/start_checkup_screen.dart';
import 'package:complaintsapp/presentation/complaints/complaint_details.dart';
import 'package:complaintsapp/presentation/complaints/complaint_form_screen.dart';
import 'package:complaintsapp/presentation/complaints/complaint_list.dart';
import 'package:complaintsapp/presentation/home/store/language/language_store.dart';
import 'package:complaintsapp/presentation/home/store/theme/theme_store.dart';
import 'package:complaintsapp/presentation/home/update_password.dart';
import 'package:complaintsapp/presentation/login/store/login_store.dart';
import 'package:complaintsapp/presentation/shop/add_entreprise.dart';
import 'package:complaintsapp/utils/dialogs/dialog_utils.dart';
import 'package:complaintsapp/utils/locale/app_localization.dart';
import 'package:complaintsapp/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  //stores:---------------------------------------------------------------------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();
  final UserStore _userStore = getIt<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: CustomDrawer(),
      body: _buildBody(), //PostListScreen(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('home_tv_posts')),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildLanguageButton(),
      // _buildThemeButton(),
      _buildLogoutButton(),
    ];
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          preference.remove(Preferences.user);
          preference.remove(Preferences.auth_token);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: Icon(
        Icons.power_settings_new,
      ),
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
      ),
    );
  }

  _buildLanguageDialog() async {
    final lang = await DialogUtils.buildLanguageBottomsheet(
      context: context,
      languageStore: _languageStore,
      vsync: this,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUser(),
            Wrap(
              children: [
                BigActionButton(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AddEntrepriseScreen()));
                  },
                  text: AppLocalizations.of(context).translate('home_add_shop'),
                  icon: Icons.house_outlined,
                ),
                BigActionButton(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => StartCheckupScreen()));
                  },
                  text: 'Run Checkup',
                  icon: Icons.checklist_outlined,
                  iconBgColor: Colors.pink,
                ),
                BigActionButton(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => (ComplaintFormScreen())));
                  },
                  text: 'Report Complaint',
                  icon: Icons.checklist_outlined,
                  iconBgColor: Colors.pink,
                ),
              ],
            ),

            //         );
            //     }),
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.all(8),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Latest Summons', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
            //       TextButton(onPressed: (){}, child: Text('All',))
            //     ],
            //   ),
            // ),
            // Container(
            //   child: Column(
            //     children: List.generate(2, (int index) {
            //       return ListTile(
            //         onTap: () {},
            //         title: Text("Summon #00001 for Boutique Test #02${index}"),
            //         subtitle: Wrap(
            //           children: [
            //             Text("Fraction: "),
            //             Text("Expired merchendise", style: TextStyle(fontWeight: FontWeight.bold)),
            //           ],
            //         ),

            //         );
            //     }),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildUser() {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (_) => UpdatePasswordScreen()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * .14,
              width: MediaQuery.of(context).size.width * .9,
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * .05),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * .02,
                vertical: MediaQuery.of(context).size.height * .02,
              ),
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  Icon(Icons.person,
                      size: MediaQuery.of(context).size.height * .07),
                  SizedBox(width: MediaQuery.of(context).size.width * .03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bonjour,',
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * .012),
                      ),
                      Text(
                        '${_userStore.user?.name}',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * .022,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${_userStore.user?.phonenumber}',
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.height * .015),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
