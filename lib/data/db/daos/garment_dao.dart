import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/garments_table.dart';
import '../tables/garment_categories_table.dart';
import '../../../domain/entities/garment.dart';
import '../../../domain/entities/garment_category.dart';

part 'garment_dao.g.dart';

@DriftAccessor(tables: [Garments, GarmentCategories])
class GarmentDao extends DatabaseAccessor<AppDatabase> with _$GarmentDaoMixin {
  final AppDatabase db;

  GarmentDao(this.db) : super(db);

  Future<List<Garment>> getAllGarments() {
    return select(garments).get();
  }

  Future<int> insertGarment(GarmentsCompanion garment) async {
    try {
      print(
          'GarmentDAO: Inserting garment with imagePath: ${garment.imagePath.value}');
      final id = await into(garments).insert(garment);
      print('GarmentDAO: Garment inserted successfully with ID: $id');
      return id;
    } catch (e, stackTrace) {
      print('GarmentDAO: Error inserting garment: $e');
      print('GarmentDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> insertGarmentCategory(
      GarmentCategoriesCompanion garmentCategory) async {
    try {
      print('GarmentDAO: Inserting garment category');
      await into(garmentCategories).insert(garmentCategory);
      print('GarmentDAO: Garment category inserted successfully');
    } catch (e, stackTrace) {
      print('GarmentDAO: Error inserting garment category: $e');
      print('GarmentDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<List<GarmentCategoryEntity>> getGarmentCategoriesByCategory(
      int categoryId) async {
    try {
      print('GarmentDAO: Getting garment categories for category: $categoryId');

      final query = select(garmentCategories).join([
        leftOuterJoin(
            garments, garments.garmentId.equalsExp(garmentCategories.garmentId))
      ])
        ..where(garmentCategories.categoryId.equals(categoryId))
        ..where(garmentCategories.isActive.equals(true))
        ..where(garments.isActive.equals(true));

      final results = await query.get();

      return results.map((row) {
        final garmentCategory = row.readTable(garmentCategories);
        final garment = row.readTable(garments);

        return GarmentCategoryEntity(
          garmentCategoriesId: garmentCategory.garmentCategoriesId,
          categoryId: garmentCategory.categoryId,
          garmentId: garmentCategory.garmentId,
          createdAt: garmentCategory.createdAt,
          isActive: garmentCategory.isActive,
          deletedAt: garmentCategory.deletedAt,
          garment: GarmentEntity(
            garmentId: garment.garmentId,
            imagePath: garment.imagePath,
            createdAt: garment.createdAt,
            isActive: garment.isActive,
            deletedAt: garment.deletedAt,
          ),
        );
      }).toList();
    } catch (e, stackTrace) {
      print('GarmentDAO: Error getting garment categories: $e');
      print('GarmentDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> softDeleteGarment(int id) async {
    await (update(garments)..where((tbl) => tbl.garmentId.equals(id))).write(
      GarmentsCompanion(
          isActive: const Value(false), deletedAt: Value(DateTime.now())),
    );
  }

  Future<void> softDeleteGarmentCategory(int id) async {
    await (update(garmentCategories)
          ..where((tbl) => tbl.garmentCategoriesId.equals(id)))
        .write(
      GarmentCategoriesCompanion(
          isActive: const Value(false), deletedAt: Value(DateTime.now())),
    );
  }
}
