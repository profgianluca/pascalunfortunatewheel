import 'package:flutter/material.dart';

class NewWheelScreen extends StatefulWidget {
  const NewWheelScreen({Key? key}) : super(key: key);

  @override
  State<NewWheelScreen> createState() => _NewWheelScreenState();
}

class _NewWheelScreenState extends State<NewWheelScreen> {
  late String nome;
  List<String> listastudenti = <String>[];
  void inserisci(BuildContext context) {
    setState(() {
      listastudenti.add(nome);
    });
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
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'inserisci il nome dell\'alunno'),
              onChanged: (text) {
                setState(() {
                  nome = text;
                });
              },
            ),
            ElevatedButton(
                onPressed: () => inserisci(context), child: Text('boh')),
            Expanded(
              child: ListView.builder(
                  itemCount: listastudenti.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text('${listastudenti[index]}'));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
