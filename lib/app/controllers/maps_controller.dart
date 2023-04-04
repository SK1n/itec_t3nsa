import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itec_t3nsa/app/controllers/dalle_image_editor_controller.dart';
import 'package:itec_t3nsa/app/core/values/strings.dart';
import 'package:itec_t3nsa/app/data/enums/landmarks_model.dart';
import 'package:itec_t3nsa/app/data/enums/landmarks_results_model.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';
import 'package:logger/logger.dart';

class MapsController extends GetxController {
  final DALLEImageEditorController dalle =
      Get.put(DALLEImageEditorController());

  final markers = <Marker>{}.obs;

  late GoogleMapController mapController;

  late Position position;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    getPlaces();
  }

  Future<Uri> get searchUri async {
    Position currentPosition = await determinePosition();
    const api = "&key=${const String.fromEnvironment("GOOGLE_KEY")}";
    String location =
        "location=${currentPosition.latitude},${currentPosition.longitude}";
    const type = "&type=tourist_attraction";
    const radius = "&radius=5000";

    final url =
        Uri.parse(Strings.baseUrlNearBySearch + location + radius + type + api);
    debugPrint(url.toString());
    return url;
  }

  getPlaces() async {
    Logger logger = Logger();
    final response = await http.get(await searchUri);
    final LandmarksModel landmarksModel =
        LandmarksModel.fromJson(await jsonDecode(response.body));
    final List<LandmarksResultsModel> results = landmarksModel.results!;
    markers.value.clear();

    logger.d(await jsonDecode(response.body));

    markers.value = results
        .map(
          (element) => Marker(
            markerId: MarkerId(
              element.placeId ?? Random().nextInt(1333).toString(),
            ),
            position: LatLng(
              element.geometry!.location!.lat!,
              element.geometry!.location!.lng!,
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueAzure,
            ),
            onTap: () async {
              double lat = element.geometry!.location!.lat!;
              double lng = element.geometry!.location!.lng!;
              final placemarks = await placemarkFromCoordinates(lat, lng);
              Get.defaultDialog(
                title: "Do you want to generate images for ${element.name}?",
                middleText: "",
                onCancel: () {},
                onConfirm: () async {
                  Get.close(1);
                  Get.toNamed(
                    Routes.resultsPage,
                    arguments: [
                      "${element.name}",
                      ",from ${placemarks.first.locality}",
                    ],
                  );
                },
              );
            },
          ),
        )
        .toSet();
    logger.d("${markers.first.position}");
    // logger.d(markers);
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  getCurrentCameraPosition() async {
    position = await determinePosition();
    return CameraPosition(
      target: LatLng(
        position.latitude,
        position.longitude,
      ),
      zoom: 13,
    );
  }

  @override
  void onReady() async {
    await setCurrentLocation();
    super.onReady();
  }

  setCurrentLocation() async {}
}
