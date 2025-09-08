import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/garment_category.dart';
import '../../providers/garment_selection_provider.dart';
import 'dart:io';

/// Widget optimizado para mostrar tarjetas de prendas con caché de imágenes
/// y optimizaciones para evitar reconstrucciones innecesarias
class OptimizedGarmentCard extends ConsumerWidget {
  final GarmentCategoryEntity garmentCategory;
  final bool isSelectionMode;
  final bool isReadOnly;
  final Function(String)? onGarmentSelected;

  const OptimizedGarmentCard({
    super.key,
    required this.garmentCategory,
    this.isSelectionMode = false,
    this.isReadOnly = false,
    this.onGarmentSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref
        .watch(garmentSelectionProvider)
        .contains(garmentCategory.garment.garmentId);

    return RepaintBoundary(
      child: GestureDetector(
        onLongPress: (isSelectionMode || isReadOnly)
            ? null
            : () {
                // Activar modo de selección y seleccionar esta prenda
                ref
                    .read(garmentSelectionProvider.notifier)
                    .selectGarment(garmentCategory.garment.garmentId);
              },
        onTap: isReadOnly
            ? () {
                // Modo solo lectura - seleccionar prenda y devolver ruta
                onGarmentSelected?.call(garmentCategory.garment.imagePath);
              }
            : isSelectionMode
                ? () {
                    // Alternar selección en modo de selección
                    ref
                        .read(garmentSelectionProvider.notifier)
                        .toggleSelection(garmentCategory.garment.garmentId);
                  }
                : null,
        child: Card(
          elevation: isSelected ? 6 : 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isSelected
                ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
                : BorderSide.none,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey
                        .shade100, // Fondo sutil para imágenes con transparencia
                  ),
                  child: Image.file(
                    File(garmentCategory.garment.imagePath),
                    fit: BoxFit
                        .contain, // Cambiar de cover a contain para mantener proporciones
                    // Configuración optimizada para caché
                    cacheWidth: 200,
                    cacheHeight: 200,
                    isAntiAlias: true,
                    filterQuality: FilterQuality.high, // Mejorar calidad
                    gaplessPlayback: true,
                    // Evitar reconstrucciones innecesarias
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded) return child;
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(milliseconds: 200),
                        child: child,
                      );
                    },
                  ),
                ),
                // Checkbox en la esquina superior derecha
                if (isSelected)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
