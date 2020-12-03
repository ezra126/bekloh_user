import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class AddPickDestinationMapWidget extends StatefulWidget {
  final LatLng initialLoc;
  final Function selectedPosition;
  final Function fetchName;
  const AddPickDestinationMapWidget({Key key, this.initialLoc,this.selectedPosition,this.fetchName}) : super(key: key);
  @override
  AddPickDestinationMapWidgetState createState() => AddPickDestinationMapWidgetState();
}
class AddPickDestinationMapWidgetState extends State<AddPickDestinationMapWidget> {
  GoogleMapController googleMapController;
  Set<Marker> markers = Set<Marker>();
  LatLng _cameraPosition;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor sourceIcon;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: widget.initialLoc,
          zoom: 16,
        ),
        zoomControlsEnabled: false,
        zoomGesturesEnabled: true,
        scrollGesturesEnabled: true,
        compassEnabled: true,
        rotateGesturesEnabled: true,
        tiltGesturesEnabled: true,
        myLocationButtonEnabled: false,
        markers: markers,
       // onCameraIdle: fetchLocationName,
        onCameraMove: ((_position) => _updatePosition(_position)),
        onMapCreated: (GoogleMapController controller) async {
          setState(() {
            googleMapController= controller;
          });
          setMapPins(widget.initialLoc);
          //_Controller.complete(controller);
          /*   await location.getLocation().then((LocationData initialLoc) async {
                              LatLng latLng = LatLng(initialLoc.latitude, initialLoc.longitude);
                              CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 16);
                              final GoogleMapController controller=await  _Controller.future;
                              controller.moveCamera(cameraUpdate);
                            }); */
        });
  }

  void fetchLocationName(){
    widget.fetchName(true);
  }

  void _updatePosition(CameraPosition _position) {
    print('inside updatePosition ${_position.target.latitude} ${_position.target.longitude}');
    Marker marker = markers.firstWhere((p) => p.markerId == MarkerId('marker_2'), orElse: () => null);

    setState(() {
      markers.remove(marker);
      markers.add(
        Marker(
          markerId: MarkerId('marker_2'),
          position: LatLng(_position.target.latitude, _position.target.longitude),
          draggable: true,
          icon: pinLocationIcon,


        ),
      );
    });
    setState(() {
    /*  if(_position==null){
        _cameraPosition=LatLng(widget.initialLoc.latitude,widget.initialLoc.longitude);
      }*/
      _cameraPosition=LatLng(_position.target.latitude,_position.target.longitude);
      widget.selectedPosition(_cameraPosition);
    });
  }

  void setMapPins(LatLng currentLoc) {
    setState(() {
      // source pin
      markers.add(Marker(
          markerId: MarkerId('marker_2'),
          draggable: true,
          position: currentLoc,
          icon: sourceIcon)); // destination pin
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    googleMapController.dispose();
    super.dispose();
  }
}
