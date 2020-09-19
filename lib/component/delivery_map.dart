import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryMap extends StatefulWidget {
  @override
  _DeliveryMapState createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {
  Completer<GoogleMapController> _completer = Completer();
  LatLng _center = LatLng(-8.913025, 13.202462);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:  GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 13.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },),
      ),
    );
  }
}
