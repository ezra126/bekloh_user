import 'dart:async';

import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/component/delivery_map.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class AddDestinationScreen extends StatefulWidget {
  @override
  _AddDestinationScreenState createState() => _AddDestinationScreenState();
}

class _AddDestinationScreenState extends State<AddDestinationScreen> {
  Completer<GoogleMapController> _Controller = Completer();
  GoogleMapController mapController;
  LatLng _center = LatLng(9.005401, 38.763611);
  LocationData currentLocation;
  CameraPosition initialCameraPosition;
  CameraPosition currentCameraPosition;
  LatLng _cameraPosition=LatLng(0,0);
  Location location;
  LocationData initalLocationData;
  bool _permission;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor sourceIcon;
  Set<Marker> markers = Set<Marker>();



  @override
  void initState() {
    location = Location();
    location.onLocationChanged.listen((LocationData cLoc) async {
      currentLocation = cLoc;

      GoogleMapController controller = await _Controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: 17),
      ));
    });
    super.initState();
  }



  updateCurrentLocation() async {
    GoogleMapController controller = await _Controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: 17),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryBookingBloc, DeliveryBookingState>(
        builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Timer(Duration(milliseconds: 200),(){
            BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEvent());
          });



          // Navigator.popUntil(context, ModalRoute.withName('/AddDestinationScreen'));

          //Navigator.pop(context);
          return false;
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text('ADD DESTINATION'),
            ),
            body: Stack(
              children: [
                if(state is PickupNotSelectedState)
                  GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(state.currentLocation.latitude, state.currentLocation.longitude),
                        zoom: 16,
                      ),
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      compassEnabled: true,
                      rotateGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      markers: markers,
                      onCameraMove: ((_position) => _updatePosition(_position)),
                      onMapCreated: (GoogleMapController controller) async {
                        if (mounted) {
                          setState(() {
                            mapController = controller;
                          });
                        }
                      }),
                if (state is DestinationNotSelectedState)
                     GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(state.currentLocation.latitude, state.currentLocation.longitude),
                          zoom: 16,
                        ),
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        compassEnabled: true,
                        rotateGesturesEnabled: true,
                        tiltGesturesEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        markers: markers,
                        onCameraMove: ((_position) => _updatePosition(_position)),
                        onMapCreated: (GoogleMapController controller) async {
                          _Controller.complete(controller);
                          await location.getLocation().then((LocationData initialLoc) async {
                            LatLng latLng = LatLng(initialLoc.latitude, initialLoc.longitude);
                            CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 16);
                            final GoogleMapController controller=await  _Controller.future;
                            controller.moveCamera(cameraUpdate);
                          });
                        }),

                Container(
                  margin: EdgeInsets.only(bottom: 0),
                  child: GestureDetector(
                    onTap: () {
                      if(state is DestinationNotSelectedState){
                        BlocProvider.of<DeliveryBookingBloc>(context).add(DestinationSelectedEvent(
                          LatLng(_cameraPosition.latitude, _cameraPosition.longitude),));
                        Navigator.pushNamed(context, PackageDetailRoute);

                      }

                      if(state is PickupNotSelectedState){
                        BlocProvider.of<DeliveryBookingBloc>(context).add(PickupLocationSelectedEvent(
                           LatLng(_cameraPosition.latitude, _cameraPosition.longitude ),));
                           Navigator.of(context).popUntil((route) => route.isFirst);
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
            )),
      );
    });
  }

  void _updatePosition(CameraPosition _position) {

    print(
        'inside updatePosition ${_position.target.latitude} ${_position.target.longitude}');
    Marker marker = markers.firstWhere(
        (p) => p.markerId == MarkerId('marker_2'),
        orElse: () => null);
    setState(() {
      markers.remove(marker);
      markers.add(
        Marker(
          markerId: MarkerId('marker_2'),
          position:
              LatLng(_position.target.latitude, _position.target.longitude),
          draggable: true,
          icon: pinLocationIcon,
        ),
      );
    });
    setState(() {
     _cameraPosition=LatLng(_position.target.latitude,_position.target.longitude);

    });
  }
}
