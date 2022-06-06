import 'package:flutter/material.dart';
import 'package:growwth/new_plant_screen.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  void _navigateToNewPlant(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NewPlantForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/emptyScreenGraph.jpeg',
            width: 200,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Start tracking your first plant',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _navigateToNewPlant(context);
            },
            child: Text('Create new plant'.toUpperCase()),
          )
        ],
      ),
    );
  }
}
