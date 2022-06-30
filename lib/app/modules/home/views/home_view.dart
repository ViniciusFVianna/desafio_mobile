import 'package:desafio_mobile/utilities/constant_string.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ConstantString.appName,
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700
          ),),
        leading: Container(),
        leadingWidth: 0,
      ),
      body: Obx(() => SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: GoogleMap(
          initialCameraPosition: controller.cameraPosition.value,
          onMapCreated: controller.onMapCreated,
          zoomGesturesEnabled: true,
          compassEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          mapType: MapType.normal,
          markers: Set.of({controller.marker.value}),
            ),
        ),
      ),
    );
  }
}
