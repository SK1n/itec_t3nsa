import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itec_t3nsa/app/controllers/firebase_controller.dart';
import 'package:itec_t3nsa/app/global_widgets/custom_scaffold.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';
import 'package:octo_image/octo_image.dart';

class GallerPage extends StatelessWidget {
  const GallerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseController firebaseController = Get.find();
    return CustomScaffold([
      SliverFillRemaining(
        child: FutureBuilder(
            future: firebaseController.getArrayFromFirestore(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'Hey....\n',
                              style: GoogleFonts.roboto(fontSize: 20)),
                          TextSpan(
                            text:
                                "It seems that you didn't generate any images yet.",
                            style: GoogleFonts.adamina(
                              fontSize: 20,
                              color: Get.theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return MasonryGridView.count(
                    padding: const EdgeInsets.all(16),
                    itemCount: snapshot.data!.length,
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 8,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            Routes.fullscreen,
                            arguments: [snapshot.data![index]],
                          );
                        },
                        child: Hero(
                          tag: snapshot.data![index],
                          child: OctoImage(
                            image: CachedNetworkImageProvider(
                              snapshot.data![index],
                            ),
                            errorBuilder: OctoError.icon(color: Colors.red),
                            fit: BoxFit.cover,
                            width: Get.width,
                            height: 200,
                            progressIndicatorBuilder: (context, progress) {
                              double value = 0;
                              if (progress != null &&
                                  progress.expectedTotalBytes != null) {
                                value = progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!.toInt();
                              }
                              return Center(
                                child: SizedBox(
                                  width: 14,
                                  height: 14,
                                  child:
                                      CircularProgressIndicator(value: value),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              } else {
                return Container();
              }
            }),
      )
    ], title: 'Gallery');
  }
}
