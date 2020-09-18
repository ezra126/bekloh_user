import 'package:bekloh_user/bloc/authbloc/authentication.dart';
import 'package:bekloh_user/bloc/authbloc/auth_bloc.dart';
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



void main(){
  Bloc.observer = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;
  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _authenticationBloc,
      child: Builder(
        builder: (BuildContext context){
         return  MaterialApp(
            debugShowCheckedModeBanner: false,
            //initialRoute:  BlocProvider.of<AuthenticationBloc>(context) == Uninitialized ? splashscreenRoute : loginScreenRoute,
            // initialRoute: registerRoute,
           onGenerateRoute: Router.generateRoute,
           home:  BlocBuilder(
           cubit: _authenticationBloc,
           builder: (context, state) {
             if (state is Authenticated) {
               return HomeScreen();
             }
             else if (state is Uninitialized) {
               return SplashScreen();
             }
             else if (state is Unauthenticated) {
               return WelcomeScreen();
             }
             return Container();
           },
         ),
          );
        },

      )
    );
  }
  @override
  void dispose() {
    // _authenticationBloc.close();
    super.dispose();
  }
}
