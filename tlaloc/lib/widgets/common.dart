// import 'package:flutter/material.dart';

// class CommonSelectWidget {
//   final String title;
//   final String subtitle;
//   final ImageProvider image;

//   CommonSelectWidgetData({
//     required this.title,
//     required this.subtitle,
//     required this.image,
//   });
// }

//   final String paraje;
//   final String ejido;
//   final List<String> commonimages = [
//     "assets/images/1_venturero.png",
//     "assets/images/2_jardin.png",
//     "assets/images/3_cabana.png",
//     "assets/images/4_cruz.png",
//     "assets/images/5_canoas.png",
//     "assets/images/6_manantiales.png",
//     "assets/images/7_terreno.png",
//     "assets/images/8_chiqueros.png",
//   ];




// class CommonCard extends StatelessWidget {
  
//   const CommonCard({
//     required this.data,
//     Key? key,
//   }) : super(key: key);

//   final CommonSelectWidgetData data;

//   @override
  
//   Widget build(BuildContext context) {
//     return Container(
//           width: MediaQuery.of(context).size.width * 0.7,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(25.0),
//             color: Colors.white,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   radius: 50,
//                   backgroundImage: AssetImage(
//                     // TODO: ORDENAR LAS IMAGENES POR PARAJE
//                     commonimages[Random().nextInt(commonimages.length)],
//                   ),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   paraje,
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Colors.black,
//                     fontFamily: 'FredokaOne',
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'Ejido de $ejido',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black,
//                     fontFamily: 'poppins',
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//   }
// }
