import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/background_cleanup_service.dart';

/// Provider para el servicio de limpieza en segundo plano
final backgroundCleanupServiceProvider =
    Provider<BackgroundCleanupService>((ref) {
  return BackgroundCleanupService.instance;
});

/// Provider para obtener estadísticas del servicio de limpieza
final backgroundCleanupStatsProvider = Provider<Map<String, dynamic>>((ref) {
  final service = ref.watch(backgroundCleanupServiceProvider);
  return service.getStats();
});

/// Provider para forzar una limpieza inmediata
final forceCleanupProvider = FutureProvider<void>((ref) async {
  final service = ref.watch(backgroundCleanupServiceProvider);
  await service.forceCleanup();
});
