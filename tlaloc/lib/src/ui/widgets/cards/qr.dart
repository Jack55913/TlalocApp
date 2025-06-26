import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:tlaloc/src/models/app_state.dart';
import 'package:tlaloc/src/models/constants.dart';
import 'package:tlaloc/src/models/kernel.dart';

class QrSelectWidget extends StatelessWidget {
  const QrSelectWidget({super.key});

  void _goHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (context) => const HomePage()),
      (route) => false,
    );
  }

  Future<void> _handleQrResult(BuildContext context, String? qrResult) async {
    if (qrResult == null) {
      await _showErrorDialog(
        context,
        title: 'Escaneo fallido',
        content: 'Intenta de nuevo o selecciona tu paraje manualmente',
      );
      return;
    }

    final paraje = _parseQrResult(qrResult);
    if (!parajes.containsKey(paraje)) {
      await _showErrorDialog(
        context,
        title: 'Código inválido',
        content:
            paraje.isEmpty
                ? null
                : 'Tlaloc App no está disponible en el paraje "$paraje"',
      );
      return;
    }

    _goHome(context);
    Provider.of<AppState>(context, listen: false).changeParaje(paraje);
  }

  String _parseQrResult(String qrResult) {
    if (!qrResult.contains('tlaloc.web.app')) return '';
    return qrResult.split('/').last.replaceAll(RegExp(r'_|%20'), ' ').trim();
  }

  Future<void> _showErrorDialog(
    BuildContext context, {
    required String title,
    String? content,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => AlertDialog(
            icon: const Icon(Icons.error_outline_rounded),
            iconColor: Theme.of(context).colorScheme.error,
            title: Text(title),
            content: content != null ? Text(content) : null,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('ENTENDIDO'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isWide = screenWidth >= 600;

        // Igual que en las tarjetas comunes
        final cardWidth =
            isWide
                ? (screenWidth - 16 /* spacing */ - 32 /* padding */ ) / 2
                : screenWidth - 32;

        return ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400, // Máximo recomendado para móviles
            minWidth: 280, // Mínimo para buena legibilidad
          ),
          child: Material(
            color: AppColors.dark2,
            borderRadius: BorderRadius.circular(
              12,
            ), // Reducido de 28 a 12 según MD
            clipBehavior: Clip.antiAlias,
            elevation: 1,
            child: InkWell(
              onTap: () async {
                final qrResult = await showDialog<String>(
                  context: context,
                  builder: (context) => _QrScannerDialog(context),
                );
                await _handleQrResult(context, qrResult);
              },
              splashColor: colors.primary.withOpacity(0.1),
              highlightColor: colors.primary.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(24), // Padding interno estándar
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 48, // Reducido de 64 para mejor proporción
                      color: colors.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'ESCANEAR QR',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.onSurface,
                        fontFamily: 'FredokaOne',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Detecta tu pluviómetro automáticamente',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _QrScannerDialog extends StatelessWidget {
  final BuildContext parentContext;

  const _QrScannerDialog(this.parentContext);

  @override
  Widget build(BuildContext context) {
    final size = min(
      MediaQuery.of(parentContext).size.width,
      MediaQuery.of(parentContext).size.height,
    );

    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            title: const Text('Escanear código'),
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size, maxHeight: size),
            child: MobileScanner(
              controller: MobileScannerController(
                detectionSpeed: DetectionSpeed.normal,
                facing: CameraFacing.back,
                torchEnabled: false,
              ),
              onDetect: (barcode) {
                if (barcode.barcodes.isNotEmpty) {
                  Navigator.pop(context, barcode.barcodes.first.rawValue ?? '');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
