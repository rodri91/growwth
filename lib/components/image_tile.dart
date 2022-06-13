import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:growwth/image_detail_screen.dart';

import 'package:timeago/timeago.dart' as timeago;

class ImageTile extends StatelessWidget {
  const ImageTile({Key? key, required this.imagePath, required this.created})
      : super(key: key);

  final String imagePath;
  final DateTime created;

  void _handleImageTap(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImageDetail(
          imagePath: imagePath,
          created: created,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Ink.image(
              image: FileImage(File(imagePath)),
              fit: BoxFit.cover,
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  _handleImageTap(context);
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              timeago.format(created),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.apply(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
