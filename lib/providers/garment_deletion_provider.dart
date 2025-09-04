import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/data/db/daos/garment_dao.dart';
import 'package:stroufitapp/data/db/database.dart';

/// Provider para la eliminación de prendas
class GarmentDeletionNotifier extends StateNotifier<AsyncValue<void>> {
  GarmentDeletionNotifier() : super(const AsyncValue.data(null));

  /// Eliminar múltiples prendas (soft delete)
  Future<void> deleteGarments(List<int> garmentIds) async {
    state = const AsyncValue.loading();

    try {
      final db = AppDatabase();
      final garmentDao = GarmentDao(db);

      for (final garmentId in garmentIds) {
        await garmentDao.softDeleteGarment(garmentId);
        print('GarmentDeletionNotifier: Soft deleted garment: $garmentId');
      }

      state = const AsyncValue.data(null);
      print(
          'GarmentDeletionNotifier: Successfully soft deleted ${garmentIds.length} garments');
    } catch (e, stackTrace) {
      print('GarmentDeletionNotifier: Error deleting garments: $e');
      print('GarmentDeletionNotifier: Stack trace: $stackTrace');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Eliminar una sola prenda (soft delete)
  Future<void> deleteGarment(int garmentId) async {
    await deleteGarments([garmentId]);
  }
}

/// Provider para la eliminación de prendas
final garmentDeletionProvider =
    StateNotifierProvider<GarmentDeletionNotifier, AsyncValue<void>>((ref) {
  return GarmentDeletionNotifier();
});

/// Provider para eliminar prendas seleccionadas
final deleteSelectedGarmentsProvider =
    FutureProvider.family<void, List<int>>((ref, garmentIds) async {
  final deletionNotifier = ref.read(garmentDeletionProvider.notifier);
  await deletionNotifier.deleteGarments(garmentIds);
});
