import 'package:bekloh_user/bloc/authbloc/auth_bloc.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key}) : super(key: key);

  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          accountName: Text("Israel "),
          accountEmail: Row(
            children: <Widget>[
              Text("5.0"),
              Icon(
                Icons.star,
                color: Colors.white,
                size: 12,
              )
            ],
          ),
          currentAccountPicture: ClipOval(
            child: Image.asset(
              "assets/images/user_profile.jpg",
              width: 10,
              height: 10,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          linkMenuDrawer('Payment', () {
            Navigator.pushNamed(context, '/payment');
          }),
          linkMenuDrawer('Your Trips', () {
            Navigator.pushNamed(context, '/your_trip');
          }),
          linkMenuDrawer('Free Rides', () {
            Navigator.pushNamed(context, '/free_rides');
          }),
          linkMenuDrawer('Help', () {
            Navigator.pushNamed(context, '/help');
          }),
          linkMenuDrawer('Settings', () {
            Navigator.pushNamed(context, '/settings');
          }),
        ]),
      ],
    );
  }
}

Widget linkMenuDrawer(String title, Function onPressed) {
  return InkWell(
    onTap: onPressed,
    splashColor: Colors.black,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(fontSize: 15.0),
      ),
    ),
  );
}




class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          duration: const Duration(milliseconds: 650),
          curve: Curves.decelerate,
          decoration: BoxDecoration(
            color:  Colors.black,
          ),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width/12,
                ),
                SizedBox(height: 10,),
                Text('Israel Getahun'),
                SizedBox(height: 4,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: Colors.white
                  ),
                  height: 20,
                  width: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.star,size: 18,),
                      Text('4.6'),
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
        GestureDetector(
            onTap: (){
              Navigator.pop(context);
             // print('ezi new');
              Navigator.pushNamed(context,profileRoute);
            },
            child: CustomListTile(frontIcon: Icons.person,
                text: ('My Profile'))),
        Divider(color: Colors.black45,height: 4,),
        InkWell(
            onTap: (){
              Navigator.pop(context);
             // Navigator.pushNamed(context,EarningRoute);
            },
            child: CustomListTile(frontIcon: Icons.attach_money, text: ('My Wallet'))),
        Divider(color: Colors.black45,height: 4,),
        InkWell(
            onTap: (){
              Navigator.pop(context);
             // Navigator.pushNamed(context,SummaryRoute);
            },
            child: CustomListTile(frontIcon: Icons.history,
                text: ('History'))),
        Divider(color: Colors.black45,height: 4,),
        InkWell(
            onTap: (){
              Navigator.pop(context);
              //Navigator.pushNamed(context,SettingRoute);
            },
            child: CustomListTile(frontIcon: Icons.settings,
                text: ('Notification'))),
        Divider(color: Colors.black45,height: 4,),
        InkWell(
          onTap: (){
            Navigator.pop(context);
            Navigator.pushNamed(context,settingRoute);
          },
          child: CustomListTile(frontIcon: Icons.settings,
              text: ('Setting')),
        ),
        Divider(color: Colors.black45,height: 4,),
        InkWell(
          onTap: (){

          },
          child: CustomListTile(frontIcon: Icons.help_outline,
              text: ('Support')),
        ),
        Divider(color: Colors.black45,height: 4,),
        InkWell(
          onTap: (){
            BlocProvider.of<AuthenticationCubit>(context).loggedOut();
          },
          child: CustomListTile(frontIcon: Icons.exit_to_app,
              text: ('Log Out')),
        ),
        Divider(color: Colors.black45,height: 4,),




      ],
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
      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 0),
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
                  Icon(frontIcon),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('$text')),
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
