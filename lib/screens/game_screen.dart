import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:demicare/extension/int_ext.dart';
import 'package:demicare/utils/init_get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:whiteboard/whiteboard.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late String _time;
  late Set<String> _words;
  late final _shownWords = <String>{};

  @override
  void initState() {
    super.initState();
    final _rand = Random();

    _time =
        "${(_rand.nextInt(11) + 1).padLeadingZero}:${((_rand.nextInt(11) + 1) * 5).padLeadingZero}";

    _words = {
      "Banana",
      "Sunrise",
      "Chair",
      "Leader",
      "Season",
      "Table",
      "Village",
      "Kitchen",
      "Baby",
      "River",
      "Nation",
      "Finger",
      "Captain",
      "Garden",
      "Picture"
    };

    while (_shownWords.length != 3) {
      _shownWords.add(_words.elementAt(_rand.nextInt(9)));
    }

    SchedulerBinding.instance!.addPostFrameCallback((_) => _show3Word());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              child: WhiteBoard(
                strokeColor: Colors.black,
              ),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
            Positioned(
              top: 50,
              left: 50,
              right: 50,
              child: Text(
                "Make a clock with $_time time set",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final selected = await _showTextSelections();
          int _count = 0;
          for (var item in selected) {
            if (_shownWords.contains(item)) _count++;
          }
          final _score = _count == 0 ? -1 : _count;
          getIt.get<Database>().createDocument(
            collectionId: "cognitiveGame",
            documentId: "unique()",
            data: {"date": DateTime.now().toIso8601String(), "score": _score},
          );
          Navigator.pop(context);
        },
        icon: const Icon(Icons.check),
        label: const Text("Done"),
      ),
    );
  }

  _show3Word() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text(
                    _shownWords.elementAt(index),
                    textAlign: TextAlign.center,
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
                itemCount: 3,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Read"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showTextSelections() {
    return showDialog<List<String>>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        child: _CheckSelectedWords(words: _words.toList()),
      ),
    );
  }
}

class _CheckSelectedWords extends StatefulWidget {
  const _CheckSelectedWords({Key? key, required this.words}) : super(key: key);

  final List<String> words;

  @override
  State<_CheckSelectedWords> createState() => __CheckStateSelectedWords();
}

class __CheckStateSelectedWords extends State<_CheckSelectedWords> {
  final _checked = List.generate(9, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                value: _checked[index],
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() => _checked[index] = value!);
                },
                title: Text(widget.words[index]),
              );
            },
            itemCount: 9,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final _selected = <String>[];
              for (var i = 0; i < _checked.length; i++) {
                if (_checked[i]) _selected.add(widget.words[i]);
              }
              Navigator.pop(context, _selected);
            },
            child: const Text("Verify"),
          ),
        ],
      ),
    );
  }
}
