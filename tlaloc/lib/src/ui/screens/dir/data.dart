import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/excel.dart';
import 'package:tlaloc/src/ui/widgets/appbar/infobutton2.dart';
import 'package:tlaloc/src/ui/widgets/data_screen_view.dart';
import 'package:tlaloc/src/ui/widgets/data_widget.dart';
import 'package:tlaloc/src/ui/widgets/info/info_page.dart';
import 'package:tlaloc/src/ui/widgets/real_data_widget.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<ScrollController> _scrollControllers = [
    ScrollController(),
    ScrollController(),
  ];
  bool isFabVisible = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Escuchar cambios de pestaña
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    // Hacer scroll al inicio cuando cambia la pestaña
    _scrollToTop(_tabController.index);
  }

  void _scrollToTop(int index) {
    final controller = _scrollControllers[index];
    if (controller.hasClients) {
      controller.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    bool isWideLayout = MediaQuery.of(context).size.width > 800;
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              title: Row(
                children: [
                  Image.asset('assets/images/tlaloc_logo.png', height: 32),
                  const SizedBox(width: 8),
                  const Text(
                    'Bitácora',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      // color: AppColors.dark1,
                      fontFamily: 'FredokaOne',
                      fontSize: 24,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              floating: true,
              pinned: true,
              snap: false,
              expandedHeight: 150.0,
              // flexibleSpace: FlexibleSpaceBar(
              //   background: Image.asset(
              //     'assets/images/img-7.jpg',
              //     fit: BoxFit.fitWidth,
              //   ),
              // ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.file_download),
                  onPressed: () async {
                    try {
                      await appState.exportMeasurements(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Exportación completada',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al exportar: $e')),
                      );
                    }
                  },
                ),
                InfoButton2(),
                FluidDialogWidget(),
              ],
              bottom: TabBar(
                controller: _tabController,
                onTap: (index) => _scrollToTop(index),
                labelColor: AppColors.blue1,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors.blue1,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                tabs: const <Widget>[
                  Tab(text: 'Acumulados', icon: Icon(Icons.cloud_outlined)),
                  Tab(text: 'Reales', icon: Icon(Icons.cloud_done_outlined)),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController, // Asigna el mismo controlador
          children: <Widget>[
            // Pasa el ScrollController a cada widget hijo
            isWideLayout
                ? MasterDetailScreen()
                : MyDataWidget(scrollController: _scrollControllers[0]),
            isWideLayout
                ? MasterDetailRealScreen()
                : MyRealDataWidget(scrollController: _scrollControllers[0]),
          ],
        ),
      ),
    );
  }
}
