import 'package:flutter/material.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/ui/widgets/cards/paralax_list.dart';

class CommonSelectWidget extends StatefulWidget {
  const CommonSelectWidget({super.key});

  @override
  State<CommonSelectWidget> createState() => _CommonSelectWidgetState();
}

class _CommonSelectWidgetState extends State<CommonSelectWidget> {
  final TextEditingController _searchController = TextEditingController();
  List<String> filteredParajes = parajecolection;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      filteredParajes =
          parajecolection
              .where((paraje) => paraje.toLowerCase().contains(query))
              .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar paraje...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            _buildParallaxGrid(context, isWide),
          ],
        );
      },
    );
  }

  Widget _buildParallaxGrid(BuildContext context, bool isWide) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isWide = screenWidth >= 600;

        final itemWidth =
            isWide
                ? (screenWidth - 16 /* spacing */ - 32 /* padding */ ) / 2
                : screenWidth - 32;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(filteredParajes.length, (i) {
              final paraje = filteredParajes[i];
              final index = parajecolection.indexOf(paraje);

              return ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400, // Máximo recomendado para móviles
                  minWidth: 280, // Mínimo para buena legibilidad
                ),
                child: LocationListItem(
                  paraje: parajecolection[index],
                  ejido: ejidocolection[index],
                  commonimage: commonimages[index],
                ),
                // ),
              );
            }),
          ),
        );
      },
    );
  }
}
