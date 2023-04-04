import 'package:json_annotation/json_annotation.dart';

part 'landmarks_location_model.g.dart';

@JsonSerializable()
class LandmarksLocationModel {
  LandmarksLocationModel({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory LandmarksLocationModel.fromJson(Map<String, dynamic> json) =>
      _$LandmarksLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LandmarksLocationModelToJson(this);
}
