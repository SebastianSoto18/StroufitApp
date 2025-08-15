import '../entities/category.dart';

extension CategoryEntityCopyWith on CategoryEntity {
  CategoryEntity copyWith({
    int? categoryId,
    String? name,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return CategoryEntity(
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
