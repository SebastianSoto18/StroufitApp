import '../entities/category.dart';

extension CategoryEntityCopyWith on CategoryEntity {
  CategoryEntity copyWith({
    int? id,
    String? name,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return CategoryEntity(
      categoryId: id ?? this.categoryId,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
