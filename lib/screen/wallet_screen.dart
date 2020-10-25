import 'package:flutter/material.dart';
import 'package:flutter_otp/flutter_otp.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  FlutterOtp otp = FlutterOtp();
  String result;
  int enteredOtp;
  TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool yesOrNo = otp.resultChecker(enteredOtp);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextField(),
              RaisedButton(
                onPressed:(){
                  otp.sendOtp(controller.text,'OTP is : ');
                } ,
                child: Text('send otp'),
              ),
              Text('Enter OTP sent to your phone'),
              TextField(
                onChanged: (val) {
                  enteredOtp = int.parse(val);
                },
              ),
              RaisedButton(
                child: Text('VERIFY'),
                onPressed: () {
                  setState(() {
                    bool yesOrNo = otp.resultChecker(enteredOtp);
                    print(yesOrNo);
                  });
                },
              ),
              Center(
                child: Text(yesOrNo.toString()),
              ),
            ],
          ),
        )
      ),
    );
  }
}

