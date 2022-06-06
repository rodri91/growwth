import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:growwth/classes/plant.dart';
import 'package:growwth/confirm_picture_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen(
      {Key? key, required this.camera, this.plantName = '', this.plant})
      : super(key: key);

  final CameraDescription camera;
  final String plantName;
  final Plant? plant;

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool showImageLayer = false;
  bool canShowImageLayer = false;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller.initialize();

    var imagesLength = widget.plant?.images.length ?? 0;
    if (imagesLength > 0) {
      showImageLayer = true;
      canShowImageLayer = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void takePicture(context) async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Attempt to take a picture and then get the location
      // where the image file is saved.
      final image = await _controller.takePicture();
      await Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) =>
              ConfirmPictureScreen(
            imagePath: image.path,
            plantName: widget.plantName,
            plant: widget.plant,
          ),
          transitionDuration: const Duration(seconds: 0),
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } catch (e) {
      // If an error occurs, log the error to the console.
      print(e);
    }
  }

  _handleImageLayerPress() {
    if (!canShowImageLayer) {
      return null;
    } else {
      return () {
        setState(() {
          showImageLayer = !showImageLayer;
        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        CameraPreview(_controller),
                        if (showImageLayer)
                          Opacity(
                            opacity: .5,
                            child: Image.file(
                              File(widget.plant!.getLatestImage().path),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              takePicture(context);
                            },
                            splashColor: Colors.white,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: _handleImageLayerPress(),
                            color: Theme.of(context).colorScheme.primary,
                            icon: Icon(
                              showImageLayer
                                  ? Icons.layers_clear_outlined
                                  : Icons.layers_outlined,
                              color: canShowImageLayer
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
