import 'dart:async';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Image mainLogo;
  bool isLoaded = false;
  bool hasInternet;
  bool isChecking;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  AnimationController _BottomSheetcontroller;

  @override
//  bool get wantKeepAlive => true;
  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((connectionResult) {
      if (connectionResult == ConnectivityResult.wifi) {
        setState(() {
          hasInternet = true;
          isChecking = true;
        });
        Timer(
          Duration(seconds: 5),
          () => Navigator.of(context)
              .pushNamedAndRemoveUntil(welcomeRoute, (_) => false),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      Timer(
        Duration(seconds: 5),
        () => Navigator.of(context)
            .pushNamedAndRemoveUntil(welcomeRoute, (_) => false),
      );
    } else if (connectivityResult == ConnectivityResult.none) {
      Timer(Duration(seconds: 3), () {
        setState(() {
          hasInternet = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    /* Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),*/
                    Color(0xFF0a8cc1),
                    Color(0xFF03d7f0),
                    Color(0xFF08d0c4)
                  ],
                  // stops: [0.1, 0.4, 0.7, 0.9],
                  stops: [0.28, 0.7, 1],
                ),
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(0.0),
                            margin: EdgeInsets.all(0.0),
                            width: 100,
                            height: 150,
                            child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.lightBlue, BlendMode.modulate),
                                child: mainLogo)),
                        SizedBox(
                          height: 0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Text(
                            'Bekloh',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Center(
                          child: hasInternet == false
                              ? Container()
                              : CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ))),
                ],
              ),
            )
          ],
        ),
        bottomSheet: hasInternet == false
            ? BottomSheet(
                animationController: _BottomSheetcontroller,
                elevation: 1,
                enableDrag: false,
                onClosing: () {},
                builder: (_) {
                  return Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('No internet connection'),
                          InkWell(
                            onTap: () {
                              checkInternet();
                            },
                            child: Text('RETRY'),
                          )
                        ],
                      ),
                    ),
                  );
                })
            : isChecking == true
                ? BottomSheet(
                    animationController: _BottomSheetcontroller,
                    enableDrag: false,
                    onClosing: () {},
                    builder: (_) {
                      return Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text('Connecting ...'),
                          ));
                    })
                : null,
      ),
    );
  }

  void checkInternet() {
    setState(() {
      hasInternet = null;
    });
    Timer(Duration(milliseconds: 400), () {
      setState(() {
        isChecking = true;
      });
    });

    Timer(Duration(seconds: 4), () {
      setState(() {
        isChecking = false;
      });
    });

    Timer(Duration(seconds: 4, milliseconds: 500), () {
      setState(() {
        hasInternet = false;
      });
    });
  }
}
