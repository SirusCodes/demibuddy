import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../models/memories_model/memories_model.dart';

const _mockMemories = [
  MemoriesModel(
    title: "name",
    imageUrl: "https://thumbs.dreamstime.com/b/woman-portrait-23496008.jpg",
    description:
        "Decription Decription Decription Decription Decription DecriptionDecription Decription Decription Decription Decription Decription",
  ),
  MemoriesModel(
    title: "name",
    imageUrl: "https://thumbs.dreamstime.com/b/woman-portrait-23496008.jpg",
    description:
        "Decription Decription Decription Decription Decription DecriptionDecription Decription Decription Decription Decription Decription",
  ),
  MemoriesModel(
    title: "name",
    imageUrl: "https://thumbs.dreamstime.com/b/woman-portrait-23496008.jpg",
    description:
        "Decription Decription Decription Decription Decription DecriptionDecription Decription Decription Decription Decription Decription",
  ),
  MemoriesModel(
    title: "name",
    imageUrl: "https://thumbs.dreamstime.com/b/woman-portrait-23496008.jpg",
    description:
        "Decription Decription Decription Decription Decription DecriptionDecription Decription Decription Decription Decription Decription",
  ),
];

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memories"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemCount: _mockMemories.length,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          final data = _mockMemories[index];

          return InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => Dialog(
                  insetPadding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: CachedNetworkImage(imageUrl: data.imageUrl),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(data.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(imageUrl: data.imageUrl),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data.title,
                        style: const TextStyle(
                          shadows: [
                            Shadow(
                              color: Colors.white,
                              offset: Offset(.5, .5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
