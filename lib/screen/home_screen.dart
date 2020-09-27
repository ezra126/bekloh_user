import 'dart:async';

import 'package:bekloh_user/bloc/authbloc/auth_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/bloc/map_bloc.dart';
import 'package:bekloh_user/component/address_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bekloh_user/component/home_drawer.dart';
import 'package:bekloh_user/component/delivery_map.dart';
import 'package:connectivity/connectivity.dart';
import 'package:uuid/uuid.dart';



class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
 // Completer<GoogleMapController> _completer = Completer();
  LatLng _center = LatLng(-8.913025, 13.202462);
  final _textcontroller = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
   // BlocProvider.of<AuthenticationCubit>(context).loggedOut();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(Duration(seconds: 2),(){
     // BlocProvider.of<MapBloc>(context).mapLoaded();
    });

  }


    @override
    Widget build(BuildContext context) {


      return WillPopScope(
        onWillPop:() async{
         BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEvent());
          return false;
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child:  BlocBuilder<DeliveryBookingBloc, DeliveryBookingState>(
             builder:  (BuildContext context, state){
                 return Scaffold(
                   key: _scaffoldKey,
                   drawer: Drawer(
                     child: MainDrawer(),
                   ),
                   body: Stack(
                     children: [
                       DeliveryMap(),
                      //(state is MapLoadedState) ?
                       (state is DeliveryBookingNotInitializedState) ?
                       Padding(
                         padding: EdgeInsets.only(top: 80, left: 20, right: 20),
                         child: Container(
                           height: 50,
                           color: Colors.white,
                           child:  TextField(
                             readOnly: true,
                             controller: _textcontroller,
                             onTap: () async {
                               // should show search screen here
                               final sessionToken = Uuid().v4();
                               showSearch(
                                 context: context,
                                 delegate: AddressSearch(sessionToken),
                               );

                             },
                             decoration: InputDecoration(
                               icon: Container(
                                 margin: EdgeInsets.only(right: 20),
                                 width: 10,
                                 height: 10,
                                 child: Icon(
                                   Icons.search,
                                   color: Colors.black,
                                 ),
                               ),
                               hintText: "Enter your shipping address",
                               border: InputBorder.none,
                               contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                             ),
                           ),
                         ),
                       )
                        : Container(height: 0,)
                       ,
                    //  (state is MapLoadedState) ?
                       (state is DeliveryBookingNotInitializedState) ?
                       Positioned(
                         left: 0,
                         top: 0,
                         right: 0,
                         child: Column(
                           children: <Widget>[
                             AppBar(
                               backgroundColor: Colors.transparent,
                               elevation: 0.0,
                               leading: FlatButton(
                                 onPressed: () {
                                   // BlocProvider.of<AuthenticationCubit>(context).loggedOut();
                                   _scaffoldKey.currentState.openDrawer();
                                 },
                                 child: Icon(
                                   Icons.menu,
                                   color: Colors.black,
                                 ),
                               ),
                             ),
                           ],
                         ),
                       )
                        :Container(),

                     ],
                   ),
                   bottomSheet:
                  //  (state is MapLoadedState) ?
                    BlocBuilder<DeliveryBookingBloc, DeliveryBookingState>(
                       builder: (BuildContext context, DeliveryBookingState state) {
                         if (state is DeliveryBookingNotInitializedState) {
                           return Container(height: 100,
                             child:  RaisedButton(
                               onPressed: () async{
                                 final Connectivity _connectivity = Connectivity();
                                 _connectivity.onConnectivityChanged.listen((connectionResult){
                                   if (connectionResult == ConnectivityResult.wifi || connectionResult == ConnectivityResult.mobile ) {
                                     BlocProvider.of<AuthenticationCubit>(context).loggedOut();
                                     // Timer(Duration(seconds: 5), () => Navigator.pushNamed(context, welcomeRoute));
                                   }
                                 });

                                 //  BlocProvider.of<AuthenticationCubit>(context).loggedOut();
                               },
                               child: Text('Log out'),
                             ),);
                         }
                         if(state is DestinationNotSelectedState){
                           Container(
                             child: Center(child: Text('Add Location'),),
                           );
                         }
                         return Container(height: 100,);
                       })
                       //  : Container(height: 0)


                 );
               }
          ),
        ),
      );
    }

  @override
  void dispose() {

    _textcontroller.dispose();
    super.dispose();
  }
  }
