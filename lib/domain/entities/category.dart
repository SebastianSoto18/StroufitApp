import '../../data/db/tables/garment_categories_table.dart';

class CategoryEntity {
  final int categoryId;
  String name;
  final DateTime createdAt;
  final bool isActive;
  final bool isFavorite;
  final DateTime? deletedAt;
  final List<GarmentCategories>? garmentCategories;
  final double scale;
  final double positionX;
  final double positionY;
  final double rotation;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.createdAt,
    required this.isActive,
    required this.isFavorite,
    this.deletedAt,
    this.garmentCategories,
    this.scale = 1.0,
    this.positionX = 0.0,
    this.positionY = 0.0,
    this.rotation = 0.0,
  });

  CategoryEntity copyWith({
    int? categoryId,
    String? name,
    DateTime? createdAt,
    bool? isActive,
    bool? isFavorite,
    DateTime? deletedAt,
    List<GarmentCategories>? garmentCategories,
    double? scale,
    double? positionX,
    double? positionY,
    double? rotation,
  }) {
    return CategoryEntity(
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      isFavorite: isFavorite ?? this.isFavorite,
      deletedAt: deletedAt ?? this.deletedAt,
      garmentCategories: garmentCategories ?? this.garmentCategories,
      scale: scale ?? this.scale,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      rotation: rotation ?? this.rotation,
    );
  }
}
