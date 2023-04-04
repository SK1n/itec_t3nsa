import 'package:itec_t3nsa/app/data/enums/landmarks_results_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'landmarks_model.g.dart';

@JsonSerializable()
class LandmarksModel {
  LandmarksModel(
    this.htmlAttributions,
    this.results,
    this.status,
  );

  final List<dynamic>? htmlAttributions;
  final List<LandmarksResultsModel>? results;
  final String? status;

  factory LandmarksModel.fromJson(Map<String, dynamic> json) =>
      _$LandmarksModelFromJson(json);

  Map<String, dynamic> toJson() => _$LandmarksModelToJson(this);
}
