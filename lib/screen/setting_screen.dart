import 'package:flutter/material.dart';


class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
                            child: Center(child: Text(
                              'Choose Language',
                              style: TextStyle(color: Colors.white),))),
                        content: Container(
                          height: 120,
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            children: [
                              /* ListTile(
                                     title: Text('English'),
                                     leading: Radio(
                                       value: Language.english,
                                       groupValue: currentLanguage,
                                       onChanged: (Language value) {
                                         setState(()
                                         {
                                           currentLanguage = value;
                                         });
                                         var english= Locale('en','US');
                                         MyApp.setLocale(context, english);

                                       },
                                     ),
                                   ),
                                   ListTile(
                                     title: Text('Amharic'),
                                     leading: Radio(
                                       value: Language.amharic,
                                       groupValue: currentLanguage,
                                       onChanged: (Language value) {
                                         setState(()
                                         {
                                           currentLanguage = value;
                                         });
                                         var amharic= Locale('am','ET');
                                         MyApp.setLocale(context,amharic);
                                       },
                                     ),
                                   ),*/
                              Expanded(
                                flex:2,
                                child: InkWell(
                                  onTap: () {
                                    var english = Locale('en', 'US');
                                   // MyApp.setLocale(context, english);
                                    Navigator.pop(context);
                                    //,
                                  },
                                  child: Container(
                                    child: Center(
                                        child: Text('English')),
                                  ),
                                ),
                              ),
                              Divider(height: 10,thickness: 2,),
                              Expanded(
                                flex:2,
                                child: InkWell(
                                    onTap: () {
                                      var amharic = Locale('am', 'ET');
                                    //  MyApp.setLocale(context, amharic);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      child: Center(
                                          child: Text('language')
                                      ),
                                    )),
                              ),
                              Divider(height: 0,thickness: 2,),
                              SizedBox(height: 20,),
                              Expanded(
                                  flex:1,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: (){Navigator.pop(context);},
                                      child: Text('back'),),
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
                  padding: EdgeInsets.only(left: 20,top: 15,bottom: 15),
                  child: Row(
                    children: [
                      Icon(Icons.language),
                      SizedBox(width: 10,),
                      Text('Change Language'),
                    ],
                  ),
                )
            ),
            Divider(height: 0,),
            InkWell(
              onTap: (){},
              child: Padding(
                padding: EdgeInsets.only(left: 20,top: 15,bottom: 15),
                child: Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(width: 10,),
                    Text('Change Password'),
                  ],
                ),
              ),
            ),
            Divider(height: 0,),
            Padding(
              padding: EdgeInsets.only(left: 25,top: 15,bottom: 15, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Push Notification'),
                  Text('ho'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
