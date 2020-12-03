import 'dart:async';
import 'package:bekloh_user/bloc/authbloc/auth_bloc.dart';
import 'package:bekloh_user/storage/delivery_booking_storage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/bloc/map_bloc.dart';
import 'package:bekloh_user/component/address_search.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bekloh_user/component/home_drawer.dart';
import 'package:bekloh_user/component/delivery_map.dart';
import 'package:connectivity/connectivity.dart';
import 'package:location/location.dart';
import 'package:uuid/uuid.dart';
import 'package:bekloh_user/bloc/navigationbloc/navigation_bloc.dart';



class SelectLocationScreen extends StatefulWidget {
   final LatLng currLoc;
   SelectLocationScreen({this.currLoc});
  @override
  State<SelectLocationScreen> createState() => SelectLocationScreenState();
}

class SelectLocationScreenState extends State<SelectLocationScreen> with TickerProviderStateMixin{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //LatLng _center = LatLng(-8.913025, 13.202462);
  String _mapStyle;

  final _textcontroller = TextEditingController();
  GoogleMapController mapController;
  Location location ;
  LocationData currentLocation;
  LatLng currentPosition;
  bool showDestinationNotExist;
  bool showSourceNotExist;


  @override
  void initState() {
    super.initState();
    showDestinationNotExist=false;
    showSourceNotExist=false;

    rootBundle.loadString('assets/themes/map/night.json').then((string) {
      _mapStyle = string;
    });

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    location = Location();

    //BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryBookingStartEvent());
      location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
      currentPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
      if(currentLocation!=null){
         animateToCurrent();
      }
     // if (currentPosition != null) {BlocProvider.of<MapBloc>(context).mapLoaded();}
    });
  }

  void animateToCurrent(){
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: currentPosition, zoom: 15),));
  }

  @override
  void didChangeDependencies(){

    super.didChangeDependencies();
  /*  Timer(Duration(seconds: 2),(){
     // BlocProvider.of<MapBloc>(context).mapLoaded();
    });*/

  }


    @override
    Widget build(BuildContext context) {
     return WillPopScope(
        onWillPop:() async{
          Navigator.of(context).popUntil((route) => route.isFirst);
          Timer(Duration(milliseconds: 200),(){
            BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEvent());

          });
         // BlocProvider.of<MapBloc>(context).mapOnLoading();
          return false;
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child:  Scaffold(
            resizeToAvoidBottomInset: true,
                   key: _scaffoldKey,
                   appBar: AppBar(
                     title: Text('Select Location'),
                     centerTitle: true,
                   ),
                //   drawer: Drawer(
                //     child: MainDrawer(),
               //    ),
                   body: Stack(
                     children: [
                       BlocBuilder<DeliveryBookingBloc,DeliveryBookingState>(
                           builder: (context,DeliveryBookingState state){
                             return GoogleMap(
                                 mapType: MapType.normal,
                                 initialCameraPosition: widget.currLoc== LatLng(0,0) ? CameraPosition(
                                   target: LatLng(37,9),
                                   zoom: 2,
                                 ): CameraPosition(
                                   target: widget.currLoc,
                                   zoom: 15,
                                 ) ,
                                 zoomControlsEnabled: false,
                                 zoomGesturesEnabled: true,
                                 scrollGesturesEnabled: true,
                                 compassEnabled: true,
                                 rotateGesturesEnabled: true,
                                 tiltGesturesEnabled: true,
                                 myLocationEnabled: true,
                                 myLocationButtonEnabled: false,
                                 //markers: markers,
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


                                 onMapCreated: (GoogleMapController controller) async {

                                   //BlocProvider.of<MapBloc>(context).mapLoaded();
                                   if (mounted) {
                                     setState(() {
                                       mapController = controller;
                                     });
                                     mapController.setMapStyle('');
                                   }
                                   if(currentPosition!=null){
                                      animateToCurrent();
                                   }


                                  // BlocProvider.of<MapBloc>(context).mapLoaded();
                                 });

                           }

                       ),

                       Positioned(
                         bottom:70,
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
                             onPressed: () async{
                                 mapController.animateCamera(CameraUpdate.newCameraPosition(
                                  CameraPosition(target: currentPosition, zoom: 16),));
                           //    Navigator.pushNamed(context, selectLocationRoute);
                             },
                           ),
                         ),
                       ),

                       Padding(
                         padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                         child: Card(
                           elevation: 10,
                           shape: RoundedRectangleBorder(
                             side: BorderSide(color: Colors.white70, width: 1),
                             borderRadius: BorderRadius.circular(30),
                           ),
                           child: Container(
                          //   margin: EdgeInsets.only(top: 150),
                             height: 140.0,
                             decoration: BoxDecoration(
                                 color: Colors.white,
                               borderRadius: BorderRadius.circular(25)
                             ),
                             child: Padding(
                               padding: EdgeInsets.symmetric(horizontal: 20),
                               child: Row(
                                 children: <Widget>[
                                   Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: <Widget>[
                                       Padding(
                                         padding: const EdgeInsets.only(bottom: 4.0),
                                         child: Icon(Icons.trip_origin, color: Colors.blue,),
                                       ),
                                       Icon(Icons.fiber_manual_record, color: Colors.grey, size: 10),
                                       Icon(Icons.fiber_manual_record, color: Colors.grey, size: 10),
                                       Icon(Icons.fiber_manual_record, color: Colors.grey, size: 10),
                                       Icon(Icons.fiber_manual_record, color: Colors.grey, size: 10),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 4.0),
                                         child: Icon(Icons.location_on, color: Colors.red,),
                                       ),
                                     ],
                                   ),
                                   SizedBox(width: 10,),
                                   Expanded(
                                     child: Column(
                                       mainAxisSize: MainAxisSize.max,
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       children: <Widget>[
                                         SizedBox(height: 11,),
                                         Align(
                                           alignment: Alignment.topLeft,
                                           child: Text('From'),
                                         ),
                                         SizedBox(height: 6,),
                                         InkWell(
                                           onTap: (){
                                           BlocProvider.of<DeliveryBookingBloc>(context).add(PickupNotSelectedEvent(LatLng(currentLocation.latitude,currentLocation.longitude)));
                                            final sessionToken = Uuid().v4();
                                            showSearch(context: context, delegate: AddressSearch(sessionToken),);

                                            // Navigator.of(context).popUntil((route) => route.isFirst);
                                           },
                                           child: Container(
                                             height: 30.0,
                                             color: Colors.grey,
                                             child: Padding(
                                               padding: EdgeInsets.only(left: 8),
                                               child: Align(
                                                 alignment: Alignment.centerLeft,
                                                 child:  DeliveryBookingStorage.getDeliveryBooking().source !=null ?
                                                 Text(DeliveryBookingStorage.getDeliveryBooking().source.toString())
                                                     :Text("From Where ?"),
                                               ),
                                             ),
                                           ),
                                         ),
                                         SizedBox(height: 12,),
                                         Align(
                                           alignment: Alignment.topLeft,
                                           child: Text('To'),
                                         ),
                                         SizedBox(height: 4,),
                                         InkWell(
                                           onTap: (){
                                             BlocProvider.of<DeliveryBookingBloc>(context).add(
                                                 DestinationNotSelectedEvent(LatLng(currentLocation.latitude,currentLocation.longitude)));
                                             final sessionToken = Uuid().v4();
                                             showSearch(
                                               context: context,
                                               delegate: AddressSearch(sessionToken),
                                             );
                                           },
                                           child: Container(
                                             height: 30.0,
                                             color: Colors.blueGrey,
                                             child: Padding(
                                               padding: EdgeInsets.only(left: 8),
                                               child: Align(
                                                 alignment: Alignment.centerLeft,
                                                 child: DeliveryBookingStorage.getDeliveryBooking().destination !=null ?
                                                     Text(DeliveryBookingStorage.getDeliveryBooking().destination.toString())
                                                     :Text("Where To ?")
                                               ),
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         ),
                       ),

                       if(showSourceNotExist)
                       Positioned(
                         left: 20,
                         right: 20,
                         top: MediaQuery.of(context).size.height*.62,
                         child: Container(
                           height: 40,
                           decoration: BoxDecoration(
                             color: Colors.black.withOpacity(0.65),
                             borderRadius: BorderRadius.circular(25),
                           ),
                           child: Center(
                             child: Text('please select pickup location',style: TextStyle(color: Colors.white),),
                           ),
                         ),
                       ),

                       if(showDestinationNotExist)
                         Positioned(
                           left: 20,
                           right: 20,
                           top: MediaQuery.of(context).size.height*.62,
                           child: Container(
                             height: 40,
                             decoration: BoxDecoration(
                               color: Colors.black.withOpacity(0.65),
                               borderRadius: BorderRadius.circular(25),
                             ),
                             child: Center(
                               child: Text('please select Destination location',style: TextStyle(color: Colors.white),),
                             ),
                           ),
                         ),

                       Container(
                         margin: EdgeInsets.only(bottom: 0),
                         child: GestureDetector(
                           onTap: () {
                             if(DeliveryBookingStorage.getDeliveryBooking().source== null){
                               setState(() {
                                 showSourceNotExist=true;
                               });
                                Timer(Duration(seconds: 2),(){
                                  setState(() {
                                    showSourceNotExist=false;
                                  });
                                });
                             }
                             if(DeliveryBookingStorage.getDeliveryBooking().destination== null &&
                             DeliveryBookingStorage.getDeliveryBooking().source!= null){
                               setState(() {
                                 showDestinationNotExist=true;
                               });
                               Timer(Duration(seconds: 2),(){
                                 setState(() {
                                   showDestinationNotExist=false;
                                 });
                               });
                             }
                             if(DeliveryBookingStorage.getDeliveryBooking().destination != null
                               && DeliveryBookingStorage.getDeliveryBooking().source != null) {
                                 Navigator.pushNamed(context, PackageDetailRoute);
                             }
                           },
                           child: Align(
                             alignment: Alignment.bottomCenter,
                             child: Container(
                               height: MediaQuery.of(context).size.height * .09,
                               width: MediaQuery.of(context).size.width,
                               child: Container(
                                 color: Colors.white,
                                 child: Center(
                                   child: Text('Save & Continue'),
                                 ),
                               ),
                             ),
                           ),
                         ),
                       ),

                  /*   (state is MapLoadedState) ?
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
                                   // BlocProvider.of<AuthenticationCubit>(context).loggedOut();
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
                       )
                        :Container(), */

                     ],
                   ),
                 )

        ),
      );
    }

  @override
  void dispose() {
    mapController.dispose();
    _textcontroller.dispose();
    super.dispose();
  }
  }






  /*
  *  BlocBuilder<MapBloc, MapState>(
             builder:  (BuildContext context, state){
                 return Scaffold(
                   key: _scaffoldKey,
                   drawer: Drawer(
                     child: MainDrawer(),
                   ),
                   body: Stack(
                     children: [
                       (state is MapOnLoadingState) ? Container(): Container(),
                      // DeliveryMap(),
                       BlocBuilder<DeliveryBookingBloc,DeliveryBookingState>(
                           builder: (context,DeliveryBookingState state){
                             return currentPosition== null ?
                             Center(child: SpinKitRipple(
                               color: Colors.blue,
                               size: 60.0,
                               controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                             ))
                                 : GoogleMap(
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
                                 //markers: markers,
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


                                 onMapCreated: (GoogleMapController controller) async {

                                   //BlocProvider.of<MapBloc>(context).mapLoaded();
                                   if (mounted) {
                                     setState(() {
                                       mapController = controller;
                                     });
                                     mapController.setMapStyle('');
                                   }

                                  // BlocProvider.of<MapBloc>(context).mapLoaded();
                                 });

                           }

                       ),

                       (state is MapLoadedState) ?
                       Padding(
                         padding: EdgeInsets.only(top: 65, left: 20, right: 20),
                         child: Container(
                           height: 50,
                           decoration: BoxDecoration(
                             //shape: BoxShape.circle,
                             color: Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey,
                                 offset: Offset(0.0, 1.0), //(x,y)
                                 blurRadius: 4.0,
                               ),
                             ],
                           ),
                           child:  TextField(
                             readOnly: true,
                             controller: _textcontroller,
                             onTap: () async {
                               // should show search screen here
                              // BlocProvider.of<DeliveryBookingBloc>(context).add(DestinationNotSelectedEvent(LatLng(currentLocation.latitude,currentLocation.longitude)));

                           //    BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryBookingStartEvent());
                               BlocProvider.of<DeliveryBookingBloc>(context).add(
                                   DestinationNotSelectedEvent(LatLng(currentLocation.latitude,currentLocation.longitude)));
                               final sessionToken = Uuid().v4();
                               showSearch(
                                 context: context,
                                 delegate: AddressSearch(sessionToken),
                               );

                             },
                             decoration: InputDecoration(
                               icon: Container(
                                 margin: EdgeInsets.only(right: 20),
                                 padding: EdgeInsets.only(left: 15),
                                 width: 10,
                                 height: 10,
                                 child: Icon(
                                   Icons.search,
                                   color: Colors.black,
                                 ),
                               ),
                               hintText: "Enter your destination address",
                               border: InputBorder.none,
                               contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                             ),
                           ),
                         ),
                       )
                        : Container(height: 0,),

                       (state is MapLoadedState) ?
                       Positioned(
                         bottom:45,
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
                             onPressed: () async{
                                 mapController.animateCamera(CameraUpdate.newCameraPosition(
                                  CameraPosition(target: currentPosition, zoom: 16),));
                           //    Navigator.pushNamed(context, selectLocationRoute);
                             },
                           ),
                         ),
                       ): Container(),

                         (state is MapLoadedState) ?
                       Padding(
                         padding: EdgeInsets.only(top: 120, left: 20, right: 20),
                         child: Container(
                           height: 50,
                           decoration: BoxDecoration(
                             //shape: BoxShape.circle,
                             color: Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey,
                                 offset: Offset(0.0, 1.0), //(x,y)
                                 blurRadius: 4.0,
                               ),
                             ],
                           ),
                           child:  TextField(
                             readOnly: true,
                             controller: _textcontroller,
                             onTap: () async {
                               // should show search screen here
                               // BlocProvider.of<DeliveryBookingBloc>(context).add(DestinationNotSelectedEvent(LatLng(currentLocation.latitude,currentLocation.longitude)));

                               //    BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryBookingStartEvent());
                               BlocProvider.of<DeliveryBookingBloc>(context).add(
                                   PickupNotSelectedEvent(LatLng(currentLocation.latitude,currentLocation.longitude)));
                               final sessionToken = Uuid().v4();
                               showSearch(
                                 context: context,
                                 delegate: AddressSearch(sessionToken),
                               );

                             },
                             decoration: InputDecoration(
                               icon: Container(
                                 margin: EdgeInsets.only(right: 20),
                                 padding: EdgeInsets.only(left: 15),
                                 width: 10,
                                 height: 10,
                                 child: Icon(
                                   Icons.search,
                                   color: Colors.black,
                                 ),
                               ),
                               hintText: "Enter your pickup address",
                               border: InputBorder.none,
                               contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                             ),
                           ),
                         ),
                       )
                           : Container(height: 0,),

                  /*   (state is MapLoadedState) ?
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
                                   // BlocProvider.of<AuthenticationCubit>(context).loggedOut();
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
                       )
                        :Container(), */

                     ],
                   ),
                 );
               }
          ),*/
