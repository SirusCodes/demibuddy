import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/wallpaper_service.dart';
import '../utils/constants.dart';
import '../utils/init_get_it.dart';
import 'game_screen.dart';
import 'memories_screen.dart';
import 'my_family_screen.dart';
import 'tasks_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  static const _careTakerCallTime = "care-taker-call-time";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    // TODO: remove anon sign
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      try {
        log((await getIt.get<Account>().get()).$id);
      } catch (_) {
        getIt.get<Account>().createAnonymousSession();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      final closeTime = getIt.get<SharedPreferences>().getInt(
            _careTakerCallTime,
          );

      if (closeTime == null) return;

      var difference = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(closeTime));
      if (difference < const Duration(seconds: 40)) {
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/demibuddy.wav"),
          autoStart: true,
        );
      }

      getIt.get<SharedPreferences>().remove(_careTakerCallTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("DemiBuddy"),
        centerTitle: true,
      ),
      body: ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.square((size.width - 60) / 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        child: IconTheme(
          data: const IconThemeData(size: 35),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            padding: const EdgeInsets.all(15),
            children: [
              _buildButton(
                onPressed: null,
                onLongPress: () => _callCareTaker(isSOS: true),
                style: ElevatedButton.styleFrom(primary: Colors.red.shade400),
                icon: const Icon(Icons.notifications_active),
                title: "SOS",
              ),
              _buildButton(
                onPressed: _callCareTaker,
                icon: const Icon(Icons.call),
                title: "Call caretaker",
              ),
              _buildButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GameScreen()),
                ),
                icon: const Icon(Icons.games),
                title: "Play Games",
              ),
              _buildButton(
                onPressed: () => DeviceApps.openApp("com.ichi2.anki"),
                icon: const Icon(Icons.games),
                title: "Play Anki",
              ),
              _buildButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MyFamilyScreen()),
                ),
                icon: const Icon(Icons.family_restroom),
                title: "My Family",
              ),
              _buildButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const MemoriesScreen()),
                ),
                icon: const Icon(Icons.photo_album),
                title: "Memories",
              ),
              _buildButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TasksScreen()),
                ),
                icon: const Icon(Icons.notifications),
                title: "Tasks",
              ),
              _buildButton(
                onPressed: () {
                  changeWallpaper();
                },
                icon: const Icon(Icons.image),
                title: "Change Wallpaper",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required Icon icon,
    required String title,
    required VoidCallback? onPressed,
    ButtonStyle? style,
    VoidCallback? onLongPress,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      onLongPress: onLongPress,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _callCareTaker({bool isSOS = false}) async {
    final userDoc = await getIt.get<Database>().getDocument(
          collectionId: "6228781dd6cc1290324d",
          documentId: userId,
        );

    final caretakerId = userDoc.data["caretaker"];

    final careTakerDoc = await getIt.get<Database>().getDocument(
          collectionId: "caretaker",
          documentId: caretakerId,
        );

    if (!isSOS) {
      getIt.get<SharedPreferences>().setInt(
            _careTakerCallTime,
            DateTime.now().millisecondsSinceEpoch,
          );
    }

    launch("tel:${careTakerDoc.data["phone"]}");
  }
}
