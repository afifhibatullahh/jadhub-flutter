import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:jadhub_flutter/res/routes.dart';
import 'package:jadhub_flutter/ui/pages/home_page.dart';
import 'package:jadhub_flutter/ui/pages/splash_screen.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dynamic token = FlutterSession().get('token');
  runApp(MaterialApp(
    home: token == '' ? SplashScreen() : HomePage(),
    title: 'JadHub Calendar',
    theme: ThemeData(
      fontFamily: 'Poppins',
      primarySwatch: Colors.blue,
    ),
    debugShowCheckedModeBanner: false,
    onGenerateRoute: AppRoutes.onGenerateRoute,
  ));
}
