// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'landmarks_results_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LandmarksResultsModel _$LandmarksResultsModelFromJson(
        Map<String, dynamic> json) =>
    LandmarksResultsModel(
      json['businessStatus'] as String?,
      json['geometry'] == null
          ? null
          : LandmarkGeometryModel.fromJson(
              json['geometry'] as Map<String, dynamic>),
      json['icon'] as String?,
      json['iconBackgroundColor'] as String?,
      json['iconMaskBaseUri'] as String?,
      json['name'] as String?,
      json['permanentlyClosed'] as bool?,
      json['placeId'] as String?,
      (json['rating'] as num?)?.toDouble(),
      json['reference'] as String?,
      json['scope'] as String?,
      (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['userRatingsTotal'] as int?,
      json['vicinity'] as String?,
    );

Map<String, dynamic> _$LandmarksResultsModelToJson(
        LandmarksResultsModel instance) =>
    <String, dynamic>{
      'businessStatus': instance.businessStatus,
      'geometry': instance.geometry,
      'icon': instance.icon,
      'iconBackgroundColor': instance.iconBackgroundColor,
      'iconMaskBaseUri': instance.iconMaskBaseUri,
      'name': instance.name,
      'permanentlyClosed': instance.permanentlyClosed,
      'placeId': instance.placeId,
      'rating': instance.rating,
      'reference': instance.reference,
      'scope': instance.scope,
      'types': instance.types,
      'userRatingsTotal': instance.userRatingsTotal,
      'vicinity': instance.vicinity,
    };
