// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lenguas/models/app_state.dart';
// import 'package:lenguas/widgets/status_bar_colors.dart';
// import 'package:provider/provider.dart';

// typedef LanguageSelectFunction = void Function(String);

// class LanguageSelectPage extends StatelessWidget {
//   /// Title of the page, if null it will be ommitted
//   final String title;

//   /// If not null, this will be run after changing the language
//   final LanguageSelectFunction onLanguageSelect;

//   LanguageSelectPage({this.title, this.onLanguageSelect});

//   @override
//   Widget build(BuildContext context) {
//     return DarkStatusBar(
//       child: Theme(
//         data: new_light_theme,
//         child: Container(
//           color: AppColors.azulMorado,
//           alignment: Alignment.topCenter,
//           child: SafeArea(
//             child: Column(
//               children: [
//                 SizedBox(height: 16),
//                 if (title != null)
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                     child: Text(
//                       title,
//                       style: GoogleFonts.fredokaOne(
//                         fontSize: 32,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 Text(
//                   '¿Qué idioma quieres aprender?',
//                   style: Theme.of(context).textTheme.headline2.copyWith(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                 ),
//                 Expanded(
//                   child: Consumer<AppState>(
//                     builder: (context, state, child) {
//                       return ListView(
//                         padding: EdgeInsets.all(8),
//                         shrinkWrap: true,
//                         children: [
//                           for (var language in state.languages)
//                             Card(
//                               // color: Colors.white,
//                               child: ListTile(
//                                 title: Text('${language.name}'),
//                                 subtitle:
//                                     Text('${language.speakers} hablantes'),
//                                 leading: CircleAvatar(
//                                   child: Text(
//                                     '${language.name[0]}',
//                                     style: GoogleFonts.fredokaOne(),
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   /// Save onboarding finished and language
//                                   analytics.setUserProperty(
//                                       name: 'language', value: language.name);
//                                   state.changeLanguage(language.name);
//                                   state.setDefaultLanguage(state.language);
//                                   if (onLanguageSelect != null) {
//                                     onLanguageSelect(language.name);
//                                   }
//                                 },
//                               ),
//                             ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tlaloc/models/constants.dart';
import 'package:tlaloc/screens/navigation_bar.dart';

class CommonSelectPage extends StatelessWidget {
  const CommonSelectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.purple2,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Selecciona un Ejido',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FredokaOne',
                      color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  '¿A qué ejido perteneces?',
                  style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      color: Colors.white),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    CommonSelectWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CommonSelectWidget extends StatelessWidget {
  const CommonSelectWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(builder: (BuildContext context) {
            return const BottomNavBar();
          }), (Route<dynamic> route) => false);
        },
        child: Container(
          color: Colors.white,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(25),
          // ),
          child: Column(
            children: [
              // Insert circle image here:
              CircleAvatar(
                backgroundColor: AppColors.orange1,
                radius: 50,
                child: Icon(
                  FontAwesomeIcons.a,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              Text(
                    'Tequexquinahuac',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'FredokaOne',
                    ),
                  ),
                  Text(
                    '1200 Ha',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'FredokaOne',
                    ),
                  ),
            ],
          ),
        )
      ),
    );
  }
}
