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
      if (nome != "") {
        listastudenti.add(nome);
        salvaStringa();
        nome = "";
      }
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
    if (nomeruota == "" && args.nome != "") {
      nomeruota = args.nome;
      controllerNomeRuota.text = nomeruota;
    }
    caricaStringa();
    return Scaffold(
      appBar: AppBar(
        title: Text('Inizializza Ruota ' + nomeruota),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 18),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'inserisci il nome della ruota'),
                      controller: controllerNomeRuota,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 50),
                      ),
                      onPressed: () {
                        setState(() {
                          nomeruota = controllerNomeRuota.text;
                          listaRuote[progressivoRuote] = nomeruota;
                          salvaListaRuote();
                          switch (nomeruota) {
                            case '#pascal1a#':
                              listastudenti = [
                                'Alessandro A.',
                                'Mateos',
                                'Laurent',
                                'Matteo',
                                'Paolo',
                                'Alessandro C.',
                                'Francesco',
                                'Michele',
                                'Samuele',
                                'Alessandro D.',
                                'Simone',
                                'Elisa',
                                'Marta',
                                'Nausicaa',
                                'Giovanni',
                                'Andrea',
                                'Carlo',
                                'Tommaso P.',
                                'Alessandro P.',
                                'Alessandro R.',
                                'Maria',
                                'Marco',
                                'Edoardo',
                                'Tommaso Z.'
                              ];
                              break;
                            case '#pascal2a#':
                              listastudenti = [
                                'Leonardo',
                                'Diana',
                                'Sofia B.',
                                'Gabriele',
                                'Caterina',
                                'Emma',
                                'Giulia',
                                'Luca',
                                'Alessandra',
                                'Marta',
                                'Maddalena',
                                'Giulio',
                                'Cecilia',
                                'Anna',
                                'Giovanni',
                                'Sofia T.',
                                'Sofia U.'
                              ];
                              break;
                            case '#pascal3a#':
                              listastudenti = [
                                'Matteo B.',
                                'Sofia',
                                'Francesca',
                                'Linda',
                                'Chiara',
                                'Margherita B.',
                                'Carolina',
                                'Pietro C.',
                                'Daniele',
                                'Stefano',
                                'Margherita E.',
                                'Marco',
                                'Agnese',
                                'Matteo I.',
                                'Francesco',
                                'Madhuri',
                                'Ana',
                                'Pietro P.',
                                'Anna',
                                'Tommaso',
                                'Alessia',
                                'Andres',
                                'Gaia',
                                'Simone',
                                'elisa',
                                'Giosuè'
                              ];
                              break;
                            case '#pascal4a#':
                              listastudenti = [
                                'Sofia',
                                'Tommaso',
                                'Giorgio',
                                'Camilla',
                                'Vincenzo',
                                'Giacomo C.',
                                'Massimo',
                                'Francesco :)',
                                'Elisa',
                                'Riccardo L.',
                                'Samuele',
                                'Rachele',
                                'Filippo',
                                'Riccardo P. :)',
                                'Edoardo',
                                'Giacomo P.',
                                'Carolina',
                                'Ludovica',
                                'Elena',
                                'Letizia',
                                'Adam'
                              ];
                              break;
                            case '#pascal5a#':
                              listastudenti = [
                                'Luca',
                                'Chiara',
                                'Ludovico',
                                'Emanuele',
                                'Agnese',
                                'Ludovica',
                                'Filippo',
                                'Alberto',
                                'Elisabetta',
                                'Valerii',
                                'Juan',
                                'Pietro',
                                'Sofia',
                                'Federico',
                                'Francesco',
                                'Beatrice',
                                'Emma',
                                'Mattia',
                                'Alex'
                              ];
                              break;
                          }
                          salvaStringa();
                        });
                      },
                      child: Text('Salva')),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
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
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 50),
                      ),
                      onPressed: () {
                        inserisci(context);
                        controllerNome.clear();
                      },
                      child: Text('Inserisci')),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: listastudenti.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //color: Colors.indigo,
                            border: Border(
                              top: BorderSide(color: Colors.indigo, width: 5.0),
                              left:
                                  BorderSide(color: Colors.indigo, width: 5.0),
                              right:
                                  BorderSide(color: Colors.indigo, width: 5.0),
                              bottom:
                                  BorderSide(color: Colors.indigo, width: 5.0),
                            )),
                        child: ListTile(
                            title: Text(
                              '${listastudenti[index]}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            trailing: IconButton(
                              onPressed: () => cancella(index),
                              icon: Icon(Icons.delete),
                            )),
                      );
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
