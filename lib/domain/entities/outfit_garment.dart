import 'package:stroufitapp/domain/entities/garment.dart';

class OutfitGarmentEntity {
  final int outfitGarmentId;
  final int outfitId;
  final int garmentId;
  final double scale;
  final double positionX;
  final double positionY;
  final double rotation;
  final DateTime createdAt;
  final DateTime? deletedAt;
  final bool isActive;
  final GarmentEntity? garment;

  OutfitGarmentEntity({
    required this.outfitGarmentId,
    required this.outfitId,
    required this.garmentId,
    required this.scale,
    required this.positionX,
    required this.positionY,
    required this.rotation,
    required this.createdAt,
    this.deletedAt,
    required this.isActive,
    this.garment,
  });

  OutfitGarmentEntity copyWith({
    int? outfitGarmentId,
    int? outfitId,
    int? garmentId,
    double? scale,
    double? positionX,
    double? positionY,
    double? rotation,
    DateTime? createdAt,
    DateTime? deletedAt,
    bool? isActive,
    GarmentEntity? garment,
  }) {
    return OutfitGarmentEntity(
      outfitGarmentId: outfitGarmentId ?? this.outfitGarmentId,
      outfitId: outfitId ?? this.outfitId,
      garmentId: garmentId ?? this.garmentId,
      scale: scale ?? this.scale,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      rotation: rotation ?? this.rotation,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      isActive: isActive ?? this.isActive,
      garment: garment ?? this.garment,
    );
  }
}
