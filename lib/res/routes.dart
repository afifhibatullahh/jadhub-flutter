import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jadhub_flutter/ui/pages/add_event.dart';
import 'package:jadhub_flutter/ui/pages/home_page.dart';
import 'package:jadhub_flutter/ui/pages/login_screen.dart';
import 'package:jadhub_flutter/ui/pages/splash_screen.dart';
import 'package:jadhub_flutter/ui/pages/view_event.dart';


class AppRoutes{
  static const home = "/";
  static const splash = "splash";
  static const login = "login";
  static const String addEvent = "add_event";
  static const String editEvent = "edit_event";
  static const String viewEvent = "view_event";

  static Route<dynamic> onGenerateRoute(RouteSettings settings){
    return MaterialPageRoute(
      settings: settings,
      builder: (_) {
        switch (settings.name) {
          case editEvent:
            return AddEventPage(note: settings.arguments);
          case viewEvent:
            return EventDetailsPage(event: settings.arguments);
          case addEvent:
            return AddEventPage();
          case home:
            return HomePage();
          case login:
            return LoginScreen();
          default: 
            return SplashScreen();
        }
      }
    );
  }
}

