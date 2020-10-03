import 'dart:async';
import 'dart:typed_data';

import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/bloc/map_bloc.dart';
import 'package:bekloh_user/services/location_service.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DeliveryMap extends StatefulWidget {
  @override
  _DeliveryMapState createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _Controller = Completer();
  LatLng _center = LatLng(9.005401, 38.763611);
  LatLng currentPosition;
  LocationData currentLocation;
  CameraPosition initialCameraPosition;
  Location location ;
  LocationData initalLocationData;
  bool _permission;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor sourceIcon;
  Set<Marker> markers = Set<Marker>();
  Set<Polyline> polylines = Set<Polyline>();
  Set<Circle> circles = Set<Circle>();


  void clearData() {
    setState(() {
      markers.clear();
      polylines.clear();
      circles.clear();
    });

  }

  @override
  void initState() {
      location = Location();

      //BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryBookingStartEvent());
     location.onLocationChanged.listen((LocationData cLoc) {
        currentLocation = cLoc;
        currentPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
        if (currentPosition != null) {
          BlocProvider.of<MapBloc>(context).mapLoaded();

          //BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryBookingStartEvent());
        }

    });
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (currentPosition != null) {
      BlocProvider.of<MapBloc>(context).mapLoaded();

      //BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryBookingStartEvent());
    }
    super.didChangeDependencies();
  }

  void initialLocation() async {
    await location.getLocation().then((LocationData initialLoc) {
      print(initialLoc);
      LatLng latLng = LatLng(initialLoc.latitude, initialLoc.longitude);
      CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 20);
      mapController.animateCamera(cameraUpdate);
    });
  }



  void addMarker() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5, size: Size(100, 100)),
        'assets/logos/mypin.png');

    markers.add(Marker(
        draggable: true,
        markerId: MarkerId('initial'),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        icon: pinLocationIcon,
        onDragEnd: ((value) {
          print(value.latitude);
          print(value.longitude);
        })));
  }

  void _updatePosition(CameraPosition _position, String hey) {
    print(hey);
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
          zIndex: 40,
          onDragEnd: (value){

          },
          icon: pinLocationIcon,
        ),
      );
    });
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {

    if(currentPosition==null){
      currentPosition=LatLng(29.005401, 58.763611);
    }
  /*  if (currentLocation != null) {
     // print('dhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhjjj');
      // BlocProvider.of<MapBloc>(context).mapLoaded();
      initialCameraPosition = CameraPosition(
          zoom: 16,
          target: LatLng(currentLocation.latitude, currentLocation.longitude));
    }*/

    return Scaffold(
      body: BlocListener<DeliveryBookingBloc, DeliveryBookingState>(
        listener: (context, DeliveryBookingState state) {
          if (state is DeliveryBookingNotInitializedState) {

          //  clearData();
          }
          if (state is DestinationNotSelectedState) {
            //   clearData();
           // Navigator.pop(context);
            //     addMarker();
          }
          if (state is DeliveryVechileTypeNotSelectedState) {}
          if (state is DeliveryBookingConfirmedState) {}
        },
        child: BlocBuilder<DeliveryBookingBloc,DeliveryBookingState>(
                  builder: (context,DeliveryBookingState state){
                    if(state is DeliveryBookingNotInitializedState){
                      return  currentLocation==null ? Center(child: CircularProgressIndicator(),) : GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: currentPosition,
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
                          //onCameraMove: state is DeliveryBookingNotInitializedState ? null: ((_position) => _updatePosition(_position, "ndfkjnkjdf"))  ,
                          gestureRecognizers: Set()
                            ..add(Factory<PanGestureRecognizer>(
                                    () => PanGestureRecognizer()))
                            ..add(
                              Factory<OneSequenceGestureRecognizer>(
                                    () => new EagerGestureRecognizer(),
                              ),
                            )
                            ..add(Factory<ScaleGestureRecognizer>(
                                    () => ScaleGestureRecognizer()))
                            ..add(Factory<TapGestureRecognizer>(
                                    () => TapGestureRecognizer()))
                            ..add(Factory<VerticalDragGestureRecognizer>(
                                    () => VerticalDragGestureRecognizer())),
                          /*  gestureRecognizers: < Factory < OneSequenceGestureRecognizer >> [
                      new Factory < OneSequenceGestureRecognizer > (() => new EagerGestureRecognizer(),
                      ),
                    ].toSet(),*/

                          onMapCreated: (GoogleMapController controller) async {
                            //BlocProvider.of<MapBloc>(context).mapLoaded();
                            if (mounted) {
                              setState(() {
                                mapController = controller;
                              });
                            }

                          });
                    }
                    if(state is DestinationNotSelectedState){
                      return  GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(9.005401, 38.763611),
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
                          markers: markers,
                          onCameraMove:  ((_position) => _updatePosition(_position, "ndfkjnkjdf"))  ,
                          onMapCreated: (GoogleMapController controller) async {
                            _Controller.complete(controller);
                            await location.getLocation().then((LocationData initialLoc) async {

                              LatLng latLng = LatLng(initialLoc.latitude, initialLoc.longitude);
                              CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 16);
                              final GoogleMapController controller=await  _Controller.future;
                                  controller.moveCamera(cameraUpdate);
                            });

                          });
                    }
                    return Container();

                  }

                )


      ),
    );
  }

  initPlatformState() async {
    await location.changeSettings(
        accuracy: LocationAccuracy.balanced, interval: 1000);

    LocationData locationData;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      bool serviceStatus = await location.serviceEnabled();
      print("Service status: $serviceStatus");
      if (serviceStatus) {
        _permission = (await location.requestPermission()) as bool;
        print("Permission: $_permission");
        if (_permission) {
          location = (await location.getLocation()) as Location;
          Marker marker = Marker(
            markerId: MarkerId('from_address'),
            position: LatLng(locationData.latitude, locationData.longitude),
            infoWindow: InfoWindow(title: 'Minha localização'),
          );
          if (mounted) {
            setState(() {
              currentLocation =
                  LatLng(locationData.latitude, locationData.longitude)
                      as LocationData;
              _center =
                  LatLng(currentLocation.latitude, currentLocation.longitude);
              markers.add(marker);
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
