import 'dart:io';

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

Future<List<String>> pickMultipleImages() async {
  final hasPermission = await _requestGalleryPermission();
  if (!hasPermission) {
    print('Permiso denegado');
    return [];
  }

  final picker = ImagePicker();
  final List<XFile>? images = await picker.pickMultiImage();

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


