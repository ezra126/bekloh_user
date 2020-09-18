import 'package:bekloh_user/bloc/authbloc/authentication.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _autoValidate = false;
 // final FirebaseAuth _firebaseAuth= FirebaseAuth.instance;
 // final GoogleSignIn googleSignIn = GoogleSignIn();

  /*void signInFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();

    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        //final profile = JSON.decode(graphResponse.body);
        print(graphResponse.body);
        print('login');
        final credential = FacebookAuthProvider.getCredential(
            accessToken: token);
        try {
          var result = await _firebaseAuth.signInWithCredential(credential).then((value) => {
          Navigator.pushNamed(context, homeRoute)
          });


        }
        catch(e){
          print(e);
        }
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('cancel by user ');
        break;
      case FacebookLoginStatus.error:
        print(result.errorMessage);
        break;
    }
  }

  void signInGoogle() async{
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);

    if(user != null){
      Navigator.pushNamed(context, homeRoute);
    }
  }

*/

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Material(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: _height / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF0a8cc1),
                          Color(0xFF03d7f0),
                          //  Color(0xFF08d0c4)
                        ],
                        // stops: [0.1, 0.4, 0.7, 0.9],
                        stops: [0.28, 1],
                      ),
                    ),
                  ),
                  Container(
                    height: _height / 2.2,
                    margin: EdgeInsets.only(
                        top: _height / 4.5,
                        left: _width / 11,
                        right: _width / 11),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF03d7f0),
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.only(
                              left: _width / 14.0,
                              right: _width / 14.0,
                              top: _height / 20.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  height: 45,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Email or Phone number",
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
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
                                SizedBox(
                                  height: 20,
                                ),
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
                                            Radius.circular(10)),
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
                                SizedBox(
                                  height: 10,
                                ),
                                forgetPassTextRow(),
                                SizedBox(
                                  height: 10,
                                ),
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
                                                width: _width / 3,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0)),
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
                                                    child: Text('SIGN IN')),
                                              ),
                                            ))),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: _height / 1.4,
                      left: _width / 11,
                      right: _width / 11,
                    ),
                    child: Column(
                      children: [
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
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Sign in with Social account',
                          style: TextStyle(
                              color: Color(0xFF03d7f0),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[


                            GestureDetector(
                              onTap: (){
                               // signInGoogle();
                                BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xffff4645),
                                  shape: BoxShape.circle,
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
                            SizedBox(
                              width: 30,
                            ),
                            GestureDetector(
                              onTap: (){
                                // signInFacebook();
                                // BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xff1346b4),
                                      Color(0xff0cb2eb),
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.facebookF,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Divider(thickness: 1,height: 0,),
                        SizedBox(height: 15,),
                        _buildSignupBtn()
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget forgetPassTextRow() {
    return Container(
      //margin: EdgeInsets.only(top: _height / 40.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Text.rich(
          TextSpan(
              text: 'Forgot your Password? ',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Color(0xFF03d7f0),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // code to open / launch terms of service link here
                }),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, registerRoute);
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
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
}
