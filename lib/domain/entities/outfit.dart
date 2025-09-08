import 'package:stroufitapp/domain/entities/outfit_garment.dart';

class OutfitEntity {
  final int outfitId;
  final String? name;
  final String imagePath;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final bool isActive;
  final List<OutfitGarmentEntity>? outfitGarments;

  OutfitEntity({
    required this.outfitId,
    this.name,
    required this.imagePath,
    required this.createdAt,
    this.deletedAt,
    required this.isActive,
    this.outfitGarments,
  });

  OutfitEntity copyWith({
    int? outfitId,
    String? name,
    String? imagePath,
    DateTime? createdAt,
    DateTime? deletedAt,
    bool? isActive,
    List<OutfitGarmentEntity>? outfitGarments,
  }) {
    return OutfitEntity(
      outfitId: outfitId ?? this.outfitId,
      name: name ?? this.name,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isActive: isActive ?? this.isActive,
      outfitGarments: outfitGarments ?? this.outfitGarments,
    );
  }
}
