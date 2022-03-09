import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/family_details_model/family_details_model.dart';

const _mockFamily = [
  FamilyDetailsModel(
    imageUrl: "https://thumbs.dreamstime.com/b/woman-portrait-23496008.jpg",
    name: "Name",
    number: "1234567890",
    relation: "brother",
  ),
  FamilyDetailsModel(
    imageUrl: "https://thumbs.dreamstime.com/b/woman-portrait-23496008.jpg",
    name: "Name",
    number: "1234567890",
    relation: "brother",
  ),
  FamilyDetailsModel(
    imageUrl: "https://thumbs.dreamstime.com/b/woman-portrait-23496008.jpg",
    name: "Name",
    number: "1234567890",
    relation: "brother",
  ),
];

class MyFamilyScreen extends StatelessWidget {
  const MyFamilyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call Family"),
      ),
      body: ListView.builder(
        itemCount: _mockFamily.length,
        itemBuilder: (context, index) {
          final data = _mockFamily[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(data.imageUrl),
            ),
            title: Text(data.name),
            subtitle: Text(data.relation),
            onTap: () => launch("tel:${data.number}"),
          );
        },
      ),
    );
  }
}
