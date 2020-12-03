import 'dart:async';

import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/component/addPickandDestination_widget.dart';
//import 'package:bekloh_user/component/delivery_map.dart';
import 'package:bekloh_user/router/screens_argument.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

class AddDestinationScreen extends StatefulWidget {
  @override
  _AddDestinationScreenState createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  LocationData currentLocation;
  LatLng _cameraPosition;
  Location location;
  String title;
  Coordinates coordinates;
  List<Address> addresses;
  String loc="select location";
  bool isLoading=false;
  BuildContext dialogContext;
 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  selectedCameraPosition(LatLng curPos) async{
    if(mounted){
      setState(() {
        _cameraPosition=curPos;
      });
    }
    coordinates = new Coordinates(curPos.latitude, curPos.longitude);
    addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates).then((value) {
      var first = addresses.first;
      print(addresses.toString());
      print("${first.addressLine}");
      if(mounted){
      setState(() {
        loc="${first.addressLine}";
      });}
      return null;
    });




  //  print("${addresses[1]} : ${first.addressLine}");



  }

  void show(){
    showDialog(
      context: _scaffoldKey.currentContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        WidgetsBinding.instance.addPostFrameCallback((_){
          if(mounted){
            setState(() {
              dialogContext=context;
            });
          }

        });
        return Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20,),
                Text("Loading"),
              ],
            ),
          ),
        );
      },
    );
  }

  void fetchPlaceName(bool loading) async{
   
    print(loading);
    if(loading==true){
      setState(() {
        isLoading=true;
      });
    //  show();
    }


  }

  @override
  void initState() {
   /* location = Location();
    location.onLocationChanged.listen((LocationData cLoc) async {
      currentLocation = cLoc;
      GoogleMapController controller = await _Controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 17),
      ));
    });*/
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
         // Navigator.of(context).popUntil((route) => route.isFirst);
       //   Timer(Duration(milliseconds: 200),(){BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEvent());});
          // Navigator.popUntil(context, ModalRoute.withName('/AddDestinationScreen'));
          Navigator.pop(context);
          return false;
        },
        child: BlocBuilder<DeliveryBookingBloc, DeliveryBookingState>(
          builder: (context,state){
            if(state is DestinationNotSelectedState){
              title="Add Destination";
            //  _cameraPosition=LatLng(state.currentLocation.latitude,state.currentLocation.longitude);
            }
            if(state is PickupNotSelectedState){
              title="Add Pickup ";
           //   _cameraPosition=LatLng(state.currentLocation.latitude,state.currentLocation.longitude);
            }

            return Scaffold(
              key: _scaffoldKey,
                appBar: AppBar(
                  title: Text(title),
                ),
                body: Stack(
                  children: [
                    if(state is PickupNotSelectedState)
                      AddPickDestinationMapWidget(
                        initialLoc: state.currentLocation,selectedPosition:selectedCameraPosition ,fetchName: fetchPlaceName,),

                    if (state is DestinationNotSelectedState)
                      AddPickDestinationMapWidget(initialLoc: state.currentLocation,selectedPosition:selectedCameraPosition,fetchName: fetchPlaceName),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      color: Colors.white,
                      height: 50,
                      child: Row(
                       children: [
                      // Icon(Icons.search),
                        // SizedBox(width: 10,),
                         Text(loc)
                       ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom: 0),
                      child: GestureDetector(
                        onTap: () {
                          if(state is DestinationNotSelectedState){
                            if(_cameraPosition!=null){
                              BlocProvider.of<DeliveryBookingBloc>(context).add(DestinationSelectedEvent(
                                LatLng(_cameraPosition.latitude, _cameraPosition.longitude),));
                            }
                           else{
                              BlocProvider.of<DeliveryBookingBloc>(context).add(DestinationSelectedEvent(
                                LatLng(state.currentLocation.latitude, state.currentLocation.longitude),));
                            }
                          //  Navigator.pushNamed(context, PackageDetailRoute);
                            Navigator.pop(context);
                          // Navigator.pushNamed(context, selectLocationRoute,arguments: ScreenArguments(LatLng(currentLocation.latitude,currentLocation.longitude)));
                          }
                          if(state is PickupNotSelectedState){
                            if(_cameraPosition!=null){
                              BlocProvider.of<DeliveryBookingBloc>(context).add(PickupLocationSelectedEvent(
                                  startingLoc: LatLng(_cameraPosition.latitude, _cameraPosition.longitude )));
                            }
                           else {
                              BlocProvider.of<DeliveryBookingBloc>(context).add(PickupLocationSelectedEvent(
                                  startingLoc: LatLng(state.currentLocation.latitude, state.currentLocation.longitude )));
                            }
                         //   Navigator.of(context).popUntil((route) => route.isFirst);
                            Navigator.pop(context);
                            //Navigator.pushNamed(context, selectLocationRoute,arguments: ScreenArguments(LatLng(currentLocation.latitude,currentLocation.longitude)));
                          }
                          },

                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .1,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              color: Colors.blue,
                              child: Center(
                                child: Text('Add Location'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
          },

        ),
      );

  }
}





/*updateCurrentLocation() async {
  GoogleMapController controller = await _Controller.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(
    CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 17),
  ));
}*/
