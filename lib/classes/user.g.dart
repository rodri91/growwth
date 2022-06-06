// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..plants = (json['plants'] as List<dynamic>)
      .map((e) => Plant.fromJson(e as Map<String, dynamic>))
      .toList()
  ..created = DateTime.parse(json['created'] as String);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'plants': instance.plants,
      'created': instance.created.toIso8601String(),
    };
