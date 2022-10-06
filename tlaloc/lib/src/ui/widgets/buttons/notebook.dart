import 'package:flutter/material.dart';
import 'package:tlaloc/src/ui/widgets/objects/table.dart';

class TableButton extends StatelessWidget {
  const TableButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Go to InfoProyectPage
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TableTlaloc()));
      },
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          '📝 Mediciones Generales',
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontFamily: 'FredokaOne',
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
