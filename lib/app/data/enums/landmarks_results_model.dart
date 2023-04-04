import 'package:itec_t3nsa/app/data/enums/landmarks_geometry_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'landmarks_results_model.g.dart';

@JsonSerializable()
class LandmarksResultsModel {
  const LandmarksResultsModel(
    this.businessStatus,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.permanentlyClosed,
    this.placeId,
    this.rating,
    this.reference,
    this.scope,
    this.types,
    this.userRatingsTotal,
    this.vicinity,
  );

  final String? businessStatus;
  final LandmarkGeometryModel? geometry;
  final String? icon;
  final String? iconBackgroundColor;
  final String? iconMaskBaseUri;
  final String? name;
  final bool? permanentlyClosed;
  final String? placeId;
  final double? rating;
  final String? reference;
  final String? scope;
  final List<String>? types;
  final int? userRatingsTotal;
  final String? vicinity;

  factory LandmarksResultsModel.fromJson(Map<String, dynamic> json) =>
      _$LandmarksResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LandmarksResultsModelToJson(this);
}
