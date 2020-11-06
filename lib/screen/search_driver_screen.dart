import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/component/ripple_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SearchDriverScreen extends StatefulWidget {
  @override
  _SearchDriverScreenState createState() => _SearchDriverScreenState();
}

class _SearchDriverScreenState extends State<SearchDriverScreen>{
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryBookingBloc,DeliveryBookingState>(
      listener: (context,DeliveryBookingState state){

      },
     builder: (context,DeliveryBookingState state){
        if(state is DeliveryBookingNotConfirmedState){
          return SafeArea(
            child: Scaffold(
              body: Container(
                child: Stack(
                  children: [
                    GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng((state.booking.destination.latitude+state.booking.source.latitude)/2,
                              (state.booking.destination.longitude+state.booking.source.longitude)/2),
                          zoom: 15,
                        ),
                      /*  zoomControlsEnabled: false,
                        zoomGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        compassEnabled: true,
                        rotateGesturesEnabled: true,
                        tiltGesturesEnabled: true,
                        myLocationButtonEnabled: false,*/
                        onMapCreated: (GoogleMapController controller) async {
                           setState(() {
                              mapController = controller;
                            });
                          // BlocProvider.of<MapBloc>(context).mapLoaded();
                        }),
                    Container(
                      color: Colors.black45.withOpacity(0.7),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text("We are finding you a driver",style: TextStyle(color: Colors.white,fontSize: 20),),
                      ),
                    ),
                    Center(child: RippleButton()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*.8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(child: Text('CANCEL',style: TextStyle(color: Colors.blue,fontSize: 15),),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      return Container();
  });
}
}

