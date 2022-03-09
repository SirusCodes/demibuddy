import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/family_details_model/family_details_model.dart';
import '../utils/init_get_it.dart';

class MyFamilyScreen extends StatelessWidget {
  const MyFamilyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call Family"),
      ),
      body: FutureBuilder<DocumentList>(
        future: getIt.get<Database>().listDocuments(collectionId: "family"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final docList = snapshot.data;
            return ListView.builder(
              itemCount: docList!.total,
              itemBuilder: (context, index) {
                final data =
                    docList.convertTo((p0) => FamilyDetailsModel.fromJson(
                          p0 as Map<String, dynamic>,
                        ))[index];

                final img = getIt
                    .get<Storage>()
                    .getFileView(bucketId: "images", fileId: data.image);
                return ListTile(
                  leading: FutureBuilder<Uint8List>(
                    future: img,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          backgroundImage: MemoryImage(snapshot.data!),
                        );
                      }

                      return const CircleAvatar(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                  title: Text(data.name),
                  subtitle: Text(data.relation),
                  onTap: () => launch("tel:${data.phone}"),
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
}
