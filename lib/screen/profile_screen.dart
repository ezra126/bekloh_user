import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  //ProfileScreen({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        // overflow: Overflow.visible,
        children: <Widget>[
          Container(
            color: Colors.blue[600],
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(
                  left: _width * .1, top: _height * .1, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          child: CircleAvatar(),
                          height: _height * .13,
                          width: _width * .28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          )),
                      SizedBox(
                        width: _width * .1 / 3,
                      ),
                      Text(
                        'Israel Getahun',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  SizedBox(
                    height: _height * .05,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: _width * .09, right: _width * .09),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: <Widget>[
                            Text(
                              "10.2K",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Wallet",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "10.2K",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Promo",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "10.2K",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rate",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )

                  // SizedBox(width: 5 * SizeConfig.widthMultiplier,),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .4),
            child: Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .05,
                  right: MediaQuery.of(context).size.width * .05),
              child: Container(
                padding: EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Israel',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        labelText: '0929416014',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'email',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
