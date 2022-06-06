import 'dart:io';

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class MainPlantCard extends StatelessWidget {
  const MainPlantCard(
      {Key? key,
      required this.name,
      this.description,
      required this.imagePath,
      required this.lastUpdate})
      : super(key: key);

  final String name;
  final String? description;
  final String imagePath;
  final DateTime lastUpdate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceVariant,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
                width: 110,
                height: 130,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline5?.apply(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                    if (description != null)
                      const SizedBox(
                        height: 8,
                      ),
                    if (description != null)
                      Text(
                        description!,
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    Container(
                      child: Text(
                        'Last picture was taken: ${timeago.format(lastUpdate)}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
