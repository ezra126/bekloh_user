import 'dart:async';

import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/screen/home_screen.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class PackageDetailScreen extends StatefulWidget {
  @override
  _PackageDetailScreenState createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  Completer<GoogleMapController> _Controller = Completer();
  Location location;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryBookingBloc, DeliveryBookingState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEvent());
           // Navigator.popUntil(context, ModalRoute.withName('/AddDestinationScreen'));
            Navigator.of(context).popUntil((route) => route.isFirst);
            //Navigator.pop(context);
            return false;
          },
          child: Scaffold(
              appBar: AppBar(
                title: Text('what it is?'),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*.07,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Choose Service',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*.15,
                      child: Row(
                        children: [
                          Expanded(child: Container(child: Center(child: Text("Large Item Delivery"),),)),
                          Expanded(child: Container(child: Center(child: Text("Document or small package delivery"),),))
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*.07,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text('Snap Photo',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 0),
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<DeliveryBookingBloc>(context).add(DetailsSubmittedEvent());
                          Navigator.pushNamed(context,chooseVechileAndPaymentRoute);
                        },
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * .1,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              color: Colors.blue,
                              child: Center(
                                child: Text('Confirm'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}

/*
*Stack(
            children: [
              if (state is DetailsNotFilledState)

                GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(state.booking.source.latitude, state.booking.source.longitude),
                      zoom: 6,
                    ),
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    compassEnabled: true,
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController controller) async {
                      _Controller.complete(controller);
                      await location.getLocation().then((LocationData initialLoc) async {
                        print(initialLoc);
                        LatLng latLng = LatLng(initialLoc.latitude, initialLoc.longitude);
                        CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 16);
                        final GoogleMapController controller=await  _Controller.future;
                        controller.moveCamera(cameraUpdate);
                      }
                      );

                    }),
            ],
          ),
          * */
