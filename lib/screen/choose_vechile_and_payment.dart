import 'dart:async';

import 'dart:math' show cos, sqrt, asin;
import 'dart:typed_data';

import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/component/bottomsheet_button.dart';
import 'package:bekloh_user/component/choose_payment.dart';
import 'package:bekloh_user/component/choose_vechile.dart';
import 'package:bekloh_user/component/delivery_booking_state_widget.dart';
import 'package:bekloh_user/model/payment_type.dart';
import 'package:bekloh_user/model/vechile_type.dart';
import 'package:bekloh_user/storage/delivery_booking_storage.dart';
import 'package:bekloh_user/utilities/constants.dart';
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
  //Completer<GoogleMapController> _controller = Completer();
  Uint8List googlemapImage;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey =
      "AIzaSyCiCMyI8956tKlWhxkSAtQtSUA0FBoOmh4"; // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  LatLng SOURCE_LOCATION;
  LatLng DEST_LOCATION;
  double totalDistance = 0;
  VechileType _vechileType;
  PaymentType _paymentType;
  int _value = 1;
  GoogleMapController mapController;
  List<PaymentType> paymentTypeList = [PaymentType.Cash, PaymentType.Wallet];
  CameraUpdate u2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentType = paymentTypeList[0];
    setSourceAndDestinationIcons();
  }

  void selectedVechileType(VechileType vechileType) {
    setState(() {
      _vechileType = vechileType;
    });
  }

  void selectedPaymentType(PaymentType paymentType) {
    setState(() {
      _paymentType = paymentType;
    });
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
        if (state is DeliveryVechileAndPaymentTypeNotSelectedState) {
          WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
                SOURCE_LOCATION = state.booking.source;
                DEST_LOCATION = state.booking.destination;
              }));
        }
        return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.9,
                  child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(SOURCE_LOCATION.latitude,
                              SOURCE_LOCATION.longitude),
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
                      /*  gestureRecognizers: < Factory < OneSequenceGestureRecognizer >> [
                              new Factory < OneSequenceGestureRecognizer > (() => new EagerGestureRecognizer(),
                              ),
                            ].toSet(),*/
                      onMapCreated: (GoogleMapController controller) async {
                       // _controller.complete(controller);
                        setState(() {
                          mapController=controller;
                        });
                        setMapPins(SOURCE_LOCATION, DEST_LOCATION);
                        setPolylines(SOURCE_LOCATION, DEST_LOCATION);
                       // final mapController = await _controller.future;

                        makeBound();
                        mapController.animateCamera(u2).then((void v) {check(u2, mapController);}).then((_)  {
                          Timer(Duration(milliseconds: 1500),() async{
                            final imageBytes= await mapController?.takeSnapshot();
                            setState(() {
                              googlemapImage = imageBytes;
                            });
                         //   print(imageBytes.toString());
                          });

                        } );

                      /*  setState(() {
                          totalDistance = calculateDistance(
                              SOURCE_LOCATION.latitude,
                              SOURCE_LOCATION.longitude,
                              DEST_LOCATION.latitude,
                              DEST_LOCATION.longitude);
                        });*/
                      }),
                ),
                Positioned(
                  top: 25,
                  right: 15,
                  child: Container(
                    // margin: EdgeInsets.only(bottom: 135,right: 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 5.0,
                        ),
                      ],
                    ),
                    child: IconButton(
                      splashColor: Colors.blue,
                      icon: Icon(Icons.gps_fixed),
                      onPressed: () async {
                        mapController.animateCamera(u2).then((void v) {check(u2, mapController);}).then((_)  {
                          Timer(Duration(milliseconds: 1000),() async{
                            final imageBytes= await mapController?.takeSnapshot();
                            setState(() {
                              googlemapImage = imageBytes;
                            });
                            print(imageBytes.toString());
                          });
                        } );
                       // final GoogleMapController controller = await _controller.future;
                        mapController.animateCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(
                                  (SOURCE_LOCATION.latitude + DEST_LOCATION.latitude) / 2,
                                  ((SOURCE_LOCATION.longitude + DEST_LOCATION.longitude) / 2)),
                              zoom: 14),
                        ));
                      },
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.5,
                  minChildSize: 0.5,
                  maxChildSize: 1,
                  expand: true,
                  builder: (context, controller) {
                    return Column(
                      children: [
                        TaxiBookingStateWidget(),
                        SizedBox(height: 10,),
                        if (state is DeliveryVechileAndPaymentTypeNotSelectedState)
                          Expanded(
                              child: Container(
                                  color: Colors.white,
                                  child: ChooseVechileWidget(
                                    currentVechileType: selectedVechileType,
                                    scrollController: controller,
                                  ))),
                       /* if (state is PaymentMethodNotSelectedState)
                          ChoosePaymentWidget(
                            selectedPaymentType: selectedPaymentType,
                          ),*/
                      ],
                    );
                  },
                ),
                Positioned(
                  bottom: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(top: BorderSide(width: 1))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: DropdownButton(
                                  value: _value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("CASH"),
                                      value: 1,
                                    ),
                                    DropdownMenuItem(
                                      child: Text("WALLET"),
                                      value: 2,
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                    selectedPaymentType(
                                        paymentTypeList[_value - 1]);
                                  }),
                            ),
                            Text('Apply Promo')
                          ],
                        ),
                      )),
                ),

                /* SlidingUpPanel(
                   margin: EdgeInsets.only(top: 0),
                   minHeight:350,
                   maxHeight: 500,
                   onPanelSlide: (double pos) => setState(() {
                     _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                         _initFabHeight;
                   }),
                   panel: Container(
                     margin: EdgeInsets.symmetric(vertical: 0.0),
                   //  height: 400.0,
                     child: Column(
                       children: [
                         TaxiBookingStateWidget(),
                         SizedBox(height: 0,),
                         if(state is DeliveryVechileTypeNotSelectedState)
                         ChooseVechileWidget(currentVechileType: selectedVechileType,),
                         if(state is PaymentMethodNotSelectedState)
                          ChoosePaymentWidget(selectedPaymentType: selectedPaymentType,)


                       ],
                     ),
                   ),
                 ) */
              ],
            ),
            bottomSheet: BlocBuilder<DeliveryBookingBloc, DeliveryBookingState>(
              builder: (context, state) {
                if (state is DeliveryVechileAndPaymentTypeNotSelectedState) {
                  return Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 10, bottom: 10),
                                  child: MaterialButton(
                                    height: 60,
                                    color: Colors.black,
                                    child: Text(
                                      'Next',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      String googleImage = new String.fromCharCodes(googlemapImage);
                                      if(_vechileType!=null){
                                        BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryVechileAndPaymentSelectedEvent(_vechileType, _paymentType,googleImage));
                                        Navigator.pushNamed(context, confirmServiceRoute);
                                      }
                                      else{
                                        showAlertDialog(_scaffoldKey.currentContext);
                                      }

                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ));
                }
               /* if (state is PaymentMethodNotSelectedState) {
                  return Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
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
                                onPressed: () {
                                  // Navigator.pushNamed(context, addDestinationRoute);
                                  // BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEventFromPayment(_paymentType));
                                  var state =
                                      BlocProvider.of<DeliveryBookingBloc>(
                                              context)
                                          .state;
                                  if (state is PaymentMethodNotSelectedState) {
                                    print(state.booking.paymentType);
                                    print(state.booking.bookingTime);
                                  }
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
                              child: Text(
                                'Confirm Payment',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                BlocProvider.of<DeliveryBookingBloc>(context)
                                    .add(
                                        SelectPaymentMethodEvent(_paymentType));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }*/
                return Container();
              },
            ),
          ),
        );
      }),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        print('ggggggggggggggddddddddddddddddddddddssssssssssssssssssss');
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(""),
      content: Text('please select vechile type!!!'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  makeBound(){
    LatLngBounds bound;
    if (SOURCE_LOCATION.latitude > DEST_LOCATION.latitude &&
        SOURCE_LOCATION.longitude >
            DEST_LOCATION.longitude) {
      bound = LatLngBounds(
          southwest: DEST_LOCATION,
          northeast: SOURCE_LOCATION);
    } else if (SOURCE_LOCATION.longitude >
        DEST_LOCATION.longitude) {
      bound = LatLngBounds(
          southwest: LatLng(SOURCE_LOCATION.latitude,
              DEST_LOCATION.longitude),
          northeast: LatLng(DEST_LOCATION.latitude,
              SOURCE_LOCATION.longitude));
    } else if (SOURCE_LOCATION.latitude >
        DEST_LOCATION.latitude) {
      bound = LatLngBounds(
          southwest: LatLng(DEST_LOCATION.latitude,
              SOURCE_LOCATION.longitude),
          northeast: LatLng(SOURCE_LOCATION.latitude,
              DEST_LOCATION.longitude));
    } else {
      bound = LatLngBounds(
          southwest: SOURCE_LOCATION,
          northeast: DEST_LOCATION
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
