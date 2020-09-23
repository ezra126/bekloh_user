import 'package:bekloh_user/bloc/authbloc/authentication.dart';
import 'package:bekloh_user/bloc/loginbloc/login_bloc.dart';
import 'package:bekloh_user/bloc/loginbloc/login_event.dart';
import 'package:bekloh_user/bloc/loginbloc/login_state.dart';
import 'package:bekloh_user/component/login_form.dart';
import 'package:bekloh_user/services/auth_service.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: LoginForm()
            )),
      ),
    );
  }
}
