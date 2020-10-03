import 'dart:async';

import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/component/bottomsheet_button.dart';
import 'package:bekloh_user/component/choose_vechile.dart';
import 'package:bekloh_user/component/delivery_booking_state_widget.dart';
import 'package:bekloh_user/storage/delivery_booking_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ChooseVechileAndPaymentScreen extends StatefulWidget {
  @override
  _ChooseVechileAndPaymentScreenState createState() =>
      _ChooseVechileAndPaymentScreenState();
}

class _ChooseVechileAndPaymentScreenState extends State<ChooseVechileAndPaymentScreen> {

  Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;
  CameraPosition initialCameraPosition;
  CameraPosition currentCameraPosition;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey =
      "AIzaSyCiCMyI8956tKlWhxkSAtQtSUA0FBoOmh4"; // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  LatLng SOURCE_LOCATION ;
  LatLng DEST_LOCATION ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = BitmapDescriptor.defaultMarker;
    destinationIcon = BitmapDescriptor.defaultMarkerWithHue(80);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Timer(Duration(milliseconds: 200), () {
          BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEvent());
        });
        return false;
      },
      child: BlocBuilder<DeliveryBookingBloc, DeliveryBookingState>(
          builder: (context, state) {
            if (state is DeliveryVechileTypeNotSelectedState){
              WidgetsBinding.instance.addPostFrameCallback((_) =>
                  setState(() {
                    SOURCE_LOCATION=state.booking.source;
                    DEST_LOCATION=state.booking.destination;
                  })
              );

            }
        return Scaffold(
          body: Stack(
             children: [
                 GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude),
                            zoom: 16),
                        zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        compassEnabled: true,
                        rotateGesturesEnabled: true,
                        tiltGesturesEnabled: true,
                        myLocationEnabled: true,
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
                        /*  gestureRecognizers: < Factory < OneSequenceGestureRecognizer >> [
                          new Factory < OneSequenceGestureRecognizer > (() => new EagerGestureRecognizer(),
                          ),
                        ].toSet(),*/
                        onMapCreated: (GoogleMapController controller) async {
                          _controller.complete(controller);
                          setMapPins(SOURCE_LOCATION, DEST_LOCATION);
                          setPolylines( SOURCE_LOCATION, DEST_LOCATION);
                        }
                        ),
               SlidingUpPanel(
                 margin: EdgeInsets.only(top: 0),
                 minHeight: 200,
                 maxHeight: 500,
                 panel: Container(
                   margin: EdgeInsets.symmetric(vertical: 20.0),
                   height: 200.0,
                   child: Column(
                     children: [
                       TaxiBookingStateWidget(),
                       SizedBox(height: 10,),
                       ChooseVechileWidget(),
                       Container(
                         height: 100,
                         child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                             itemBuilder: (context,index){
                              return Container(
                                width: 200,
                                child: Center(child: Text('hola'),),);
                             }),
                       )

                     ],
                   ),
                 ),
               )

                ],
              ),
          bottomSheet: BlocBuilder<DeliveryBookingBloc,DeliveryBookingState>(
            builder: (context,state){
              if(state is DeliveryVechileTypeNotSelectedState){
                 return Container(
                   height: 80,
                   width: MediaQuery.of(context).size.width,
                   child:  Row(
                     children: <Widget>[
                       Expanded(
                         flex: 2,
                         child: Padding(
                           padding: EdgeInsets.symmetric(horizontal: 20),
                           child: MaterialButton(
                             height: 60,
                             color: Colors.black,
                             child: Text('Request Trip',style: TextStyle(color: Colors.white),),
                              onPressed: () {
                               BlocProvider.of<DeliveryBookingBloc>(context)
                                   .add(DeliveryVechileSelectedEvent());
                             },
                           ),
                         ),
                       )
                     ],
                   ),
                 );

              }
              if(state is PaymentMethodNotSelectedState){
                return Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child:  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            height: 60,
                            color: Colors.black,
                            child: IconButton(
                              color: Colors.white,
                              onPressed: (){
                                BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEvent());
                              },
                              icon: Icon(Icons.keyboard_backspace),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: MaterialButton(
                            height: 60,
                            color: Colors.black,
                            child: Text('Confirm Payment',style: TextStyle(color: Colors.white),),
                            onPressed: () {
                              //BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryVechileSelectedEvent());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),

        );
      }),
    );
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
}
