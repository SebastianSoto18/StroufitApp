import 'dart:io';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

/// Helper para remover fondos usando remove.bg (API externa)
class RembgHelper {
  // API de remove.bg
  static const String _apiUrl = 'https://api.remove.bg/v1.0/removebg';
  static const String _apiKey =
      'yjh7puHPTtprTKzjXH1cQ34B'; // Obtén una API key gratuita en remove.bg

  /// Remueve el fondo de una imagen usando remove.bg
  static Future<String?> removeBackground(String imagePath) async {
    try {
      print('RembgHelper: Starting background removal for: $imagePath');

      // Verificar que el archivo existe
      final file = File(imagePath);
      if (!await file.exists()) {
        print('RembgHelper: File does not exist: $imagePath');
        return null;
      }

      // Obtener el directorio de documentos
      final documentsDir = await getApplicationDocumentsDirectory();
      final processedDir =
          Directory(path.join(documentsDir.path, 'rembg_processed'));

      // Crear el directorio si no existe
      if (!await processedDir.exists()) {
        await processedDir.create(recursive: true);
      }

      // Generar nombre único para la imagen procesada
      final fileName = path.basenameWithoutExtension(imagePath);
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final outputFileName = '${fileName}_no_bg_$timestamp.png';
      final outputPath = path.join(processedDir.path, outputFileName);

      print('RembgHelper: Output path: $outputPath');

      // Leer la imagen
      final imageBytes = await file.readAsBytes();

      // Procesar con rembg
      final processedBytes = await _processWithRembg(imageBytes);

      if (processedBytes != null) {
        // Guardar la imagen procesada
        final outputFile = File(outputPath);
        await outputFile.writeAsBytes(processedBytes);

        print('RembgHelper: Background removal successful: $outputPath');
        return outputPath;
      } else {
        print('RembgHelper: Background removal failed');
        return null;
      }
    } catch (e, stackTrace) {
      print('RembgHelper: Error removing background: $e');
      print('RembgHelper: Stack trace: $stackTrace');
      return null;
    }
  }

