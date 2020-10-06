

import 'package:bekloh_user/localization/app_localization.dart';
import 'package:bekloh_user/main.dart';
import 'package:flutter/material.dart';

enum Language { amharic, english }
class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool pushNotification = false;
  bool nightMode=false;
  Language currentLanguage = Language.english;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Setting',
            style: TextStyle(color: Colors.blue),
          )),
      body: Container(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        titlePadding: EdgeInsets.symmetric(vertical: 0),
                        title: Container(
                            height: 50,
                            color: Colors.blue,
                            child: Center(
                                child: Text(
                                  AppLocalization.of(context).getTranslateValue('choose language'),
                              style: TextStyle(color: Colors.white),
                            ))),
                        content: Container(
                          height: 120,
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    var english = Locale('en', 'US');
                                    MyApp.setLocale(context, english);
                                    Navigator.pop(context);
                                    //,
                                  },
                                  child: Container(
                                    child: Center(child: Text('English')),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 10,
                                thickness: 2,
                              ),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                    onTap: () {
                                      var amharic = Locale('am', 'ET');
                                       MyApp.setLocale(context, amharic);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      child: Center(child: Text('Amharic')),
                                    )),
                              ),
                              Divider(
                                height: 0,
                                thickness: 2,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('back'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                  child: Row(
                    children: [
                      Icon(Icons.language),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Change Language'),
                    ],
                  ),
                )),
            Divider(
              height: 0,
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                child: Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Change Password'),
                  ],
                ),
              ),
            ),
            Divider(
              height: 0,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 25, top: 2, bottom: 2, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Push Notification'),
                  Transform.scale(
                    scale: 1.5,
                    child: Switch(
                      value: pushNotification,
                      onChanged: (value){
                        setState(() {
                          pushNotification=value;
                          // print(isSwitched);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 0,
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 25, top: 2, bottom: 2, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Night Mode'),
                  Transform.scale(
                    scale: 1.5,
                    child: Switch(
                      value: nightMode,
                      onChanged: (value){
                        setState(() {
                          nightMode=value;
                         // print(isSwitched);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}
