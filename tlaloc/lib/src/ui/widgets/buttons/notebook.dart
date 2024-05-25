import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/objects/table.dart';

class TableButton extends StatelessWidget {
  const TableButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TableTlaloc()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              AppColors.green1,
              AppColors.blue3,
            ],
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Mediciones\n Generales 📝',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontFamily: 'FredokaOne',
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Ver más',
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
      ),
    );
  }
}
