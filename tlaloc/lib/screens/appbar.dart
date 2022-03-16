import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/screens/settings.dart';

class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            actions: <Widget>[
              const AutoSizeText('Tláloc App',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'FredokaOne',
                      fontSize: 24,
                      letterSpacing: 2,
                    )),
      IconButton(
      icon: const Icon(Icons.info),
      tooltip: 'Show Information',
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Registra datos pluviales'),
          content: const Text(
              'Colabora con Tláloc App, en la obtención de datos para analizar los cambios en los patrones de lluvia a causa del cambio climático.'),
          actions: <Widget>[
            
            TextButton(
              onPressed: () => Navigator.pop(context, 'Siguiente'),
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ),
      ),
      Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ConfigureScreen()),
          );
        },
        child: const CircleAvatar(
          maxRadius: 16,
          backgroundImage: ExactAssetImage("assets/images/img-1.png"),
        ),
      ),
      ),
    ],
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: AppColors.dark2,
                height: 100,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
    );
  }
}

