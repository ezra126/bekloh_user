import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DriverOnServiceScreen extends StatefulWidget {
  @override
  _DriverOnServiceScreenState createState() => _DriverOnServiceScreenState();
}

class _DriverOnServiceScreenState extends State<DriverOnServiceScreen> {
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey =
      "AIzaSyCiCMyI8956tKlWhxkSAtQtSUA0FBoOmh4"; // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  LatLng sourceLocation;
  LatLng driverLocation;
  LatLng destinationLocation;
  double totalDistance = 0;
  GoogleMapController mapController;
  CameraUpdate u2;
  Location location;


  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = BitmapDescriptor.defaultMarker;
    destinationIcon = BitmapDescriptor.defaultMarkerWithHue(80);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DeliveryBookingBloc,DeliveryBookingState>(
        builder: (context,DeliveryBookingState state){
          if(state is DriverAcceptYourMoveOrDeliveryState){
            WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
              sourceLocation= state.booking.source;
              destinationLocation = state.booking.destination;
            }));
            return Container(
              child: Stack(
                children: [
                  GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(driverLocation.latitude, driverLocation.longitude),
                          zoom: 14),
                      zoomControlsEnabled: false,
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      compassEnabled: true,
                      rotateGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      // myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      markers: _markers,
                      polylines: _polylines,
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
                      onMapCreated: (GoogleMapController controller) async {
                        // _controller.complete(controller);
                        setState(() {
                          mapController=controller;
                        });
                        setMapPins(sourceLocation, driverLocation);
                        setPolylines(sourceLocation, driverLocation);
                        // final mapController = await _controller.future;

                        makeBound();
                        mapController.animateCamera(u2).then((void v) {check(u2, mapController);}).then((_)  {


                        } );
                      }),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
  makeBound(){
    LatLngBounds bound;
    if (sourceLocation.latitude > driverLocation.latitude &&
        sourceLocation.longitude >
            driverLocation.longitude) {
      bound = LatLngBounds(
          southwest: driverLocation,
          northeast: sourceLocation);
    } else if (sourceLocation.longitude >
        driverLocation.longitude) {
      bound = LatLngBounds(
          southwest: LatLng(sourceLocation.latitude,
              driverLocation.longitude),
          northeast: LatLng(driverLocation.latitude,
              sourceLocation.longitude));
    } else if (sourceLocation.latitude >
        driverLocation.latitude) {
      bound = LatLngBounds(
          southwest: LatLng(driverLocation.latitude,
              sourceLocation.longitude),
          northeast: LatLng(sourceLocation.latitude,
              driverLocation.longitude));
    } else {
      bound = LatLngBounds(
          southwest: sourceLocation,
          northeast: driverLocation
      );
    }
    setState(() {
      u2 = CameraUpdate.newLatLngBounds(bound, 80);
    });
  }

  void setMapPins(LatLng source, LatLng destination) {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: source,
          icon: sourceIcon)); // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: destination,
          icon: destinationIcon));
    });
  }

  setPolylines(LatLng source, LatLng destination) async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(source.latitude, source.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      //travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      Polyline polyline = Polyline(
          polylineId: PolylineId('poly'),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }

  void check(CameraUpdate u, GoogleMapController c) async {

    c.animateCamera(u);
    mapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if (l1.southwest.latitude == -110 || l2.southwest.latitude == -110)
      check(u, c);
  }
}