  /// Procesa la imagen con remove.bg API
  static Future<Uint8List?> _processWithRembg(Uint8List imageBytes) async {
    try {
      print('RembgHelper: Creating multipart request for remove.bg...');

      // Redimensionar la imagen si es muy grande (en hilo separado)
      final processedImageBytes =
          await compute(_resizeImageIfNeeded, imageBytes);

      // Crear la petición HTTP
      final request = http.MultipartRequest('POST', Uri.parse(_apiUrl));

      // Agregar headers según la documentación de remove.bg
      request.headers.addAll({
        'X-Api-Key': _apiKey,
      });

      print('RembgHelper: Headers added: ${request.headers}');

      // Agregar la imagen como archivo (usando image_file como en el ejemplo)
      request.files.add(
        http.MultipartFile.fromBytes(
          'image_file',
          processedImageBytes,
          filename: 'image.jpg',
        ),
      );

      // Agregar parámetros según la documentación de remove.bg
      request.fields['size'] = 'auto'; // Tamaño automático
      request.fields['format'] = 'png'; // Formato PNG para transparencia

      print('RembgHelper: Request fields: ${request.fields}');
      print('RembgHelper: Request files count: ${request.files.length}');
      print('RembgHelper: Original image size: ${imageBytes.length} bytes');
      print(
          'RembgHelper: Processed image size: ${processedImageBytes.length} bytes');
      print('RembgHelper: Sending request to remove.bg API: $_apiUrl');

      // Enviar la petición
      final streamedResponse = await request.send();
      print('RembgHelper: Request sent, waiting for response...');

      final response = await http.Response.fromStream(streamedResponse);
      print('RembgHelper: Response received - Status: ${response.statusCode}');
      print('RembgHelper: Response headers: ${response.headers}');
      print('RembgHelper: Response body length: ${response.bodyBytes.length}');

      if (response.statusCode == 200) {
        print('RembgHelper: remove.bg API response successful');
        return response.bodyBytes;
      } else {
        print(
            'RembgHelper: remove.bg API error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('RembgHelper: Error with remove.bg API: $e');
      return null;
    }
  }

  /// Redimensiona la imagen si excede los límites de remove.bg
  static Uint8List _resizeImageIfNeeded(Uint8List imageBytes) {
    try {
      print('RembgHelper: Checking image dimensions...');

      // Decodificar la imagen
      final image = img.decodeImage(imageBytes);
      if (image == null) {
        print('RembgHelper: Failed to decode image, returning original');
        return imageBytes;
      }

      final originalWidth = image.width;
      final originalHeight = image.height;
      final megapixels = (originalWidth * originalHeight) / 1000000;

      print(
          'RembgHelper: Original dimensions: ${originalWidth}x${originalHeight}');
      print('RembgHelper: Megapixels: ${megapixels.toStringAsFixed(2)}');

      // Si la imagen es menor a 25 megapíxeles, no redimensionar
      if (megapixels <= 25) {
        print('RembgHelper: Image size is acceptable, no resizing needed');
        return imageBytes;
      }

      // Calcular nuevas dimensiones manteniendo la proporción
      // Objetivo: máximo 25 megapíxeles (5000x5000)
      const maxMegapixels = 25.0;
      const maxDimension = 5000;

      int newWidth = originalWidth;
      int newHeight = originalHeight;

      if (originalWidth > maxDimension || originalHeight > maxDimension) {
        // Redimensionar basado en la dimensión más grande
        if (originalWidth > originalHeight) {
          newWidth = maxDimension;
          newHeight = ((originalHeight * maxDimension) / originalWidth).round();
        } else {
          newHeight = maxDimension;
          newWidth = ((originalWidth * maxDimension) / originalHeight).round();
        }
      } else {
        // Redimensionar proporcionalmente para alcanzar 25 megapíxeles
        final scaleFactor = math.sqrt(maxMegapixels / megapixels);
        newWidth = (originalWidth * scaleFactor).round();
        newHeight = (originalHeight * scaleFactor).round();
      }

      print('RembgHelper: Resizing to: ${newWidth}x${newHeight}');

      // Redimensionar la imagen
      final resizedImage = img.copyResize(
        image,
        width: newWidth,
        height: newHeight,
        interpolation: img.Interpolation.linear,
      );

      // Codificar como JPEG con calidad alta
      final resizedBytes = img.encodeJpg(resizedImage, quality: 95);

      final newMegapixels = (newWidth * newHeight) / 1000000;
      print('RembgHelper: New megapixels: ${newMegapixels.toStringAsFixed(2)}');
      print('RembgHelper: Resized image size: ${resizedBytes.length} bytes');

      return Uint8List.fromList(resizedBytes);
    } catch (e) {
      print('RembgHelper: Error resizing image: $e');
      print('RembgHelper: Returning original image');
      return imageBytes;
    }
  }

  /// Verifica si el servicio está disponible
  static Future<bool> isAvailable() async {
    try {
      print('RembgHelper: Checking remove.bg service availability...');
      // Verificar conectividad básica a la API de remove.bg
      final response = await http.get(
        Uri.parse('https://api.remove.bg'),
        headers: {'X-Api-Key': _apiKey},
      ).timeout(const Duration(seconds: 5));

      print('RembgHelper: remove.bg API response: ${response.statusCode}');
      // Cualquier respuesta (incluso 404) indica que la API está disponible
      return response.statusCode >= 200 && response.statusCode < 500;
    } catch (e) {
      print('RembgHelper: remove.bg service not available: $e');
      // Si no hay internet, intentar de todas formas
      print('RembgHelper: Will attempt processing anyway...');
      return true;
    }
  }

  /// Limpia archivos temporales procesados
  static Future<void> cleanupOldFiles() async {
    try {
      final documentsDir = await getApplicationDocumentsDirectory();
      final processedDir =
          Directory(path.join(documentsDir.path, 'rembg_processed'));

      if (await processedDir.exists()) {
        final files = await processedDir.list().toList();
        final now = DateTime.now();

        for (final file in files) {
          if (file is File) {
            final stat = await file.stat();
            final age = now.difference(stat.modified);

            // Eliminar archivos más antiguos de 3 días
            if (age.inDays > 3) {
              await file.delete();
              print('RembgHelper: Cleaned up old file: ${file.path}');
            }
          }
        }
      }
    } catch (e) {
      print('RembgHelper: Error cleaning up files: $e');
    }
  }

  /// Obtiene estadísticas del servicio
  static Future<Map<String, dynamic>> getStats() async {
    try {
      final documentsDir = await getApplicationDocumentsDirectory();
      final processedDir =
          Directory(path.join(documentsDir.path, 'rembg_processed'));

      int fileCount = 0;
      int totalSize = 0;

      if (await processedDir.exists()) {
        final files = await processedDir.list().toList();
        fileCount = files.length;

        for (final file in files) {
          if (file is File) {
            final stat = await file.stat();
            totalSize += stat.size;
          }
        }
      }

      return {
        'filesProcessed': fileCount,
        'totalSizeBytes': totalSize,
        'serviceAvailable': await isAvailable(),
        'apiKey': _apiKey.isNotEmpty ? 'Configured' : 'Not configured',
      };
    } catch (e) {
      print('RembgHelper: Error getting stats: $e');
      return {
        'filesProcessed': 0,
        'totalSizeBytes': 0,
        'serviceAvailable': false,
        'apiKey': 'Error',
        'error': e.toString(),
      };
    }
  }
}
