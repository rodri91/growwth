import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageDetail extends StatelessWidget {
  const ImageDetail({Key? key, required this.imagePath, required this.created})
      : super(key: key);

  final String imagePath;
  final DateTime created;

  void toggleStatusBar() {
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: [SystemUiOverlay.bottom],
    // );
  }

  @override
  Widget build(BuildContext context) {
    String formattedCreatedDate =
        "${created.day.toString().padLeft(2, '0')}/${created.month.toString().padLeft(2, '0')}/${created.year.toString()} ";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          GestureDetector(
            onLongPress: () {},
            child: Image.file(
              File(imagePath),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Text("Picture taken on: ${formattedCreatedDate}"),
        ],
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
