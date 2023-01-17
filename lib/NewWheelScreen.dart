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
  TextEditingController controllerNomeRuota = TextEditingController();

  String nome = "";
  String nomeruota = "";
  List<String> listastudenti = <String>[];
  late int progressivoRuote;
  List<String> listaRuote = <String>[];

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

  Future<void> caricaListaRuote() async {
    final prefs = await SharedPreferences.getInstance();
    listaRuote = prefs.getStringList('listaruote') ??
        ["", "", "", "", "", "", "", "", "", ""];
  }

  Future<void> salvaListaRuote() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('listaruote', listaRuote);
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
    caricaListaRuote();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TrasferimentiParametri;
    //print(args.indice);
    progressivoRuote = args.indice;
    if (nomeruota == "") {
      nomeruota = args.nome;
    }
    caricaStringa();
    return Scaffold(
      appBar: AppBar(
        title: Text('Inizializza Ruota ' + nomeruota),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'inserisci il nome della ruota'),
                controller: controllerNomeRuota,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    nomeruota = controllerNomeRuota.text;
                    listaRuote[progressivoRuote] = nomeruota;
                    salvaListaRuote();
                  });
                },
                child: Text('Salva il nome')),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (listastudenti.length < 2) {
                      const snackBar = SnackBar(
                          content: Text(
                              "Inserisci almeno due elementi per eseguire la ruota"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.pushNamed(context, '/WheelScreen',
                          arguments:
                              TrasferimentiParametri(args.indice, nomeruota));
                    }
                  },
                  child: Text('Vai alla Ruota')),
            ),
          ],
        ),
      ),
    );
  }
}
