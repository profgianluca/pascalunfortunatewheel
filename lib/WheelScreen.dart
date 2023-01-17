import 'dart:async';
import 'TrasferimentiParametri.dart';
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
  late int progressivoRuote;
  String nomeRuota = "";
  StreamController<int> controller = StreamController<int>();
  bool animateFirst = true;

  Future<void> caricaStringa() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      listastudenti = prefs.getStringList('lista$progressivoRuote') ?? [];
      print(listastudenti.length);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TrasferimentiParametri;
    progressivoRuote = args.indice;
    nomeRuota = args.nome;
    caricaStringa();
    if (listastudenti.length != 0 && animateFirst) {
      controller.add(Fortune.randomInt(0, listastudenti.length));
      animateFirst = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(nomeRuota),
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
              onFling: () {
                controller.add(Fortune.randomInt(0, listastudenti.length));
              },
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
