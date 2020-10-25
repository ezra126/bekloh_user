import 'dart:async';
import 'package:bekloh_user/bloc/authbloc/auth_bloc.dart';
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



class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //LatLng _center = LatLng(-8.913025, 13.202462);
  String _mapStyle;

  final _textcontroller = TextEditingController();
  GoogleMapController mapController;
  Location location ;
  LocationData currentLocation;
  LatLng currentPosition;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  void initState() {
    super.initState();

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

      if (currentPosition != null) {
        BlocProvider.of<MapBloc>(context).mapLoaded();
      }
    });
        }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(Duration(seconds: 2),(){
     // BlocProvider.of<MapBloc>(context).mapLoaded();
    });

  }


    @override
    Widget build(BuildContext context) {
     return WillPopScope(
        onWillPop:() async{
          BlocProvider.of<DeliveryBookingBloc>(context).add(BackPressedEvent());
          return false;
        },
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child:  BlocBuilder<MapBloc, MapState>(
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
                              // mapController.animateCamera(CameraUpdate.newCameraPosition(
                             //    CameraPosition(target: currentPosition, zoom: 16),));
                               Navigator.pushNamed(context, selectLocationRoute);
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

                     (state is MapLoadedState) ?
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
                        :Container(),

                     ],
                   ),
              /*     bottomSheet:
                  //  (state is MapLoadedState) ?
                    BlocBuilder<DeliveryBookingBloc, DeliveryBookingState>(
                       builder: (BuildContext context, DeliveryBookingState state) {
                         if (state is DeliveryBookingNotInitializedState) {
                           return Container(height: 100,
                             child:  RaisedButton(
                               onPressed: () async{
                                 final Connectivity _connectivity = Connectivity();
                                 _connectivity.onConnectivityChanged.listen((connectionResult){
                                   if (connectionResult == ConnectivityResult.wifi || connectionResult == ConnectivityResult.mobile ) {
                                     BlocProvider.of<AuthenticationCubit>(context).loggedOut();
                                     // Timer(Duration(seconds: 5), () => Navigator.pushNamed(context, welcomeRoute));
                                   }
                                 });

                                 //  BlocProvider.of<AuthenticationCubit>(context).loggedOut();
                               },
                               child: Text('Log out'),
                             ),);
                         }
                         if(state is DestinationNotSelectedState){
                           Container(
                             child: Center(child: Text('Add Location'),),
                           );
                         }
                         return Container(height: 100,);
                       })
                       //  : Container(height: 0)

           */
                 );
               }
          ),
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
