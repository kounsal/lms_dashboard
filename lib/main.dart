import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_admin/theme/app_theme.dart';
import 'package:lms_admin/ui/admin_revenue/admin_revenue_view.dart';
import 'package:lms_admin/ui/dashboard/dashboard_view.dart';
import 'package:lms_admin/ui/sign-in/sign_In_view.dart';
import 'package:lms_admin/ui/splash/splash_view.dart';


void main() {
  runApp(const LmsAdmin());
}

class LmsAdmin extends StatelessWidget {
  const LmsAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LmsAdmin',
      theme: Themes.appThemeData,
      home: SplashView(),
    );
  }
}