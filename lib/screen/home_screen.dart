import 'dart:async';

import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bekloh_user/component/home_drawer.dart';
import 'package:bekloh_user/component/delivery_map.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _completer = Completer();
  LatLng _center = LatLng(-8.913025, 13.202462);

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
          child: Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: HomeDrawer(),
            ),
            body: Stack(
              children: [
                DeliveryMap(),
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
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height/10,
                  child: RaisedButton(
                    onPressed: null,
                    child: Text('Get delivery'),
                  ),
                )
              ],
            ),
            bottomSheet: BlocBuilder<DeliveryBookingBloc,DeliveryBookingState>(
              builder: (BuildContext context,DeliveryBookingState state){

              },
            ),
          ),
        ),
      );
    }
  }
