// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landmarks_geometry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LandmarkGeometryModel _$LandmarkGeometryModelFromJson(
        Map<String, dynamic> json) =>
    LandmarkGeometryModel(
      location: json['location'] == null
          ? null
          : LandmarksLocationModel.fromJson(
              json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LandmarkGeometryModelToJson(
        LandmarkGeometryModel instance) =>
    <String, dynamic>{
      'location': instance.location,
    };
