// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landmarks_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LandmarksLocationModel _$LandmarksLocationModelFromJson(
        Map<String, dynamic> json) =>
    LandmarksLocationModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LandmarksLocationModelToJson(
        LandmarksLocationModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
