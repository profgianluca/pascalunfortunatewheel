import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewWheelScreen extends StatefulWidget {
  const NewWheelScreen({Key? key}) : super(key: key);

  @override
  State<NewWheelScreen> createState() => _NewWheelScreenState();
}

class _NewWheelScreenState extends State<NewWheelScreen> {
  TextEditingController controllerNome = TextEditingController();
  late String nome;
  List<String> listastudenti = <String>[];
  int progressivoRuote = 0;

  Future<void> salvaStringa() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('lista$progressivoRuote', listastudenti);
  }

  Future<void> salvaProgressivoRuote() async {
    final prefs = await SharedPreferences.getInstance();
    progressivoRuote++;
    await prefs.setInt('progressivoRuote', progressivoRuote);
  }

  Future<void> caricaStringa() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      listastudenti = prefs.getStringList('lista0') ?? [];
    });
  }

  Future<void> caricaProgressivoRuote() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      progressivoRuote = prefs.getInt('progressivoRuote') ?? 0;
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
    caricaStringa();
    caricaProgressivoRuote();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crea una nuova Ruota'),
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
                  salvaProgressivoRuote();
                  Navigator.pushNamed(context, '/WheelScreen');
                },
                child: Text('Vai alla Ruota'))
          ],
        ),
      ),
    );
  }
}
