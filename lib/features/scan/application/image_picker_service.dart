import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage(BuildContext context, ImageSource source) async {
    // Check and request permissions with friendly messages
    bool hasPermission = await _requestPermission(context, source);
    if (!hasPermission) return null;

    try {
      return await _picker.pickImage(source: source);
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  Future<bool> _requestPermission(BuildContext context, ImageSource source) async {
    Permission permission = source == ImageSource.camera 
        ? Permission.camera 
        : Permission.photos;

    PermissionStatus status = await permission.status;

    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        _showPermissionDialog(
          context, 
          'Permisos necesarios', 
          'Por favor, habilita el acceso desde la configuración para poder continuar.'
        );
      }
      return false;
    }

    if (!status.isGranted) {
      // Friendly explanation before requesting
      if (context.mounted) {
        bool? proceed = await _showPermissionDialog(
          context,
          source == ImageSource.camera ? 'Acceso a la Cámara' : 'Acceso a la Galería',
          source == ImageSource.camera 
            ? 'Necesitamos acceso a tu cámara para identificar tus ingredientes automáticamente.'
            : 'Necesitamos acceso a tu galería para analizar las fotos de tus ingredientes.'
        );
        if (proceed != true) return false;
      }
      
      status = await permission.request();
    }

    return status.isGranted;
  }

  Future<bool?> _showPermissionDialog(BuildContext context, String title, String message) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
  }

  void showImageSourceSheet(BuildContext context, Function(XFile) onImagePicked) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Seleccionar Imagen',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Sacar una foto'),
                onTap: () async {
                  Navigator.pop(context);
                  final file = await pickImage(context, ImageSource.camera);
                  if (file != null) onImagePicked(file);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Elegir de la galería'),
                onTap: () async {
                  Navigator.pop(context);
                  final file = await pickImage(context, ImageSource.gallery);
                  if (file != null) onImagePicked(file);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
