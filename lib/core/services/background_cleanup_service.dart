import 'dart:io';
import 'dart:async';
import '../../data/db/database.dart';
import '../../data/db/daos/garment_dao.dart';

/// Servicio que ejecuta limpieza de archivos eliminados en segundo plano
class BackgroundCleanupService {
  static BackgroundCleanupService? _instance;
  static BackgroundCleanupService get instance =>
      _instance ??= BackgroundCleanupService._();

  BackgroundCleanupService._();

  Timer? _cleanupTimer;
  bool _isRunning = false;
  final AppDatabase _database = AppDatabase();
  late final GarmentDao _garmentDao;

  /// Inicializa el servicio de limpieza
  void initialize() {
    _garmentDao = GarmentDao(_database);
    _startPeriodicCleanup();
    print('BackgroundCleanupService: Initialized');
  }

  /// Inicia la limpieza periódica cada 5 minutos
  void _startPeriodicCleanup() {
    if (_isRunning) return;

    _isRunning = true;
    _cleanupTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      _performCleanup();
    });

    print(
        'BackgroundCleanupService: Started periodic cleanup (every 5 minutes)');
  }

  /// Detiene el servicio de limpieza
  void stop() {
    _cleanupTimer?.cancel();
    _cleanupTimer = null;
    _isRunning = false;
    print('BackgroundCleanupService: Stopped');
  }

  /// Ejecuta la limpieza de archivos eliminados
  Future<void> _performCleanup() async {
    try {
      print('BackgroundCleanupService: Starting cleanup cycle');

      // Obtener todas las imágenes marcadas para eliminar
      final deletedImagePaths = await _getDeletedImagePaths();

      if (deletedImagePaths.isEmpty) {
        print('BackgroundCleanupService: No images to clean up');
        return;
      }

      print(
          'BackgroundCleanupService: Found ${deletedImagePaths.length} images to clean up');

      // Eliminar archivos uno por uno con delay
      await _deleteImagesOneByOne(deletedImagePaths);

      print('BackgroundCleanupService: Cleanup cycle completed');
    } catch (e, stackTrace) {
      print('BackgroundCleanupService: Error in cleanup cycle: $e');
      print('BackgroundCleanupService: Stack trace: $stackTrace');
    }
  }

  /// Obtiene las rutas de todas las imágenes marcadas para eliminar
  Future<List<String>> _getDeletedImagePaths() async {
    try {
      // Obtener todos los garments eliminados (soft delete)
      final deletedGarments = await _garmentDao.getDeletedGarments();

      return deletedGarments.map((garment) => garment.imagePath).toList();
    } catch (e, stackTrace) {
      print('BackgroundCleanupService: Error getting deleted image paths: $e');
      print('BackgroundCleanupService: Stack trace: $stackTrace');
      return [];
    }
  }

  /// Elimina las imágenes una por una con delay para evitar sobrecarga
  Future<void> _deleteImagesOneByOne(List<String> imagePaths) async {
    int deletedCount = 0;
    int errorCount = 0;

    for (int i = 0; i < imagePaths.length; i++) {
      final imagePath = imagePaths[i];

      try {
        final file = File(imagePath);

        if (await file.exists()) {
          await file.delete();
          deletedCount++;
          print(
              'BackgroundCleanupService: Deleted image ${i + 1}/${imagePaths.length}: $imagePath');
        } else {
          print('BackgroundCleanupService: Image not found: $imagePath');
        }
      } catch (e) {
        errorCount++;
        print('BackgroundCleanupService: Error deleting image $imagePath: $e');
      }

      // Delay de 100ms entre eliminaciones para evitar sobrecarga
      if (i < imagePaths.length - 1) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }

    print(
        'BackgroundCleanupService: Cleanup summary - Deleted: $deletedCount, Errors: $errorCount');
  }

  /// Fuerza una limpieza inmediata (útil para testing)
  Future<void> forceCleanup() async {
    print('BackgroundCleanupService: Force cleanup requested');
    await _performCleanup();
  }

  /// Obtiene estadísticas del servicio
  Map<String, dynamic> getStats() {
    return {
      'isRunning': _isRunning,
      'hasTimer': _cleanupTimer != null,
      'isActive': _cleanupTimer?.isActive ?? false,
    };
  }
}
