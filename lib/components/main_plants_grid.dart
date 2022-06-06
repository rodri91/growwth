import 'package:flutter/material.dart';
import 'package:growwth/classes/plant.dart';
import 'package:growwth/plant_detail_screen.dart';
import './main_plant_card.dart';

class MainPlantsGrid extends StatelessWidget {
  const MainPlantsGrid({Key? key, required this.plantsList}) : super(key: key);

  final List<Plant> plantsList;

  void _handleCardTap(context, Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantDetailScreen(plant: plant),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
      itemCount: plantsList.length,
      itemBuilder: (context, int index) {
        return InkWell(
          onTap: () {
            _handleCardTap(context, plantsList[index]);
          },
          child: MainPlantCard(
            name: plantsList[index].name,
            imagePath: plantsList[index].getLatestImage().path,
            lastUpdate: plantsList[index].getLatestImage().created,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
