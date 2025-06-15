class CategoryEntity {
  final int categoryId;
  final String name;
  final DateTime createdAt;
  final bool isActive;
  final DateTime? deletedAt;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.createdAt,
    required this.isActive,
    this.deletedAt,
  });
}