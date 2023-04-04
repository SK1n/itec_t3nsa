import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget landmarkTags(String description, {String? city}) {
  List list = description.split(',');
  list.add(
    city?.replaceAll(",from ", ""),
  );
  return GridView.builder(
    shrinkWrap: true,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: min(4, list.length),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: list.length > 4 ? 2 : 4,
    ),
    itemCount: list.length,
    itemBuilder: (context, index) {
      return Center(
        child: Card(
          elevation: 2,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: Text(
              list[index],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      );
    },
  );
}
