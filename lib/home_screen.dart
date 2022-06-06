import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:growwth/classes/plant.dart';
import 'package:growwth/classes/user.dart';
import 'package:growwth/components/empty_screen.dart';
import 'package:growwth/components/main_plants_grid.dart';
import 'package:growwth/new_plant_screen.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User user;
  late Future<List<Plant>> _plantsList;

  Future<List<Plant>> readUserData() async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final File file = File('${appDirectory.path}/userData.json');

    if (await file.exists()) {
      final dataMap = await jsonDecode(file.readAsStringSync());
      print(file.readAsStringSync());
      user = User.fromJson(dataMap);
    } else {
      // Creates new user and writes the file
      user = User();
      file.writeAsString(jsonEncode(user));
    }

    return user.getPlants();
  }

  void _navigateToNewPlant(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewPlantForm()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _plantsList = readUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Growwth'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.settings_outlined)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToNewPlant(context);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: FutureBuilder<List<Plant>>(
        future: _plantsList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isNotEmpty) {
              return MainPlantsGrid(plantsList: snapshot.data!);
            } else {
              return const EmptyScreen();
            }
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          return const EmptyScreen();
        },
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
