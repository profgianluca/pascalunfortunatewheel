import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key? key}) : super(key: key);

  final Uri _url = Uri.parse('https://forms.gle/r6c2nTweAX1FcL5b9');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina delle Informazioni'),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 10.0),
              child: Text(
                'PASCAL UNFORTUNATE WHEEL',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Versione 1.0.0 (anno 2023)',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Ideato e realizzato da Francesco Costa, Riccando Perron Cabus e Prof. Gianluca Cisana',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Liceo Scientifico B. Pascal - Busto Arsizio',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _launchUrl,
                child: Text('Commenta per aiutarci a migliorare l\'app!'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
