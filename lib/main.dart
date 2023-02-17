import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NewWheelScreen.dart';
import 'TrasferimentiParametri.dart';
import 'WheelScreen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: Colors.indigo,

      colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.indigo),
      // Define the default font family.
      fontFamily: 'Bold',

      // Define the default `TextTheme`. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: const TextTheme(
        //headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        //headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    ),
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
      //backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        title: Text('Pascal Unfortunate Wheel'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('images/pascal.png'),
                height: 100,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: listaRuote.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.pushNamed(context, '/NewWheelScreen',
                                    arguments: TrasferimentiParametri(
                                        index, listaRuote[index]))
                                .then((_) {
                              setState(() {
                                caricaListaRuote();
                              });
                            });
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                //color: Colors.indigo,
                                border: Border(
                                  top: BorderSide(
                                      color: Colors.indigo, width: 5.0),
                                  left: BorderSide(
                                      color: Colors.indigo, width: 5.0),
                                  right: BorderSide(
                                      color: Colors.indigo, width: 5.0),
                                  bottom: BorderSide(
                                      color: Colors.indigo, width: 5.0),
                                )),
                            child: ListTile(
                              title: Center(
                                  child: Text(
                                listaRuote[index] == ''
                                    ? 'Nuova Ruota'
                                    : listaRuote[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              )),

                              //trailing: Icon(Icons.more_vert),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
