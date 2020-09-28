import 'dart:async';
import 'dart:typed_data';

import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/bloc/map_bloc.dart';
import 'package:bekloh_user/services/location_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
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
  GoogleMapController addDestinationController;
  LatLng _center = LatLng(9.005401, 38.763611);
  LocationData currentLocation;
  CameraPosition currentCameraPosition;
  Location location = Location();
  LocationData initalLocationData;
  bool _permission;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor sourceIcon;
  Set<Marker> markers = Set<Marker>();
  Set<Polyline> polylines = Set<Polyline>();
  Set<Circle> circles = Set<Circle>();

  void clearData() {
    markers.clear();
    polylines.clear();
    circles.clear();
  }

  @override
  void initState() {
    //location = Location();
    // initialLocation();
    if (currentLocation != null) {
      BlocProvider.of<MapBloc>(context).mapLoaded();
    }

    location.onLocationChanged.listen((LocationData cLoc) {
      if (this.mounted) {
        setState(() {
          currentLocation = cLoc;
        });
      }
      setState(() {
        currentLocation = cLoc;
      });
      // LatLng latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    super.initState();
    //setCustomMapPin();
  }

  void initialLocation() async {
    await location.getLocation().then((LocationData initialLoc) {
      print(initialLoc);
      LatLng latLng = LatLng(initialLoc.latitude, initialLoc.longitude);
      CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 20);
      mapController.animateCamera(cameraUpdate);
    });
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/logos/map-pin.png');
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
          icon: pinLocationIcon,
        ),
      );
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var initialCameraPosition =
        CameraPosition(zoom: 8, target: LatLng(9.005401, 38.763611));
    /*
        // BlocProvider.of<MapBloc>(context).mapLoaded();
*/
    if (currentLocation != null) {
     // print('dhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhjjj');
      // BlocProvider.of<MapBloc>(context).mapLoaded();
      initialCameraPosition = CameraPosition(
          zoom: 16,
          target: LatLng(currentLocation.latitude, currentLocation.longitude));
    }

    return Scaffold(
      body: BlocListener<DeliveryBookingBloc, DeliveryBookingState>(
        listener: (BuildContext context, DeliveryBookingState state) {
          if (state is DeliveryBookingNotInitializedState) {
            clearData();
          }
          if (state is DestinationNotSelectedState) {
            clearData();
            addMarker();
          }
          if (state is DeliveryVechileTypeNotSelectedState) {}
          if (state is DeliveryBookingConfirmedState) {}
        },
        child: BlocBuilder<DeliveryBookingBloc, DeliveryBookingState>(
          builder: (context, state) {
            if (state is DeliveryBookingNotInitializedState) {
              return GoogleMap(
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  compassEnabled: true,
                  rotateGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: markers,
                  // onCameraMove: state is DestinationNotSelectedState ?((_position) => _updatePosition(_position, "ndfkjnkjdf")) : null ,
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
                  initialCameraPosition: initialCameraPosition,
                  onMapCreated: (GoogleMapController controller) async {
                    //BlocProvider.of<MapBloc>(context).mapLoaded();
                    if (mounted) {
                      setState(() {
                        mapController = controller;
                      });
                    }
                    await location
                        .getLocation()
                        .then((LocationData initialLoc) {
                      LatLng latLng =
                          LatLng(initialLoc.latitude, initialLoc.longitude);
                      CameraUpdate cameraUpdate =
                          CameraUpdate.newLatLngZoom(latLng, 16);
                      mapController.animateCamera(cameraUpdate);
                    });
                  });
            }
            if (state is DestinationNotSelectedState) {
              print('destinaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
              Container(
                height: 40,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(zoom: 8, target: LatLng(20.005401, 38.763611)),
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (GoogleMapController controller) async {
                    //BlocProvider.of<MapBloc>(context).mapLoaded();
                    if (mounted) {
                      setState(() {
                        addDestinationController = controller;
                      });
                    }
                  },
                ),
              );
            }
            return Container(color: Colors.lightBlue,);
          },
        ),
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

  @override
  void dispose() {
    // TODO: implement dispose
    mapController.dispose();
    addDestinationController.dispose();
    super.dispose();
  }
}
