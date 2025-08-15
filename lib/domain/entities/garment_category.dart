import 'garment.dart';

class GarmentCategoryEntity {
  final int garmentCategoriesId;
  final int categoryId;
  final int garmentId;
  final DateTime createdAt;
  final bool isActive;
  final DateTime? deletedAt;
  final GarmentEntity garment; // Incluye el objeto Garment completo

  GarmentCategoryEntity({
    required this.garmentCategoriesId,
    required this.categoryId,
    required this.garmentId,
    required this.createdAt,
    required this.isActive,
    this.deletedAt,
    required this.garment,
  });
}
