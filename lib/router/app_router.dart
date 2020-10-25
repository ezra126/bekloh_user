import 'package:bekloh_user/screen/add_destination.dart';
import 'package:bekloh_user/screen/choose_vechile_and_payment.dart';
import 'package:bekloh_user/screen/delivery_item_detail.dart';
import 'package:bekloh_user/screen/home_screen.dart';
import 'package:bekloh_user/screen/login_screen.dart';
import 'package:bekloh_user/screen/profile_screen.dart';
import 'package:bekloh_user/screen/register_screen.dart';
import 'package:bekloh_user/screen/select_location_screen.dart';
import 'package:bekloh_user/screen/setting_screen.dart';
import 'package:bekloh_user/screen/support_screen.dart';
import 'package:bekloh_user/screen/wallet_screen.dart';
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
      case supportRoute :
        return MaterialPageRoute(builder: (_) => SupportScreen());
      case profileRoute:
        return MaterialPageRoute(builder: (_) =>  ProfileScreen());
      case settingRoute:
        return MaterialPageRoute(builder: (_) =>  SettingScreen());
      case PackageDetailRoute:
        return MaterialPageRoute(builder: (_) =>  PackageDetailScreen());
      case addDestinationRoute:
        return MaterialPageRoute(builder: (_) =>  AddDestinationScreen());
      case  chooseVechileAndPaymentRoute:
        return MaterialPageRoute(builder: (_) =>  ChooseVechileAndPaymentScreen());
      case walletRoute:
        return MaterialPageRoute(builder: (_) =>  WalletScreen());
      case selectLocationRoute:
        return MaterialPageRoute(builder: (_) => SelectLocationScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
