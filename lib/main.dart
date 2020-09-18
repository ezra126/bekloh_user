import 'package:bekloh_user/bloc/authbloc/authentication.dart';
import 'package:bekloh_user/bloc/authbloc/auth_bloc.dart';
import 'package:bekloh_user/bloc/simple_bloc_delegate.dart';
import 'package:bekloh_user/router/app_router.dart';
import 'package:bekloh_user/services/auth_service.dart';
import 'package:bekloh_user/utilities/constants.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocDelegate();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(userRepository: UserRepository())
        ..add(
          AppStarted(),
        ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, widget) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Authenticated) {
              _navigator.pushNamedAndRemoveUntil(homeRoute, (_) => false);
            } else if (state is Uninitialized) {
              _navigator.pushNamedAndRemoveUntil(
                  splashscreenRoute, (_) => false);
            } else if (state is Unauthenticated) {
              _navigator.pushNamedAndRemoveUntil(welcomeRoute, (_) => false);
            }
          },
          child: widget,
        );
      },
      //initialRoute:  BlocProvider.of<AuthenticationBloc>(context) == Uninitialized ? splashscreenRoute : loginScreenRoute,
      // initialRoute: registerRoute,
      navigatorKey: _navigatorKey,
      onGenerateRoute: Router.generateRoute,
      initialRoute: splashscreenRoute,
    );
  }
}
