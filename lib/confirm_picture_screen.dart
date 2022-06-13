// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:growwth/classes/plant.dart';
import 'package:growwth/classes/user.dart';
import 'package:growwth/home_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ConfirmPictureScreen extends StatefulWidget {
  const ConfirmPictureScreen(
      {Key? key, required this.imagePath, this.plantName = '', this.plant})
      : super(key: key);

  final String imagePath;
  final String plantName;
  final Plant? plant;

  @override
  State<ConfirmPictureScreen> createState() => _ConfirmPictureScreenState();
}

class _ConfirmPictureScreenState extends State<ConfirmPictureScreen> {
  void _handleBackButton(context) async {
    final imageFile = File(widget.imagePath);
    await imageFile.delete();
    Navigator.pop(context);
  }

  void _handleDoneButton(context) async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();

    String saveImagePath = '';
    try {
      // Save final image
      final File imageFile = File(widget.imagePath);
      final String imageFilename = basename(imageFile.path);
      saveImagePath = '${appDirectory.path}/$imageFilename';

      await imageFile.copy(saveImagePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        behavior: SnackBarBehavior.floating,
      ));
    }

    final File file = File('${appDirectory.path}/userData.json');
    final dataMap = await jsonDecode(file.readAsStringSync());

    User user = User.fromJson(dataMap);

    if (widget.plant != null) {
      Plant plantToSave =
          user.getPlantById('61b5e680-e071-11ec-9177-e779d3554968');

      plantToSave.addImage(saveImagePath);
    } else {
      // If is a new plant
      Plant newPlant = Plant(widget.plantName);
      newPlant.addImage(saveImagePath);
      user.addPlant(newPlant);
    }

    try {
      print(jsonEncode(user));
      file.writeAsString(jsonEncode(user));

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Expanded(child: Image.file(File(widget.imagePath))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _handleBackButton(context);
                    },
                    icon: Icon(Icons.replay),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    child: GestureDetector(
                      onTap: () {
                        _handleDoneButton(context);
                      },
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: CircleBorder(),
                        ),
                        child: Icon(
                          Icons.done,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 48,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
