import 'package:drift/drift.dart';
import 'package:stroufitapp/data/db/database.dart';
import 'package:stroufitapp/domain/entities/garment.dart';
import 'package:stroufitapp/domain/entities/garment_category.dart';
import 'package:stroufitapp/domain/repositories/garment_repository.dart';
import '../daos/garment_dao.dart';

class GarmentRepositoryImpl implements GarmentRepository {
  final GarmentDao _garmentDao;

  GarmentRepositoryImpl(this._garmentDao);

  @override
  Future<int> insertGarment(GarmentsCompanion garment) {
    try {
      print('GarmentRepository: Inserting garment with imagePath: ${garment.imagePath.value}');
      return _garmentDao.insertGarment(garment);
    } catch (e, stackTrace) {
      print('GarmentRepository: Error inserting garment: $e');
      print('GarmentRepository: Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<void> insertGarmentCategory(
      GarmentCategoriesCompanion garmentCategory) {
    try {
      print(
          'GarmentRepository: Inserting garment category for category: ${garmentCategory.categoryId.value}');
      return _garmentDao.insertGarmentCategory(garmentCategory);
    } catch (e, stackTrace) {
      print('GarmentRepository: Error inserting garment category: $e');
      print('GarmentRepository: Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<GarmentCategoryEntity>> getGarmentCategoriesByCategory(
      int categoryId) {
    try {
      print(
          'GarmentRepository: Getting garment categories for category: $categoryId');
      return _garmentDao.getGarmentCategoriesByCategory(categoryId);
    } catch (e, stackTrace) {
      print('GarmentRepository: Error getting garment categories: $e');
      print('GarmentRepository: Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<List<GarmentEntity>> getAllGarments() {
    try {
      print('GarmentRepository: Getting all garments');
      return _garmentDao.getAllGarments().then((garments) => garments
          .map((g) => GarmentEntity(
                garmentId: g.garmentId,
                // Eliminado el campo name
                imagePath: g.imagePath,
                createdAt: g.createdAt,
                isActive: g.isActive,
                deletedAt: g.deletedAt,
              ))
          .toList());
    } catch (e, stackTrace) {
      print('GarmentRepository: Error getting all garments: $e');
      print('GarmentRepository: Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<void> softDeleteGarment(int id) {
    try {
      print('GarmentRepository: Soft deleting garment: $id');
      return _garmentDao.softDeleteGarment(id);
    } catch (e, stackTrace) {
      print('GarmentRepository: Error soft deleting garment: $e');
      print('GarmentRepository: Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<void> softDeleteGarmentCategory(int id) {
    try {
      print('GarmentRepository: Soft deleting garment category: $id');
      return _garmentDao.softDeleteGarmentCategory(id);
    } catch (e, stackTrace) {
      print('GarmentRepository: Error soft deleting garment category: $e');
      print('GarmentRepository: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
