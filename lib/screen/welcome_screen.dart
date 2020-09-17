//import 'package:charts_flutter/flutter.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  ImageProvider imageProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0a8cc1),
                      Color(0xFF03d7f0),
                      Color(0xFF08d0c4)
                    ],
                    // stops: [0.1, 0.4, 0.7, 0.9],
                    stops: [0.28, 0.7, 1],
                  ),
                  // image: DecorationImage(
                  //colorFilter:ColorFilter.mode(Colors.white, BlendMode.darken),
                  // image: AssetImage('assets/images/packing.jpg'),
                  // fit: BoxFit.fill,
                  //  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*.3,left:  MediaQuery.of(context).size.width*.36),
                child: Text(
                  'Bekloh',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height* .05,left: MediaQuery.of(context).size.width*0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, loginScreenRoute);
                      },
                      shape: StadiumBorder(),
                      textColor: Colors.lightBlue,
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width*.7,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('SIGN IN'),
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, registerRoute);
                      },
                      shape: StadiumBorder(),
                      textColor: Colors.lightBlue,
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width*.7,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text('REGISTER'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
