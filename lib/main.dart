import 'package:flutter/material.dart';
import 'NewWheelScreen.dart';
import 'WheelScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'TrasferimentiParametri.dart';

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
  List<String> listaRuote = [];

  void newWheel(BuildContext context) {
    setState(() {
      Navigator.pushNamed(context, '/NewWheelScreen');
    });
  }

  Future<void> caricaListaRuote() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      listaRuote = prefs.getStringList('listaruote') ??
          ["", "", "", "", "", "", "", "", "", ""];
    });
  }

  @override
  void initState() {
    caricaListaRuote();
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
              child: ListView.builder(
                  itemCount: listaRuote.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushNamed(context, '/NewWheelScreen',
                              arguments: TrasferimentiParametri(
                                  index, listaRuote[index]));
                        });
                      },
                      child: ListTile(
                        title: Text(listaRuote[index]),
                        trailing: Icon(Icons.more_vert),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
