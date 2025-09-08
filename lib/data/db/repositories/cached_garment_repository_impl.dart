import 'package:stroufitapp/core/services/garment_cache_service.dart';
import 'package:stroufitapp/data/db/database.dart';
import 'package:stroufitapp/domain/entities/garment.dart';
import 'package:stroufitapp/domain/entities/garment_category.dart';
import 'package:stroufitapp/domain/repositories/garment_repository.dart';
import '../daos/garment_dao.dart';

class CachedGarmentRepositoryImpl implements GarmentRepository {
  final GarmentDao _garmentDao;
  final GarmentCacheService _cacheService;

  CachedGarmentRepositoryImpl(this._garmentDao, this._cacheService);

  @override
  Future<int> insertGarment(GarmentsCompanion garment) async {
    try {
      final garmentId = await _garmentDao.insertGarment(garment);

      // Invalidar cache relacionado
      _cacheService.invalidateAllCache();

      return garmentId;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertGarmentCategory(
      GarmentCategoriesCompanion garmentCategory) async {
    try {
      await _garmentDao.insertGarmentCategory(garmentCategory);

      // Invalidar cache de la categoría afectada
      _cacheService.invalidateCategoryCache(garmentCategory.categoryId.value);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GarmentCategoryEntity>> getGarmentCategoriesByCategory(
      int categoryId) async {
    try {
      // Verificar si está en cache
      final cachedResult =
          _cacheService.getGarmentCategoriesFromCache(categoryId);
      if (cachedResult != null) {
        return List.from(cachedResult);
      }

      // Si no está en cache, obtener de la base de datos
      final result =
          await _garmentDao.getGarmentCategoriesByCategory(categoryId);

      // Guardar en cache
      _cacheService.cacheGarmentCategories(categoryId, result);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GarmentEntity>> getAllGarments() async {
    try {
      final result =
          await _garmentDao.getAllGarments().then((garments) => garments
              .map((g) => GarmentEntity(
                    garmentId: g.garmentId,
                    imagePath: g.imagePath,
                    createdAt: g.createdAt,
                    isActive: g.isActive,
                    deletedAt: g.deletedAt,
                  ))
              .toList());

      // Cachear todas las garments individualmente
      for (final garment in result) {
        _cacheService.cacheGarment(garment);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> softDeleteGarment(int id) async {
    try {
      await _garmentDao.softDeleteGarment(id);

      // Invalidar cache de la garment eliminada
      _cacheService.invalidateGarmentCache(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> softDeleteGarmentCategory(int id) async {
    try {
      await _garmentDao.softDeleteGarmentCategory(id);

      // Invalidar todo el cache ya que no sabemos qué categoría se afectó
      _cacheService.invalidateAllCache();
    } catch (e) {
      rethrow;
    }
  }

  /// Método específico para invalidar cache cuando se elimina una foto de una categoría
  void invalidateCacheOnPhotoDelete(int categoryId) {
    _cacheService.invalidateCategoryCache(categoryId);
  }

  /// Método específico para invalidar cache cuando se agrega una foto a una categoría
  void invalidateCacheOnPhotoAdd(int categoryId) {
    _cacheService.invalidateCategoryCache(categoryId);
  }

  /// Obtiene estadísticas del cache
  Map<String, int> getCacheStats() {
    return _cacheService.getCacheStats();
  }

  /// Limpia el cache
  void clearCache() {
    _cacheService.invalidateAllCache();
  }
}
