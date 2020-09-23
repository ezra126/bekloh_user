import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';


class LocationService {
  static bool _serviceEnabled;
  static bool _permissionGranted;
  static Location location=Location();

  // LocationService({this.location});

  Future<LocationPermission> checkPermission() =>
      GeolocatorPlatform.instance.checkPermission();

  static Future initPlatformState() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      return null;
    }
    _permissionGranted = (await location.hasPermission()) as bool;
    // ignore: unrelated_type_equality_checks
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = (await location.requestPermission()) as bool;
      return null;
    }
  }

}