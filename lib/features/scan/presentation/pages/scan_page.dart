import 'package:flutter/material.dart';
import '../application/image_picker_service.dart';
import '../application/gemini_scanner_service.dart';
import '../../../recipes/presentation/pages/recipes_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({super.key});

  @override
  ConsumerState<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  final ImagePickerService _pickerService = ImagePickerService();
  bool _isProcessing = false;

  void _onImageSourceSelected() {
    _pickerService.showImageSourceSheet(context, (file) async {
      setState(() => _isProcessing = true);
      
      // Simulación de procesamiento de IA
      await Future.delayed(const Duration(seconds: 3));
      
      if (mounted) {
        // Salto automático a Sugerencias de Platos
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RecipesPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Despensa'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isProcessing) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 24),
                const Text('Nuestra IA está analizando tu despensa...'),
              ] else ...[
                const Icon(Icons.qr_code_scanner_rounded, size: 100, color: Colors.grey),
                const SizedBox(height: 32),
                const Text(
                  'Toma una foto de tu refrigerador o despensa',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Nuestra IA detectará los ingredientes y cantidades automáticamente para sugerirte recetas.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 48),
                ElevatedButton.icon(
                  onPressed: _onImageSourceSelected,
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Comenzar Escaneo'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
