import 'package:flutter/material.dart';
import 'NewWheelScreen.dart';
import 'WheelScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: 'Pascal Unfortunate Wheel',
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
      '/NewWheelScreen': (context) => const NewWheelScreen(),
      '/WheelScreen': (context) => const Wheel(),
    },
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> listastudenti = <String>[];
  int progressivoRuote = 0;

  void newWheel(BuildContext context) {
    setState(() {
      Navigator.pushNamed(context, '/NewWheelScreen');
    });
  }

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
        title: Text('Pascal Unfortunate Wheel'),
      ),
      body: Center(
        child: Column(
          children: [
            Icon(
              Icons.access_time_filled,
              size: 20,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: () => newWheel(context),
                        child: Text('Crea una nuova Ruota')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
