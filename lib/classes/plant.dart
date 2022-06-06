import 'package:growwth/classes/plant_image.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'plant.g.dart';

var uuid = const Uuid();

@JsonSerializable()
class Plant {
  String name = '';
  String id = '';
  DateTime created = DateTime.now();
  List<PlantImage> images = [];

  Plant(this.name) {
    id = uuid.v1();
  }

  void addImage(String imagePath) {
    // Create image
    PlantImage newImage = PlantImage(imagePath);
    images.add(newImage);
  }

  PlantImage getLatestImage() {
    images.sort((a, b) => b.created.compareTo(a.created));
    return images.first;
  }

  List<PlantImage> getAllImages() {
    images.sort((a, b) => b.created.compareTo(a.created));
    return images;
  }

  factory Plant.fromJson(Map<String, dynamic> json) => _$PlantFromJson(json);

  Map<String, dynamic> toJson() => _$PlantToJson(this);
}
