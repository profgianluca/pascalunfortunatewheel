import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TrasferimentiParametri.dart';

class NewWheelScreen extends StatefulWidget {
  const NewWheelScreen({Key? key}) : super(key: key);

  @override
  State<NewWheelScreen> createState() => _NewWheelScreenState();
}

class _NewWheelScreenState extends State<NewWheelScreen> {
  TextEditingController controllerNome = TextEditingController();
  late String nome;
  List<String> listastudenti = <String>[];
  late int progressivoRuote;

  Future<void> salvaStringa() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('lista$progressivoRuote', listastudenti);
  }

  Future<void> caricaStringa() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      listastudenti = prefs.getStringList('lista$progressivoRuote') ?? [];
    });
  }

  void inserisci(BuildContext context) {
    setState(() {
      listastudenti.add(nome);
      salvaStringa();
    });
  }

  void cancella(int index) {
    setState(() {
      listastudenti.removeAt(index);
      salvaStringa();
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
    //print(args.indice);
    progressivoRuote = args.indice;
    caricaStringa();
    return Scaffold(
      appBar: AppBar(
        title: Text('Inizializza Ruota ${args.nome}'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'inserisci il nome dell\'alunno'),
                controller: controllerNome,
                onChanged: (text) {
                  setState(() {
                    nome = text;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    inserisci(context);
                    controllerNome.clear();
                  },
                  child: Text('INSERISCI')),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: listastudenti.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          title: Text('${listastudenti[index]}'),
                          trailing: IconButton(
                            onPressed: () => cancella(index),
                            icon: Icon(Icons.delete),
                          ));
                    }),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/WheelScreen',
                      arguments:
                          TrasferimentiParametri(args.indice, args.nome));
                },
                child: Text('Vai alla Ruota'))
          ],
        ),
      ),
    );
  }
}
