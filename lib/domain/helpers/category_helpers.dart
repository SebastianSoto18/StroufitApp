import '../entities/category.dart';

extension CategoryEntityCopyWith on CategoryEntity {
  CategoryEntity copyWith({
    int? categoryId,
    String? name,
    bool? isActive,
    bool? isFavorite,
    DateTime? createdAt,
    double? scale,
    double? positionX,
    double? positionY,
    double? rotation,
  }) {
    return CategoryEntity(
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      scale: scale ?? this.scale,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      rotation: rotation ?? this.rotation,
    );
  }
}
