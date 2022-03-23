// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tlaloc/page/add.dart';

class ModifyRegistration extends StatelessWidget {
  const ModifyRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: AutoSizeText('Modificar',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'FredokaOne',
                  fontSize: 24,
                  letterSpacing: 2,
                )),
            actions: const <Widget>[
              EditButton(),
              ShareResults(),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text('Registro de Lluvia:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'FredokaOne',
                    )),
                SizedBox(height: 15),
                _buildDataModify('Precipitación', '10 ml'),
                SizedBox(height: 15),
                _buildDataModify('Domingo 23 de Enero', '12:00 Hrs'),
                SizedBox(height: 5),
                Divider(
                  height: 20,
                  thickness: 1,
                  color: Colors.white38,
                ),
                SizedBox(height: 15),
                Text('Datos generales',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'FredokaOne',
                    )),
                SizedBox(height: 15),
                _buildDataModify('Autor:', 'Emilio Álvarez Herrera'),
                SizedBox(height: 15),
                _buildDataModify('Ejido:', 'Tequexquinahuac'),
                SizedBox(height: 15),
                _buildDataModify('Autor:', 'Emilio Álvarez Herrera'),
                SizedBox(height: 15),
                _buildDataModify('Ejido:', 'Tequexquinahuac'),
                SizedBox(height: 5),
                Divider(
                  height: 20,
                  thickness: 1,
                  color: Colors.white38,
                ),
                SizedBox(height: 15),
                Text(
                  'Fotografía',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'FredokaOne',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                      'https://contrapapel.mx/wp-content/uploads/2021/02/IMG_4587.jpg',
                      fit: BoxFit.cover,
                    ),
                ),
                
              ],
            ),
          )),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      tooltip: 'Editar registro de lluvia',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddScreen()),
        );
      },
    );
  }
}

class ShareResults extends StatelessWidget {
  const ShareResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.share),
      tooltip: 'Compartir registro de lluvia',
      onPressed: () {
        Share.share(
            ''' ¡Mira! *hoy llovió 10 ml*. Ayúdame a medir, descargándo la app en tlaloc.web.app '''
//                 '''*${entry.originalWord} (en ${state.language})*
// ${entry.translatedWord}
// (Fuente: ${source.author} de ${source.region})

// Compartido desde Miyotl. Descárgalo en miyotl.org'''
            );
      },
    );
  }
}

Widget _buildDataModify(String textTitle, String textsubtitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(textTitle,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'poppins',
          )),
      Text(textsubtitle,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'poppins',
          )),
    ],
  );
}
