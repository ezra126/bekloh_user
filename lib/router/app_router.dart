import 'package:bekloh_user/screen/home_screen.dart';
import 'package:bekloh_user/screen/login_screen.dart';
import 'package:bekloh_user/screen/register_screen.dart';
import 'package:bekloh_user/screen/welcome_screen.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:bekloh_user/screen/splash_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashscreenRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case loginScreenRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
