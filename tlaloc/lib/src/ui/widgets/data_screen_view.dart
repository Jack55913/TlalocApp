import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/resources/statics/modify_registration.dart';
import 'package:tlaloc/src/ui/widgets/data_widget.dart';
import 'package:tlaloc/src/ui/widgets/real_data_widget.dart';



class MasterDetailScreen extends StatefulWidget {
  const MasterDetailScreen({super.key});

  @override
  State<MasterDetailScreen> createState() => _MasterDetailScreenState();
}

class _MasterDetailScreenState extends State<MasterDetailScreen> {
  Measurement? selectedMeasurement;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final isWideLayout = MediaQuery.of(context).size.width > 800;

    return Scaffold( 
      body:
          isWideLayout
              ? Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: MyDataWidget(
                      scrollController: _scrollController,
                      isWideLayout: true,
                      onMeasurementSelected: (m) {
                        debugPrint("📌 PC: seleccionado ${m.id}");
                        setState(() => selectedMeasurement = m);
                      },
                    ),
                  ),
                  VerticalDivider(width: 1, color: Colors.grey),
                  Expanded(
                    flex: 3,
                    child:
                        selectedMeasurement != null
                            ? ModifyRegistration(
                              measurement: selectedMeasurement!,
                              isEmbedded: true,
                            )
                            : Center(
                              child: Container(
                                color: Colors.black,
                                child: const Center(
                                  child: Text(
                                    'Selecciona una medición',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                  ),
                ],
              )
              : MyDataWidget(
                scrollController: _scrollController,
                isWideLayout: false,
                onMeasurementSelected: (m) {
                  debugPrint("📱 MÓVIL: navegando a detalle ${m.id}");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ModifyRegistration(measurement: m),
                    ),
                  );
                },
              ),
    );
  }
}
 

class MasterDetailRealScreen extends StatefulWidget {
  const MasterDetailRealScreen({super.key});

  @override
  State<MasterDetailRealScreen> createState() => _MasterDetailRealScreenState();
}

class _MasterDetailRealScreenState extends State<MasterDetailRealScreen> {
  Measurement? selectedMeasurement;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final isWideLayout = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      body: isWideLayout
          ? Row(
              children: [
                Expanded(
                  flex: 2,
                  child: MyRealDataWidget(
                    scrollController: _scrollController,
                    isWideLayout: true,
                    onMeasurementSelected: (m) {
                      debugPrint("📌 REALES: seleccionado ${m.id}");
                      setState(() => selectedMeasurement = m);
                    },
                  ),
                ),
                const VerticalDivider(width: 1, color: Colors.grey),
                Expanded(
                  flex: 3,
                  child: selectedMeasurement != null
                      ? ModifyRegistration(
                          measurement: selectedMeasurement!,
                          isEmbedded: true,
                        )
                      : Container(
                          color: Colors.black,
                          child: const Center(
                            child: Text(
                              'Selecciona una medición',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                ),
              ],
            )
          : MyRealDataWidget(
              scrollController: _scrollController,
              isWideLayout: false,
              onMeasurementSelected: (m) {
                debugPrint("📱 REALES móvil: detalle ${m.id}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ModifyRegistration(measurement: m),
                  ),
                );
              },
            ),
    );
  }
}
