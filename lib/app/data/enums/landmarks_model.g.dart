// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landmarks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LandmarksModel _$LandmarksModelFromJson(Map<String, dynamic> json) =>
    LandmarksModel(
      json['htmlAttributions'] as List<dynamic>?,
      (json['results'] as List<dynamic>?)
          ?.map(
              (e) => LandmarksResultsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as String?,
    );

Map<String, dynamic> _$LandmarksModelToJson(LandmarksModel instance) =>
    <String, dynamic>{
      'htmlAttributions': instance.htmlAttributions,
      'results': instance.results,
      'status': instance.status,
    };
