import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itec_t3nsa/app/core/values/strings.dart';
import 'package:itec_t3nsa/app/data/enums/nearby_model.dart';
import 'package:logger/logger.dart';

class MapsController extends GetxController {
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(45.760696, 21.226788),
    zoom: 13,
  );
  late Position currentPosition;

  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

  Uri get searchUri {
    const api = "&key=${const String.fromEnvironment("GOOGLE_KEY")}";
    final location =
        "lcoation=${currentPosition.latitude},${currentPosition.longitude}}";
    const rankBy = "&rankby=distance";

    final url =
        Uri.parse(Strings.baseUrlNearBySearch + location + rankBy + api);
    return url;
  }

  getPlaces() async {
    Logger logger = Logger();
    try {
      logger.d('aaa');
      final response = await http.get(searchUri);
      logger.d(response);
      final decodedResponse = await jsonDecode(response.body) as Map;

      final results = await decodedResponse['results'] as List;
      logger.d(results);
    } catch (e) {}
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void onReady() async {
    currentPosition = await _determinePosition();
    cameraPosition = CameraPosition(
      target: LatLng(
        currentPosition.latitude,
        currentPosition.longitude,
      ),
      zoom: 13,
    );
    await getPlaces();
    super.onReady();
  }
}
