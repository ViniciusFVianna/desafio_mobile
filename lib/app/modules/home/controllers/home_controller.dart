import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/repository/home_repository.dart';

class HomeController extends GetxController {
  final _repository = HomeRepository();

  late GoogleMapController mapController;

  Rx<LatLng> latlng =  const LatLng(0,0).obs;

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  Rx<Marker> marker = const Marker(markerId: MarkerId(""),).obs;

  late StreamSubscription<Position> streamSubscription;

   Rx<CameraPosition> cameraPosition = const CameraPosition(
      target: LatLng(0,0),
      zoom: 14.4746,
  ).obs;

  @override
  void onInit() {
    determinePosition().then((Position position) {
      latlng.value =  LatLng(position.latitude, position.longitude);
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      marker.value =  Marker(
        markerId: const MarkerId("1"),
        position: latlng.value,
        infoWindow: const
        InfoWindow(title: "Minha localizações", snippet: "Minha localização pelo geolocator"),
      );
      mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                target: latlng.value,
                zoom: 14.4746,
              )));

    });
    super.onInit();
  }

  @override
  void onClose() {
    streamSubscription.cancel();
  }

    void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> determinePosition() async {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if(!serviceEnabled){
  return Future.error('O serviço de geolocalização desabilitado');
      }

      permission = await Geolocator.checkPermission();

      if( permission == LocationPermission.denied ) {
        permission = await Geolocator.requestPermission();

        if(permission == LocationPermission.denied){
          return Future.error('Permissões da localização negada');
        }
      }
      if(permission == LocationPermission.deniedForever){
        return Future.error('Permissões da localização negadas permanentemente');
      }

      Position position = await Geolocator.getCurrentPosition();

      return position;
  }

}
