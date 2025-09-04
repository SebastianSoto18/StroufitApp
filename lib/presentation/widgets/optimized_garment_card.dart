import 'package:flutter/material.dart';
import '../../domain/entities/garment_category.dart';
import 'dart:io';

/// Widget optimizado para mostrar tarjetas de prendas con caché de imágenes
/// y optimizaciones para evitar reconstrucciones innecesarias
class OptimizedGarmentCard extends StatelessWidget {
  final GarmentCategoryEntity garmentCategory;

  const OptimizedGarmentCard({
    super.key,
    required this.garmentCategory,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.file(
              File(garmentCategory.garment.imagePath),
              fit: BoxFit.cover,
              // Configuración optimizada para caché
              cacheWidth: 200,
              cacheHeight: 200,
              isAntiAlias: true,
              filterQuality: FilterQuality.medium,
              gaplessPlayback: true,
              // Evitar reconstrucciones innecesarias
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded) return child;
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: child,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
