import 'package:bekloh_user/bloc/authbloc/authentication.dart';
import 'package:bekloh_user/bloc/authbloc/auth_bloc.dart';
import 'package:bekloh_user/bloc/loginbloc/login_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/simple_bloc_delegate.dart';
import 'package:bekloh_user/router/app_router.dart';
import 'package:bekloh_user/screen/home_screen.dart';
import 'package:bekloh_user/screen/login_screen.dart';
import 'package:bekloh_user/screen/register_screen.dart';
import 'package:bekloh_user/screen/splash_screen.dart';
import 'package:bekloh_user/screen/welcome_screen.dart';
import 'package:bekloh_user/services/auth_service.dart';
import 'package:bekloh_user/utilities/constants.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/map_bloc.dart';



void main(){
  UserRepository _userRepository=UserRepository();
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
      create: (BuildContext context) => AuthenticationCubit(userRepository: _userRepository),
    ),
    BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(userRepository: _userRepository),
    ),
    BlocProvider<MapBloc>(
        create: (BuildContext context) => MapBloc()
    ),
  ],
      child: MyApp())
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
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          //initialRoute:  BlocProvider.of<AuthenticationBloc>(context) == Uninitialized ? splashscreenRoute : loginScreenRoute,
         initialRoute: splashscreenRoute,
         onGenerateRoute: Router.generateRoute,
         builder: (context,widget){
          return BlocListener<AuthenticationCubit,AuthenticationState>(
             listener: (context, state) {
               if (state is Authenticated) {
                 _navigator.pushNamedAndRemoveUntil(homeRoute, (Route<dynamic> route) => false);
                 // return HomeScreen();
               }
               else if (state is Uninitialized) {
                  _navigator.pushNamedAndRemoveUntil(welcomeRoute, (Route<dynamic> route) => false);
                 //return WelcomeScreen();
               }
               else if (state is Unauthenticated) {
                 _navigator.pushNamedAndRemoveUntil(welcomeRoute, (Route<dynamic> route) => false);
                 // return WelcomeScreen();
               }
               //return Container();
             },
             child: widget,
           );
         } ,
        );

  }
  @override
  void dispose() {

    super.dispose();
  }

}


