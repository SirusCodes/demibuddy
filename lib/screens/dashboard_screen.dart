import 'package:appwrite/appwrite.dart';
import 'package:demicare/screens/my_family_screen.dart';
import 'package:demicare/services/wallpaper_service.dart';
import 'package:demicare/utils/constants.dart';
import 'package:demicare/utils/init_get_it.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
    // getIt.get<Account>().deleteSessions();
    getIt.get<Account>().createAnonymousSession();
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
      if (difference < const Duration(seconds: 4)) {
        // TODO: add consoling voice
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
          ),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          padding: const EdgeInsets.all(15),
          children: [
            ElevatedButton.icon(
              onPressed: null,
              onLongPress: () => _callCareTaker(isSOS: true),
              style: ElevatedButton.styleFrom(primary: Colors.red.shade400),
              icon: const Icon(Icons.notifications_active),
              label: const Text("SOS"),
            ),
            ElevatedButton.icon(
              onPressed: _callCareTaker,
              icon: const Icon(Icons.call),
              label: const Text("Call caretaker"),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GameScreen()),
              ),
              icon: const Icon(Icons.games),
              label: const Text("Play Games"),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MyFamilyScreen()),
              ),
              icon: const Icon(Icons.family_restroom),
              label: const Text("My Family"),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MemoriesScreen()),
              ),
              icon: const Icon(Icons.photo_album),
              label: const Text("Memories"),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TasksScreen()),
              ),
              icon: const Icon(Icons.notifications),
              label: const Text("Tasks"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                changeWallpaper();
              },
              icon: const Icon(Icons.image),
              label: const Text("Change Wallpaper"),
            ),
          ],
        ),
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
