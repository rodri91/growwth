import 'package:growwth/classes/plant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  List<Plant> plants = [];
  DateTime created = DateTime.now();

  User();

  void addPlant(Plant plant) {
    try {
      plants.add(plant);
    } catch (e) {
      print(e);
    }
  }

  List<Plant> getPlants() {
    return plants;
  }

  bool isNewUser() {
    return plants.isEmpty;
  }

  Plant getPlantById(String id) {
    return plants.firstWhere((element) => element.id == id);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
