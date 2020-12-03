import 'package:bekloh_user/bloc/authbloc/authentication.dart';
import 'package:bekloh_user/bloc/authbloc/auth_bloc.dart';
import 'package:bekloh_user/bloc/loginbloc/login_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/simple_bloc_delegate.dart';
import 'package:bekloh_user/localization/app_localization.dart';
import 'package:bekloh_user/router/app_router.dart';
import 'package:bekloh_user/screen/home_screen.dart';
import 'package:bekloh_user/screen/login_screen.dart';
import 'package:bekloh_user/screen/register_screen.dart';
import 'package:bekloh_user/screen/splash_screen.dart';
import 'package:bekloh_user/screen/welcome_screen.dart';
import 'package:bekloh_user/services/OrderService/order_repository.dart';
import 'package:bekloh_user/services/auth_service.dart';
import 'package:bekloh_user/utilities/constants.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/map_bloc.dart';
import 'bloc/navigationbloc/navigation_bloc.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  UserRepository _userRepository = UserRepository();
  OrderRepository orderRepository=OrderRepository();
  Bloc.observer = SimpleBlocDelegate();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<DeliveryBookingBloc>(
      create: (BuildContext context) => DeliveryBookingBloc(),
    ),
    /*BlocProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(userRepository: UserRepository())
      ..add(AppStarted()),
    ),*/
    BlocProvider<AuthenticationCubit>(
      create: (BuildContext context) =>
          AuthenticationCubit(userRepository: _userRepository),
    ),
    BlocProvider<LoginBloc>(
      create: (BuildContext context) =>
          LoginBloc(userRepository: _userRepository),
    ),
    BlocProvider<MapBloc>(create: (BuildContext context) => MapBloc()),
    BlocProvider<NavigationBloc>(create: (BuildContext context) => NavigationBloc()),
  ], child:  MultiRepositoryProvider(
      providers: [
        RepositoryProvider<OrderRepository>(
          create: (context) => orderRepository,
        ),
      ],
      child: MyApp())));
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context,Locale locale){
    context.findAncestorStateOfType<_MyAppState>().setLocale(locale);
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState;
  Locale _locale;
  static const String _selectedLocaleKey = 'selected_locale';
  void setLocale(Locale locale) async{
    await savePreferredLocale(locale);
    setState(() {
      _locale=locale;
    });
  }

  Future getPreferredLocale() async{
    final preferences = await SharedPreferences.getInstance();

    if(!preferences.containsKey(_selectedLocaleKey)) return null;
    var languagecode = preferences.getString(_selectedLocaleKey);
    if(languagecode == Locale('en','US').languageCode) {
      setState(() {
        _locale = Locale('en', 'US');
      });
    }
    if(languagecode == Locale('am','ET').languageCode) {
      setState(() {
        _locale = Locale('am','ET');
      });
    }
  }

  Future savePreferredLocale(Locale locale) async
  {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_selectedLocaleKey, locale.languageCode );
  }

  @override
  void initState() {
    getPreferredLocale();
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      title: 'Bekloh',
      //initialRoute:  BlocProvider.of<AuthenticationBloc>(context) == Uninitialized ? splashscreenRoute : loginScreenRoute,
      initialRoute: splashscreenRoute,
      onGenerateRoute: Router.generateRoute,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en','US'),
        Locale('am','ET'),
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales){
        for(var locale in supportedLocales){
          if(locale.languageCode ==deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode){
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      locale: _locale,
      builder: (context, widget) {
        return BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            if (state is Authenticated) {
              _navigator.pushNamedAndRemoveUntil(
                  homeRoute, (Route<dynamic> route) => false);
              // return HomeScreen();
            } else if (state is Uninitialized) {
              _navigator.pushNamedAndRemoveUntil(
                  splashscreenRoute, (Route<dynamic> route) => false);
              //return WelcomeScreen();
            } else if (state is Unauthenticated) {
              _navigator.pushNamedAndRemoveUntil(
                  welcomeRoute, (Route<dynamic> route) => false);
              // return WelcomeScreen();
            }
            //return Container();
          },
          child: widget,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
