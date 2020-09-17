import 'package:bekloh_user/bloc/authbloc/authentication.dart';
import 'package:bekloh_user/router/app_router.dart';
import 'package:bekloh_user/services/auth_service.dart';
import 'package:bekloh_user/utilities/constants.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';



void main(){
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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _authenticationBloc,
      child: BlocBuilder(
        cubit: _authenticationBloc,
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: splashscreenRoute,
            // initialRoute: registerRoute,
            onGenerateRoute: Router.generateRoute,
          );
        },

      ),
    );
  }
}
