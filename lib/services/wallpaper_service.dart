import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart' as image;
import 'package:appwrite/appwrite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';

import '../utils/constants.dart';

const wallpaperTask = "wallpaperTask";

Future<void> changeWallpaper() async {
  final client =
      Client().setEndpoint(APPWRITE_ENDPOINT).setProject(APPWRITE_PROJECT);

  final database = Database(client);

  final patient = await database.getDocument(
      collectionId: "6228781dd6cc1290324d", documentId: userId);

  final familyIds = patient.data["family"] as List;
  if (familyIds.isEmpty) return;

  final randomFamilyMember =
      familyIds[Random().nextInt(familyIds.length)] as String;

  final family = await database.getDocument(
      collectionId: "family", documentId: randomFamilyMember);
  final name = family.data["name"];
  final image = family.data["image"];

  final file =
      await Storage(client).getFileDownload(bucketId: "images", fileId: image);

  setWallpaper(file, name);
}

Future<void> setWallpaper(Uint8List file, String name) async {
  final background = image.decodeImage(file);
  if (background == null) return;

  await WallpaperManagerFlutter().setwallpaperfromFile(
      await createTempFile(file, name), WallpaperManagerFlutter.LOCK_SCREEN);

  image.drawStringCentered(background, image.arial_48, name,
      y: (background.height * 0.75).toInt());

  await WallpaperManagerFlutter().setwallpaperfromFile(
      await createTempFile(image.encodePng(background), "$name-text"),
      WallpaperManagerFlutter.HOME_SCREEN);
}

Future<File> createTempFile(List<int> data, String name) async {
  Directory tempDir = await getTemporaryDirectory();
  return File("${tempDir.path}/$name")
    ..create()
    ..writeAsBytesSync(data);
}
