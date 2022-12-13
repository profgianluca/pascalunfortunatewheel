import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

class Wheel extends StatefulWidget {
  const Wheel({Key? key}) : super(key: key);

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  List<String> listastudenti = <String>[];
  int progressivoRuote = 0;
  StreamController<int> controller = StreamController<int>();

  Future<void> caricaStringa() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      listastudenti = prefs.getStringList('lista$progressivoRuote') ?? [];
      print(listastudenti.length);
    });
  }

  Future<void> caricaProgressivoRuote() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      progressivoRuote = prefs.getInt('progressivoRuote') ?? 0;
      progressivoRuote = progressivoRuote - 1;
    });
  }

  @override
  void initState() {
    caricaProgressivoRuote();
    caricaStringa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ruota Numero $progressivoRuote'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              controller.add(Fortune.randomInt(0, listastudenti.length));
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FortuneWheel(
              selected: controller.stream,
              items: [
                for (var it in listastudenti) FortuneItem(child: Text(it)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
