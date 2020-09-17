import 'package:bekloh_user/utilities/constants.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  String dialcode;
  bool checkBoxValue = false;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF03d7f0),
        elevation: 10,
        centerTitle: true,
        title: Text('Create Account'),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 20,right: 20,left: 20),
          child: Column(
            children: [
              Row(children: [
                GestureDetector(
                  onTap: (){
                    //signInGoogle();
                  },
                  child: Container(
                    width: _width/2.45,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff1346b4),
                          Color(0xff0cb2eb),
                        ],
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.facebook,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: _width/15,),
                GestureDetector(
                  onTap: (){
                    //signInGoogle();
                  },
                  child: Container(
                    width: _width/2.45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Color(0xffff4645),
                      shape: BoxShape.rectangle,
                    ),
                    child: Center(
                      child: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
              ),
              SizedBox(height: _height/25,),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                        thickness: 1,
                        endIndent: 10,
                      )),
                  Text(
                    "OR",
                    style: TextStyle(color: Color(0xFF03d7f0)),
                  ),
                  Expanded(
                      child: Divider(
                        thickness: 1,
                        indent: 10,
                      )),
                ],
              ),
              SizedBox(height: _height/25,),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                      children: [
                        Container(
                          width: _width/2.4,
                          height: 45,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "First Name",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                              ),
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return "Email cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                        SizedBox(width: _width/20,),
                        Container(
                          width: _width/2.4,
                          height: 45,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(5)),
                              ),
                              //fillColor: Colors.green
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return "Email cannot be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        )
                      ],
                        ),
                      SizedBox(height: _height/40,),
                      Container(
                        height: 45,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Email",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Email cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),

                      SizedBox(height: _height/40,),
                      Container(
                        height: 45,
                        child: TextFormField(

                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                            ),
                            prefixIcon: Container(
                              width: 55,
                              margin: EdgeInsets.only(top: 5),
                              child: CountryCodePicker(
                                padding: EdgeInsets.only(left: 5),
                                textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                initialSelection: '+251',
                                showFlag: false,
                                onInit:(code) {
                                  dialcode = code.dialCode;
                                },
                                onChanged: (code) {
                                  setState(() {
                                    dialcode = code.dialCode;
                                  });
                                },

                                favorite: ['+251', 'ET'],
                              ),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Email cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),

                      SizedBox(height: _height/40,),
                      Container(
                        height: 45,
                        child: TextFormField(
                          obscureText:
                          _passwordVisible ? false : true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xFF03d7f0),
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible =
                                  !_passwordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(5)),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val.length == 0) {
                              return "Email cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                      SizedBox(height: _height/70,),
                      acceptTermsTextRow(),
                      RaisedButton(
                          disabledColor: Colors.blueGrey,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(0),
                          onPressed: () => {
                            // if(_formKey.currentState.validate()){}
                          },
                          textColor: Colors.white,
                          color: Color(0xFF03d7f0),
                          //disabledColor: btnEnabled == false ? Colors.blueGrey : null,
                          child: Builder(
                              builder: (context) => InkWell(
                                onTap: () async {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            10.0)),
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        // Color(0xFF0a8cc1),
                                        Color(0xFF03d7f0),
                                        Color(0xFF08d0c4)
                                      ],
                                    ),
                                  ),
                                  padding:
                                  const EdgeInsets.all(10.0),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text('SIGN UP')),
                                ),
                              ))),
                      SizedBox(height: 20,),
                      Divider(thickness: 2,),
                      SizedBox(height: 15,),
                      _buildSignInBtn()
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ) ,
    );
  }

  Widget _buildSignInBtn() {
    return GestureDetector(
      onTap: () {
         Navigator.pushNamed(context, loginScreenRoute);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Color(0xFF03d7f0),
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget acceptTermsTextRow() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.orange[200],
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12 ),
          ),
        ],
      ),
    );
  }
}

