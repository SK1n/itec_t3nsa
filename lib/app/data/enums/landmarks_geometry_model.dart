import 'package:json_annotation/json_annotation.dart';

import 'landmarks_location_model.dart';
part 'landmarks_geometry_model.g.dart';

@JsonSerializable()
class LandmarkGeometryModel {
  LandmarkGeometryModel({
    this.location,
  });

  LandmarksLocationModel? location;

  factory LandmarkGeometryModel.fromJson(Map<String, dynamic> json) =>
      _$LandmarkGeometryModelFromJson(json);

  Map<String, dynamic> toJson() => _$LandmarkGeometryModelToJson(this);
}
