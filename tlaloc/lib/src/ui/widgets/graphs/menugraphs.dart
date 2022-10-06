import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';

class GraphMenuWidget extends StatelessWidget {
  const GraphMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text('Gráficas',
            style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 24,
              letterSpacing: 2,
              color: AppColors.blue1,
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (buildContext, index) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: grpahIconColor[index],
                  child: graphIcons[index],
                ),
                title: Text(graphtitle[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => graphscrens[index],
                    ),
                  );
                },
              ),
            ),
            itemCount: graphIcons.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(5),
            scrollDirection: Axis.vertical,
          ),
        ),
      ],
    );
  }
}