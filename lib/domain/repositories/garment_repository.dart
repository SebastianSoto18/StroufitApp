import 'package:drift/drift.dart';
import '../entities/garment.dart';
import '../entities/garment_category.dart';
import '../../data/db/database.dart';

abstract class GarmentRepository {
  Future<void> insertGarment(GarmentsCompanion garment);
  Future<void> insertGarmentCategory(
      GarmentCategoriesCompanion garmentCategory);
  Future<List<GarmentCategoryEntity>> getGarmentCategoriesByCategory(
      int categoryId);
  Future<List<GarmentEntity>> getAllGarments();
  Future<void> softDeleteGarment(int id);
  Future<void> softDeleteGarmentCategory(int id);
}
