import 'package:flutter/material.dart';
import 'package:food_shop/extentions/double.extension.dart';
import 'package:food_shop/styles/colors.dart';
import 'package:food_shop/styles/constant.dart';
import 'package:food_shop/styles/dimensions.dart';
import 'package:food_shop/views/personal/dependencies/address/address.controllers.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  final double? size;
  final LatLng? initCamera;

  const Map({
    Key? key,
    this.size,
    this.initCamera,
  }) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late double size;
  late CameraPosition _camera;

  @override
  void initState() {
    super.initState();
    size = widget.size?.h ?? Dimensions.kHeight150;

    _initialCamera();
  }

  void _initialCamera() {
    LatLng initialLatLng = widget.initCamera ?? defaultCoordinates;

    if (Get.find<AddressController>().addresses.isNotEmpty) {
      final address = Get.find<AddressController>().addresses.first;
      initialLatLng = address.coordinates.toLatLng();
    }

    _camera = CameraPosition(
      target: initialLatLng,
      zoom: 7,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.h),
        border: Border.all(width: 2, color: kTertiaryColor),
      ),
      height: size,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0.h),
        child: Stack(
          fit: StackFit.expand,
          children: [
            GetBuilder<AddressController>(
              builder: (controller) {
                return GoogleMap(
                  initialCameraPosition: _camera,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: false,
                  onCameraIdle: () {},
                  onMapCreated: (_controller) {
                    controller.cameraController.controller = _controller;
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
