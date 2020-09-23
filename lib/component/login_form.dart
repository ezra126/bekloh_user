import 'package:bekloh_user/bloc/authbloc/auth_bloc.dart';
import 'package:bekloh_user/bloc/authbloc/auth_state.dart';
import 'package:bekloh_user/bloc/loginbloc/login_bloc.dart';
import 'package:bekloh_user/bloc/loginbloc/login_event.dart';
import 'package:bekloh_user/bloc/loginbloc/login_state.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _autoValidate = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    // TODO: implement initState
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
       // print(state);
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Login Failure'), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationCubit>(context).loggedIn();
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, LoginState state) {
            return Stack(
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
                        height: 10,
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
                          //key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                height: 45,
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: "Email or Phone number",
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  autovalidate: true,
                                  autocorrect: false,
                                  validator: (_) {
                                    return !state.isEmailValid ? 'Invalid Email' : null;
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
                                  controller: _passwordController,
                                  obscureText: _passwordVisible ? false : true,
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
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  autovalidate: true,
                                  autocorrect: false,
                                  validator: (_) {
                                    return !state.isPasswordValid ? 'Invalid Email' : null;
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
                                  onPressed: isLoginButtonEnabled(state)
                                      ? _onFormSubmitted
                                      : null,
                                  textColor: Colors.white,
                                  color: Color(0xFF03d7f0),
                                  //disabledColor: btnEnabled == false ? Colors.blueGrey : null,
                                  child: Builder(
                                      builder: (context) => InkWell(
                                            onTap: null,
                                            child: Container(
                                              width: _width / 3,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)),
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
                            onTap: () {
                              // signInGoogle();
                              // BlocProvider.of<AuthenticationCubit>(context).loggedIn();
                              BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
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
                            onTap: () {
                              // signInFacebook();
                              // BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
                             // BlocProvider.of<LoginBloc>(context).add(LoginWithGooglePressed());
                             // print('uuuu');
                              BlocProvider.of<AuthenticationCubit>(context).loggedIn();
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
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      _buildSignupBtn()
                    ],
                  ),
                )
              ],
            );
          }),
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

  void _onEmailChanged() {
    BlocProvider.of<LoginBloc>(context)
        .add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    BlocProvider.of<LoginBloc>(context)
        .add(PasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    BlocProvider.of<LoginBloc>(context).add(LoginWithCredentialsPressed(
      email: _emailController.text,
      password: _passwordController.text,
    ));
  }
}


