import 'package:drift/drift.dart';
import 'package:stroufitapp/data/db/database.dart';
import 'package:stroufitapp/data/db/tables/outfits_table.dart';

part 'outfits_dao.g.dart';

@DriftAccessor(tables: [Outfits, OutfitsGarments, Garments])
class OutfitsDao extends DatabaseAccessor<AppDatabase> with _$OutfitsDaoMixin {
  OutfitsDao(AppDatabase db) : super(db);

  /// Obtiene todos los outfits activos
  Future<List<Outfit>> getAllOutfits() async {
    try {
      print('OutfitsDAO: Getting all outfits');
      final outfits = await (select(outfits)
            ..where((tbl) => tbl.isActive.equals(true))
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
          .get();
      print('OutfitsDAO: Found ${outfits.length} outfits');
      return outfits;
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error getting outfits: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Obtiene un outfit por ID con sus prendas
  Future<Outfit?> getOutfitById(int outfitId) async {
    try {
      print('OutfitsDAO: Getting outfit by ID: $outfitId');
      final outfit = await (select(outfits)
            ..where((tbl) =>
                tbl.outfitId.equals(outfitId) & tbl.isActive.equals(true)))
          .getSingleOrNull();
      print('OutfitsDAO: Found outfit: ${outfit?.name}');
      return outfit;
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error getting outfit by ID: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Obtiene las prendas de un outfit
  Future<List<OutfitsGarment>> getOutfitGarments(int outfitId) async {
    try {
      print('OutfitsDAO: Getting garments for outfit: $outfitId');
      final outfitGarments = await (select(outfitsGarments)
            ..where((tbl) =>
                tbl.outfitId.equals(outfitId) & tbl.isActive.equals(true)))
          .get();
      print('OutfitsDAO: Found ${outfitGarments.length} garments for outfit');
      return outfitGarments;
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error getting outfit garments: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Inserta un nuevo outfit
  Future<int> insertOutfit(OutfitsCompanion outfit) async {
    try {
      print('OutfitsDAO: Inserting outfit: ${outfit.name.value}');
      final outfitId = await into(outfits).insert(outfit);
      print('OutfitsDAO: Outfit inserted with ID: $outfitId');
      return outfitId;
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error inserting outfit: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Inserta prendas para un outfit
  Future<void> insertOutfitGarments(
      List<OutfitsGarmentsCompanion> outfitGarments) async {
    try {
      print('OutfitsDAO: Inserting ${outfitGarments.length} outfit garments');
      await batch((batch) {
        batch.insertAll(outfitsGarments, outfitGarments);
      });
      print('OutfitsDAO: Outfit garments inserted successfully');
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error inserting outfit garments: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Actualiza un outfit
  Future<void> updateOutfit(OutfitsCompanion outfit) async {
    try {
      print('OutfitsDAO: Updating outfit: ${outfit.outfitId.value}');
      await (update(outfits)
            ..where((tbl) => tbl.outfitId.equals(outfit.outfitId.value!)))
          .write(outfit);
      print('OutfitsDAO: Outfit updated successfully');
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error updating outfit: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Elimina un outfit (soft delete)
  Future<void> softDeleteOutfit(int outfitId) async {
    try {
      print('OutfitsDAO: Soft deleting outfit: $outfitId');
      await (update(outfits)..where((tbl) => tbl.outfitId.equals(outfitId)))
          .write(OutfitsCompanion(
        isActive: const Value(false),
        deletedAt: Value(DateTime.now()),
      ));

      // También eliminar las prendas del outfit
      await (update(outfitsGarments)
            ..where((tbl) => tbl.outfitId.equals(outfitId)))
          .write(OutfitsGarmentsCompanion(
        isActive: const Value(false),
        deletedAt: Value(DateTime.now()),
      ));

      print('OutfitsDAO: Outfit soft deleted successfully');
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error soft deleting outfit: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
