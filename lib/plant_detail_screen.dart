import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:growwth/camera_screen.dart';
import 'package:growwth/classes/plant.dart';
import 'package:growwth/classes/plant_image.dart';
import 'package:growwth/components/image_tile.dart';
import 'package:growwth/new_plant_screen.dart';

import 'package:timeago/timeago.dart' as timeago;

class PlantDetailScreen extends StatefulWidget {
  const PlantDetailScreen({Key? key, required this.plant}) : super(key: key);

  final Plant plant;

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  late PlantImage latestImage;
  late List<PlantImage> images;

  @override
  void initState() {
    // TODO: implement initState
    latestImage = widget.plant.getLatestImage();
    images = widget.plant.getAllImages().skip(1).toList();
    super.initState();
  }

  void _handleFloatingButtonPress(context) async {
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraScreen(
          camera: firstCamera,
          plant: widget.plant,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(widget.plant.name),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 24,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 250,
                  child: ImageTile(
                    imagePath: latestImage.path,
                    created: latestImage.created,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ImageTile(
                      imagePath: images[index].path,
                      created: images[index].created,
                    );
                  },
                  childCount: images.length,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _handleFloatingButtonPress(context);
        },
        isExtended: true,
        icon: Icon(Icons.camera_alt),
        label: const Text('Take new picture'),
      ),
    );
  }
}
