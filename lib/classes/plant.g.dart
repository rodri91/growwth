// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plant _$PlantFromJson(Map<String, dynamic> json) => Plant(
      json['name'] as String,
    )
      ..id = json['id'] as String
      ..created = DateTime.parse(json['created'] as String)
      ..images = (json['images'] as List<dynamic>)
          .map((e) => PlantImage.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PlantToJson(Plant instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'created': instance.created.toIso8601String(),
      'images': instance.images,
    };
