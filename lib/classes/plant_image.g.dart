// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantImage _$PlantImageFromJson(Map<String, dynamic> json) => PlantImage(
      json['path'] as String,
    )
      ..created = DateTime.parse(json['created'] as String)
      ..id = json['id'] as String;

Map<String, dynamic> _$PlantImageToJson(PlantImage instance) =>
    <String, dynamic>{
      'path': instance.path,
      'created': instance.created.toIso8601String(),
      'id': instance.id,
    };
