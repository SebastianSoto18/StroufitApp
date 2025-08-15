class GarmentEntity {
  final int garmentId;
  final String imagePath;
  final DateTime createdAt;
  final bool isActive;
  final DateTime? deletedAt;

  GarmentEntity({
    required this.garmentId,
    required this.imagePath,
    required this.createdAt,
    required this.isActive,
    this.deletedAt,
  });
}
