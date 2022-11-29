import 'package:flutter/material.dart';

class NewWheelScreen extends StatefulWidget {
  const NewWheelScreen({Key? key}) : super(key: key);

  @override
  State<NewWheelScreen> createState() => _NewWheelScreenState();
}

class _NewWheelScreenState extends State<NewWheelScreen> {
  String? nome;
  void inserisci(BuildContext context) {
    setState(() {});
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
                onPressed: () => inserisci(context), child: Text('boh'))
          ],
        ),
      ),
    );
  }
}
