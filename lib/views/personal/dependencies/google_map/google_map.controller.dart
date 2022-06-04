import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  late Position _position;
  Position get position => _position;

  late Placemark _placemark = Placemark();
  Placemark get placemark => _placemark;

  late Position _pickPosition;
  Position get pickPosition => _pickPosition;

  late Placemark _pickPlacemark = Placemark();
  Placemark get pickPlacemark => _pickPlacemark;

  late GoogleMapController _controller;
  set controller(GoogleMapController value) {
    _controller = value;
  }

  @override
  void onClose() {
    _controller.dispose();
  }

  void updatePosition(CameraPosition cameraPosition, bool isABC) {}
}
