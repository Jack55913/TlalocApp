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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Mediciones\n Generales 📝',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'FredokaOne',
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                SelectableText(
                  'Consulta',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'FredokaOne',
                    fontWeight: FontWeight.w100,
                    fontSize: 14,
                  ),
                ),
                Icon(
                  Icons.navigate_next,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
