import 'package:complaintsapp/presentation/complaints/complaint_list.dart';
import 'package:complaintsapp/presentation/home/home.dart';
import 'package:complaintsapp/presentation/login/login.dart';
import 'package:complaintsapp/presentation/login/widgets/phone_number_input_page.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String phone = '/phone';
  static const String home = '/home';
  static const String complaints = '/complaints';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    //complaints: (BuildContext context) => ComplaintListScreen(),
    phone: (context) => PhoneNumberInputPage(),
  };
}
