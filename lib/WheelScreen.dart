import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TrasferimentiParametri.dart';

class Wheel extends StatefulWidget {
  const Wheel({Key? key}) : super(key: key);

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  List<String> listastudenti = <String>[];
  late int progressivoRuote;
  late int n_estratto;
  bool ruota_gira = false;
  String nomeRuota = "";
  StreamController<int> controller = StreamController<int>();
  bool animateFirst = true;
  final dur = Duration(
    seconds: 10,
  );

  void fineAnimazione() {
    print('fine');
    print('estratto: ' + n_estratto.toString());
    _mostraDialogo(context);
    ruota_gira = false;
  }

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

  Future<void> _mostraDialogo(BuildContext contex) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lo sfortunato estratto è:'),
          content: Text(listastudenti[n_estratto]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CHIUDI'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TrasferimentiParametri;
    progressivoRuote = args.indice;
    nomeRuota = args.nome;
    caricaStringa();
    if (listastudenti.length != 0 && animateFirst && ruota_gira == false) {
      controller.add(n_estratto = Fortune.randomInt(0, listastudenti.length));
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
              if (listastudenti.length != 0 && ruota_gira == false) {
                controller.add(
                    n_estratto = Fortune.randomInt(0, listastudenti.length));
              }
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: listastudenti.length == 0
                ? Container()
                : FortuneWheel(
                    rotationCount: 50,
                    duration: dur,
                    indicators: <FortuneIndicator>[
                      FortuneIndicator(
                          alignment: Alignment.topCenter,
                          child: TriangleIndicator(
                            color: Colors.redAccent,
                          ))
                    ],
                    onAnimationStart: () {
                      ruota_gira = true;
                    },
                    onFling: () {
                      setState(() {
                        if (listastudenti.length != 0 && ruota_gira == false) {
                          controller.add(n_estratto =
                              Fortune.randomInt(0, listastudenti.length));
                        }
                      });
                    },
                    onAnimationEnd: () => fineAnimazione(),
                    selected: controller.stream,
                    items: [
                      for (var it in listastudenti)
                        FortuneItem(child: Text(it)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
