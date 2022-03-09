import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import '../models/memories_model/memories_model.dart';
import '../utils/init_get_it.dart';

class MemoriesScreen extends StatelessWidget {
  const MemoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memories"),
      ),
      body: FutureBuilder<DocumentList>(
        future: getIt.get<Database>().listDocuments(collectionId: "memories"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final memories = snapshot.data;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemCount: memories!.total,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                final data = memories.convertTo((p0) => MemoriesModel.fromJson(
                      p0 as Map<String, dynamic>,
                    ))[index];

                return FutureBuilder<Uint8List>(
                  future: getIt
                      .get<Storage>()
                      .getFileView(bucketId: "images", fileId: data.image),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return InkWell(
                        onTap: () {
                          _showImgDetails(context, snapshot, data);
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned.fill(
                                child: Image.memory(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    data.title,
                                    style: TextStyle(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(.7),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _showImgDetails(BuildContext context, AsyncSnapshot<Uint8List> snapshot,
      MemoriesModel data) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        insetPadding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.memory(snapshot.data!),
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
  }
}
