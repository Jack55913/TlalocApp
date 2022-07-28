import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/resources/page/graphs/graph1.dart';

class TableGrids extends StatelessWidget {
  const TableGrids({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> chartimages = [
      // "assets/images/img-3.png",
      "assets/images/img-2.png",
    ];
    List<String> charttitle = [
      // "De Tortas",
      "De Pasteles",
    ];
    final chartscrens = [
      const DispersionBar(),
      // const BarGraph(),
    ];
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.dark2,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text('Tablas',
                  style: TextStyle(
                    fontFamily: 'FredokaOne',
                    fontSize: 24,
                    letterSpacing: 2,
                    color: AppColors.green1,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (buildContext, index) => Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(chartimages[index]),
                      ),
                      title: Text(charttitle[index]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => chartscrens[index],
                          ),
                        );
                      },
                    ),
                  ),
                  itemCount: chartimages.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  scrollDirection: Axis.vertical,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
