import 'package:bekloh_user/bloc/authbloc/auth_bloc.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
        elevation: 10,
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              InkWell(
                  onTap: (){
                    Navigator.pushNamed(context,profileRoute);
                  },
                  child: CustomListTile(frontIcon: Icons.person, text: ('Profile'))),
              InkWell(
                  onTap: (){
                    Navigator.pushNamed(context,walletRoute);
                  },
                  child: CustomListTile(frontIcon: Icons.payment, text: ('Wallet'))),
              InkWell(
                  onTap: (){
                    Navigator.pushNamed(context,settingRoute);
                  },
                  child: CustomListTile(frontIcon: Icons.settings, text: ('Setting'))),
              InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, notificationRoute);
                  },
                  child: CustomListTile(frontIcon: Icons.notifications, text: ('Notification'))),
              InkWell(
                  onTap: (){
                       Navigator.pushNamed(context, helpRoute);
                  },
                  child: CustomListTile(frontIcon: Icons.help, text: ('Help'))),
              InkWell(
                  onTap: (){
                    showDialog(
                        context: context,
                        builder: (_)=>AlertDialog(
                          title: new Text("Logout"),
                          content: new Text("Are you sure you want to logout?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Yes'),
                              onPressed: () {
                                BlocProvider.of<AuthenticationCubit>(context).loggedOut();
                              //  BlocProvider.of<MapBloc>(context).mapOnLoading();
                              },
                            ),
                            FlatButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        )
                    );
                  },
                  child: CustomListTile(frontIcon: Icons.exit_to_app, text: ('Log Out')))

            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData frontIcon;
  final String text;

  CustomListTile({this.frontIcon,this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0),
      child: InkWell(
        splashColor: Colors.blueAccent,
        onTap: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween ,
          children: [
            Container(
              height: 50.0,
              child: Row(
                children: [
                  Icon(frontIcon,color: Colors.black45,size: 27,),
                  Padding(
                      padding: EdgeInsets.only(top:8.0,bottom: 6,left: 20),
                      child: Text('$text',style: TextStyle(fontSize: 15),)),
                ],
              ),
            ),
            // Icon(Icons.arrow_right)
          ],
        ),
      ),
    );
  }
}