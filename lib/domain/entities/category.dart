import '../../data/db/tables/garment_categories_table.dart';

class CategoryEntity {
  final int categoryId;
  String name;
  final DateTime createdAt;
  final bool isActive;
  final DateTime? deletedAt;
  final List<GarmentCategories>? garmentCategories;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.createdAt,
    required this.isActive,
    this.deletedAt,
    this.garmentCategories,
  });
}
