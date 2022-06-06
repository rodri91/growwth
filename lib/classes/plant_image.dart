import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'plant_image.g.dart';

var uuid = const Uuid();

@JsonSerializable()
class PlantImage {
  PlantImage(this.path);

  String path;
  DateTime created = DateTime.now();
  String id = uuid.v1();

  factory PlantImage.fromJson(Map<String, dynamic> json) =>
      _$PlantImageFromJson(json);

  Map<String, dynamic> toJson() => _$PlantImageToJson(this);
}
