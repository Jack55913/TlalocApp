// ignore_for_file: unnecessary_string_escapes

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tlaloc/src/models/constants.dart';
// import '../shared/markdown_demo_widget.dart';

// ignore_for_file: public_member_api_docs

const String _markdownData = """
## Creadores ✒️

* **CEO: Dra. Teresa M. Gonzalez Martinez** - *Posgrado en Ciencias Forestales - COLPOS* - [Correo electrónico](teresa.gonzalez@colpos.mx)

<img width="300" height="300" src="https://play-lh.googleusercontent.com/EvAYTmW85yKTSDjbzUX0wjp41vd2FJPk9HfAY3Jv8LZJbgOcA6eSD1UNKtcDOgUfgVy0">
</p>

* **CTO: Emilio Álvarez Herrera** - *Irrigación - UACh* - [emilio-ah.web.app](https://emilio-ah.web.app)

* **COO: Pedro Luis Díaz Lira** - *Irrigación - UACh*  

## Ejidos 🛠️

* **Santa María Nativitas**
* **San Pablo Ixayoc**
* **San Dieguito Xochimalca**
* **Tequexquinahuac**
* **Santa Catarina del Monte**
* **San Miguel Tlaixpan**

## Colaboradores 🍺

* **CCO: Diana Cerón Flores** - *Hidrobiología - UAM*

* **Gabriel Rodríguez** - *Programador* - [gabrc52](https://github.com/gabrc52)

* **Andrea González Durán** - *Diseñadora* - [Liebre Con Fiebre](https://www.instagram.com/liebre.confiebre/)
""";

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.dark2,
        title: const Text('Créditos ©️'),
      ),
      body: const SafeArea(
        child: Markdown(
          selectable: true,
          data: _markdownData,
        ),
      ),
    );
  }
}
