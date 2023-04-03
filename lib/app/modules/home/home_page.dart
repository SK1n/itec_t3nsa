import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itec_t3nsa/app/controllers/firebase_controller.dart';
import 'package:itec_t3nsa/app/controllers/landmark_detector_controller.dart';
import 'package:itec_t3nsa/app/controllers/maps_controller.dart';
import 'package:itec_t3nsa/app/global_widgets/custom_scaffold.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LandmarkDetectorController landmarkDetectorController = Get.find();
    final FirebaseController firebaseController = Get.put(FirebaseController());
    final MapsController mapsController = Get.find();
    return CustomScaffold(
      [
        SliverFillRemaining(
          child: GoogleMap(
            buildingsEnabled: false,
            mapToolbarEnabled: false,
            myLocationEnabled: false,
            zoomControlsEnabled: true,
            mapType: MapType.hybrid,
            onMapCreated: (GoogleMapController controller) {
              mapsController.googleMapController.complete(controller);
            },
            initialCameraPosition: mapsController.cameraPosition,
          ),
        )

        //   SliverFillRemaining(
        //     hasScrollBody: false,
        //     child: Column(
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.only(
        //               left: 8.0, top: 8.0, right: 8.0, bottom: 20),
        //           child: SizedBox(
        //             height: 540,
        //             child: FanCarouselImageSlider(
        //               initalPageIndex: 1,
        //               imagesLink: const [
        //                 'assets/sv_0.png',
        //                 'assets/sv_1.png',
        //                 'assets/sv_2.png',
        //                 'assets/sv_3.png',
        //                 'assets/sv_4.png',
        //               ],
        //               isAssets: true,
        //             ),
        //           ),
        //         ),
        //         OutlinedButton.icon(
        //           icon: const Icon(Entypo.camera),
        //           onPressed: () async {
        //             String? description =
        //                 await landmarkDetectorController.getLandmark(true);
        //             debugPrint("description$description");
        //             if (description == null) {
        //               EasyLoading.showError("You must take an image");
        //               return;
        //             }
        //             if (description.isNotEmpty) {
        //               Get.toNamed(
        //                 Routes.resultsPage,
        //                 arguments: [
        //                   description,
        //                 ],
        //               );
        //             } else {
        //               EasyLoading.showError(
        //                   "Sorry, we couldn't generate the images.\nPlease try again with a different image.");
        //             }
        //           },
        //           style: FilledButton.styleFrom(
        //             minimumSize: Size(Get.width - 20, 30),
        //             padding: const EdgeInsets.all(10),
        //           ),
        //           label: Text(
        //             'Use camera'.toUpperCase(),
        //           ),
        //         ),
        //         OutlinedButton.icon(
        //           icon: const Icon(Entypo.picture),
        //           onPressed: () async {
        //             String? description =
        //                 await landmarkDetectorController.getLandmark(false);
        //             if (description == null) {
        //               EasyLoading.showError("You must take an image");
        //               return;
        //             }
        //             if (description.isNotEmpty) {
        //               Get.toNamed(
        //                 Routes.resultsPage,
        //                 arguments: [
        //                   description,
        //                 ],
        //               );
        //             } else {
        //               EasyLoading.showError(
        //                   "Sorry, we couldn't generate the images.\nPlease try again with a different image.");
        //             }
        //           },
        //           style: FilledButton.styleFrom(
        //               minimumSize: Size(Get.width - 20, 30),
        //               padding: const EdgeInsets.all(10)),
        //           label: Text(
        //             'Pick image from gallery'.toUpperCase(),
        //           ),
        //         ),
        //         OutlinedButton.icon(
        //           icon: const Icon(FontAwesome.th),
        //           onPressed: () {
        //             Get.toNamed(Routes.gallery);
        //           },
        //           style: FilledButton.styleFrom(
        //             minimumSize: Size(Get.width - 20, 30),
        //             padding: const EdgeInsets.all(10),
        //           ),
        //           label: const Text(
        //             'See images already generated',
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ],
      title: "Home",
      trailing: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: InkWell(
            onTap: () async {
              await firebaseController.signOut();
              Get.offAllNamed(Routes.login);
            },
            child: const Icon(Entypo.logout)),
      ),
    );
  }
}
