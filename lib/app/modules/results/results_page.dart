import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:itec_t3nsa/app/controllers/dalle_image_editor_controller.dart';
import 'package:itec_t3nsa/app/controllers/firebase_controller.dart';
import 'package:itec_t3nsa/app/global_widgets/custom_scaffold.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';
import 'package:octo_image/octo_image.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DALLEImageEditorController dalle = Get.find();
    final String description = Get.arguments[0];
    final FirebaseController firebaseController = Get.find();
    return CustomScaffold(
      [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: dalle.editImage(description).timeout(
                  const Duration(
                    minutes: 5,
                  ),
                  onTimeout: () {
                    EasyLoading.showError("We couldn't generate the images");
                    Get.back();
                    return [];
                  },
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<dynamic> images = snapshot.data!;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.fullscreen,
                                      arguments: [images[index]]);
                                },
                                child: Hero(
                                  tag: images[index],
                                  child: OctoImage(
                                    image: CachedNetworkImageProvider(
                                      images[index],
                                    ),
                                    errorBuilder:
                                        OctoError.icon(color: Colors.red),
                                    fit: BoxFit.cover,
                                    width: Get.width,
                                    height: 200,
                                    progressIndicatorBuilder:
                                        (context, progress) {
                                      double value = 0;
                                      if (progress != null &&
                                          progress.expectedTotalBytes != null) {
                                        value = progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes!
                                                .toInt();
                                      }
                                      return Center(
                                        child: SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: CircularProgressIndicator(
                                              value: value),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: images.length,
                      shrinkWrap: true,
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ),
      ],
      title: "Results",
    );
  }
}
