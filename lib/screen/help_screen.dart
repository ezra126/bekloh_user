import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  AssetImage assetImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    assetImage = AssetImage('assets/callcenter.jpg');
    precacheImage(assetImage, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(top: 20),
                height: 200,
                child: Center(child: Image(image: assetImage))),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                  launch('tel:+1 555 010 999');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Icon(Icons.call),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Call Us')
                  ],
                ),
              ),
            ),
            Divider(
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            GestureDetector(
              onTap: () async {
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
                                "Choose Title",
                                style: TextStyle(color: Colors.white),
                              ))),
                      content: Container(
                        height:350,
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                onTap: () {
                                  _sendMail('Driver attitude');
                                  //,
                                },
                                child: Container(
                                  child: Center(child: Text('Driver attitude')),
                                ),
                              ),
                            ),
                            Divider(height: 10, thickness: 2,),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                  onTap: () {
                                    _sendMail('Item Lost');
                                  },
                                  child: Container(
                                    child: Center(child: Text('Item Lost')),
                                  )),
                            ),
                            Divider(height: 0, thickness: 2,),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                  onTap: () {
                                    _sendMail('Bekloh App');
                                  },
                                  child: Container(
                                    child: Center(child: Text('Bekloh App')),
                                  )),
                            ),
                            Divider(height: 0, thickness: 2,),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                  onTap: () {
                                    _sendMail('Complaint');
                                  },
                                  child: Container(
                                    child: Center(child: Text('Complaint')),
                                  )),
                            ),
                            Divider(height: 0, thickness: 2,),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                  onTap: () {
                                    _sendMail('Compliment');
                                  },
                                  child: Container(
                                    child: Center(child: Text('Compliment')),
                                  )),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                  onTap: () {
                                    _sendMail('Advice');
                                  },
                                  child: Container(
                                    child: Center(child: Text('Advice')),
                                  )),
                            ),
                            Divider(
                              height: 0,
                              thickness: 2,
                            ),
                            Expanded(
                              flex: 2,
                              child: InkWell(
                                  onTap: () {
                                    _sendMail('other');
                                  },
                                  child: Container(
                                    child: Center(child: Text('other')),
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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Email Us')
                  ],
                ),
              ),
            ),
            Divider(
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Terms and Conditions'))),
            Divider(
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Privacy Policy'))),
            Divider(
              height: 0,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Join us on Telegram'))),
          ],
        ),
      ),
    );
  }

  _sendMail(String title) async{
    print('lauch');
     var uri = 'mailto:israelgetahun25@gmail.com?subject=$title&body=Hello%20World';
    if (await canLaunch(uri)) {
    await launch(uri);
    } else {
    throw 'Could not launch $uri';
    }
  }
}

