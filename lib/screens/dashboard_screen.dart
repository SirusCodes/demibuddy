import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

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
              onPressed: () {},
              icon: const Icon(Icons.games),
              label: const Text("Play Games"),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.family_restroom),
              label: const Text("My Family"),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.photo_album),
              label: const Text("Memories"),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.notifications),
              label: const Text("Notices"),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.people),
              label: const Text("Community"),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(primary: Colors.red.shade400),
              icon: const Icon(Icons.call),
              label: const Text("SOS"),
            ),
          ],
        ),
      ),
    );
  }
}
