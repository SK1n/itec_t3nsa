import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itec_t3nsa/app/controllers/firebase_controller.dart';
import 'package:itec_t3nsa/app/controllers/landmark_detector_controller.dart';
import 'package:itec_t3nsa/app/controllers/maps_controller.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';
   
class HomePage extends GetView<MapsController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LandmarkDetectorController landmarkDetectorController = Get.find();
    final FirebaseController firebaseController = Get.put(FirebaseController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () async {
                await firebaseController.signOut();
                Get.offAllNamed(Routes.login);
              },
              child: const Icon(Entypo.logout),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: controller.getCurrentCameraPosition(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                EasyLoading.show();
              }
              if (snapshot.hasData) {
                EasyLoading.dismiss();
                return Obx(
                  () => SizedBox(
                    height: Get.height -
                        const Size.fromHeight(kToolbarHeight).height,
                    child: GoogleMap(
                      markers: controller.markers.value,
                      buildingsEnabled: false,
                      mapToolbarEnabled: false,
                      myLocationEnabled: false,
                      zoomControlsEnabled: true,
                      onMapCreated: (GoogleMapController contr) {
                        controller.onMapCreated(contr);
                      },
                      initialCameraPosition: snapshot.data as CameraPosition,
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
          Row(
            children: [
              InkWell(
                child: const Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Entypo.camera),
                  ),
                ),
                onTap: () async {
                  String? description =
                      await landmarkDetectorController.getLandmark(true);
                  debugPrint("description$description");
                  if (description == null) {
                    EasyLoading.showError("You must take an image");
                    return;
                  }
                  if (description.isNotEmpty) {
                    Get.toNamed(
                      Routes.resultsPage,
                      arguments: [
                        description,
                      ],
                    );
                  } else {
                    EasyLoading.showError(
                        "Sorry, we couldn't generate the images.\nPlease try again with a different image.");
                  }
                },
              ),
              InkWell(
                child: const Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Entypo.picture),
                  ),
                ),
                onTap: () async {
                  String? description =
                      await landmarkDetectorController.getLandmark(false);
                  if (description == null) {
                    EasyLoading.showError("You must take an image");
                    return;
                  }
                  if (description.isNotEmpty) {
                    Get.toNamed(
                      Routes.resultsPage,
                      arguments: [
                        description,
                      ],
                    );
                  } else {
                    EasyLoading.showError(
                        "Sorry, we couldn't generate the images.\nPlease try again with a different image.");
                  }
                },
              ),
              InkWell(
                child: const Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(FontAwesome.th),
                  ),
                ),
                onTap: () async {
                  Get.toNamed(Routes.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
