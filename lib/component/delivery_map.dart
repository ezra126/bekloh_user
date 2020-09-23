import 'dart:async';


import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/bloc/map_bloc.dart';
import 'package:bekloh_user/services/location_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DeliveryMap extends StatefulWidget {
  @override
  _DeliveryMapState createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {
  GoogleMapController mapController;
  LatLng _center = LatLng( 9.005401, 38.763611);
  LocationData currentLocation;
  CameraPosition currentCameraPosition;
  Location location=Location();
  LocationData initalLocationData;
  bool _permission;
  List<Marker> _markers = List();



@override
  void initState() {
  //location = Location();
 // initialLocation();
  location.onLocationChanged.listen((LocationData cLoc) {
      setState(() {
        currentLocation = cLoc;
      });
     // LatLng latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
  });
    super.initState();
  }

  void initialLocation() async{
   await location.getLocation().then((LocationData initialLoc)  {
     print(initialLoc);
     LatLng latLng = LatLng(initialLoc.latitude, initialLoc.longitude);
   CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 20);
   mapController.animateCamera(cameraUpdate);
   });


}


  @override
  Widget build(BuildContext context) {
  /*  var currentCameraPosition = CameraPosition(
        zoom: 12,
        target: LatLng(48.864716, 2.349014));
*/ if (currentLocation != null) {
      BlocProvider.of<MapBloc>(context).mapLoaded();
      currentCameraPosition = CameraPosition(
          zoom: 14,
          target: LatLng(currentLocation.latitude, currentLocation.longitude));
    }

    return Scaffold(
      body: Container(
        child: currentLocation==null ? Center(child: CircularProgressIndicator(),)
        :GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          initialCameraPosition: currentCameraPosition,
          onMapCreated: (GoogleMapController controller) async{
            setState(() {
              mapController = controller;
            });
          }

      ),),

    );
  }

  initPlatformState() async {
    await  location.changeSettings(
        accuracy: LocationAccuracy.balanced, interval: 1000);

     LocationData locationData;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await  location.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus)  {
        _permission = (await location.requestPermission()) as bool;
        print("Permission: $_permission");
        if (_permission) {
          location = (await  location.getLocation()) as Location;
          Marker marker = Marker(
            markerId: MarkerId('from_address'),
            position: LatLng(locationData.latitude, locationData.longitude),
            infoWindow: InfoWindow(title: 'Minha localização'),
          );
          if (mounted) {
            setState(() {
              currentLocation = LatLng(locationData.latitude, locationData.longitude) as LocationData;
              _center =
                  LatLng(currentLocation.latitude, currentLocation.longitude);
              _markers.add(marker);

            });
          }
        }
      } else {
        bool serviceStatusResult = await location.requestService();
        print("Service status activated after request: $serviceStatusResult");
        if (serviceStatusResult) {
          initPlatformState();
        }
      }
    } on PlatformException catch (e) {
      var error;
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        error = e.message;
      }
      //location = null;
    }
  }
}
