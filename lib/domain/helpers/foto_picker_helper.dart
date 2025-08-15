import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

Future<bool> _requestGalleryPermission() async {
  if (await Permission.photos.request().isGranted ||
      await Permission.storage.request().isGranted) {
    return true;
  }
  return false;
}

Future<bool> requestCameraPermission() async {
  if (await Permission.camera.request().isGranted) {
    return true;
  }
  return false;
}

Future<List<String>> pickMultipleImages() async {
  final hasPermission = await _requestGalleryPermission();
  if (!hasPermission) {
    print('Permiso denegado');
    return [];
  }

  final picker = ImagePicker();
  final List<XFile> images = await picker.pickMultiImage();

  if (images == null || images.isEmpty) return [];

  final Directory appDir = await getApplicationDocumentsDirectory();
  final savedPaths = <String>[];

  for (var image in images) {
    final fileName = p.basename(image.path);
    final savedImage = await File(image.path).copy('${appDir.path}/$fileName');
    savedPaths.add(savedImage.path);
  }

  return savedPaths;
}

Future<String?> pickImageFromCamera([BuildContext? context]) async {
  if (await requestCameraPermission() == false) {
    // Si tenemos contexto, mostrar SnackBar, si no, solo log
    if (context != null && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de cámara denegado')),
      );
    } else {
      print('Permiso de cámara denegado (sin contexto disponible)');
    }
    return null;
  }

  // Tomar foto
  final picker = ImagePicker();
  final XFile? photo = await picker.pickImage(source: ImageSource.camera);

  if (photo == null) return null; // Usuario canceló

  // Guardar la imagen en el directorio de la app
  try {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(photo.path);
    final savedImage = await File(photo.path).copy('${appDir.path}/$fileName');
    return savedImage.path;
  } catch (e) {
    print('Error saving camera photo: $e');
    return null;
  }
}
