import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/providers/photo_provider.dart';
import 'package:stroufitapp/providers/garment_selection_provider.dart';
import 'package:stroufitapp/providers/garment_deletion_provider.dart';
import 'optimized_garment_card.dart';

class GarmentGrid extends ConsumerWidget {
  final int categoryId;
  const GarmentGrid({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final garmentCategoriesAsync =
        ref.watch(garmentCategoriesByCategoryProvider(categoryId));
    final hasSelection = ref.watch(hasSelectedGarmentsProvider);
    final selectedCount = ref.watch(selectedGarmentsCountProvider);

    return garmentCategoriesAsync.when(
      data: (garmentCategories) {
        return Stack(
          children: [
            GridView.builder(
              padding: const EdgeInsets.all(16), // Aumentado el padding
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12, // Aumentado el espaciado
                mainAxisSpacing: 12, // Aumentado el espaciado
                childAspectRatio:
                    1.0, // Cambiado a 1.0 para hacer las tarjetas más grandes
              ),
              itemCount: garmentCategories.length,
              // Optimización: usar addAutomaticKeepAlives para mantener widgets vivos
              addAutomaticKeepAlives: true,
              // Optimización: usar addRepaintBoundaries para evitar repintados innecesarios
              addRepaintBoundaries: true,
              // Optimización: usar addSemanticIndexes para mejor accesibilidad
              addSemanticIndexes: true,
              itemBuilder: (context, index) {
                final garmentCategory = garmentCategories[index];
                return OptimizedGarmentCard(
                  garmentCategory: garmentCategory,
                  isSelectionMode: hasSelection,
                );
              },
            ),
            // Botón flotante de eliminación
            if (hasSelection)
              Positioned(
                bottom: 80, // Aumentado de 16 a 80 para mayor separación
                right: 16,
                child: FloatingActionButton.extended(
                  onPressed: () => _showDeleteConfirmationDialog(
                      context, ref, garmentCategories),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: const Icon(Icons.delete),
                  label: Text('Eliminar ($selectedCount)'),
                ),
              ),
          ],
        );
      },
      loading: () => _SkeletonGrid(),
      error: (error, stackTrace) => _ErrorSkeleton(error: error.toString()),
    );
  }

  /// Muestra el diálogo de confirmación para eliminar las prendas seleccionadas
  void _showDeleteConfirmationDialog(
      BuildContext context, WidgetRef ref, List<dynamic> garmentCategories) {
    final selectedIds = ref.read(garmentSelectionProvider);
    final selectedCount = selectedIds.length;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Prendas'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  '¿Estás seguro de que quieres eliminar $selectedCount prenda${selectedCount > 1 ? 's' : ''}?'),
              const SizedBox(height: 16),
              const Text('Esta acción eliminará:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('• Las prendas seleccionadas'),
              const Text(
                  '• Las imágenes se eliminarán gradualmente en segundo plano'),
              const SizedBox(height: 16),
              const Text(
                'Los datos se eliminarán de forma segura.',
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteSelectedGarments(
                    context, ref, selectedIds.toList());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  /// Elimina las prendas seleccionadas
  Future<void> _deleteSelectedGarments(
      BuildContext context, WidgetRef ref, List<int> garmentIds) async {
    try {
      print('GarmentGrid: Starting deletion of ${garmentIds.length} garments');

      // Mostrar indicador de carga
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                      'Eliminando ${garmentIds.length} prenda${garmentIds.length > 1 ? 's' : ''}...'),
                ],
              ),
            ),
          );
        },
      );

      // Eliminar las prendas
      final deletionNotifier = ref.read(garmentDeletionProvider.notifier);
      await deletionNotifier.deleteGarments(garmentIds);

      // Limpiar selección
      ref.read(garmentSelectionProvider.notifier).clearSelection();

      // Invalidar providers para actualizar la UI
      ref.invalidate(garmentCategoriesByCategoryProvider(categoryId));

      // Cerrar indicador de carga
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      // Mostrar mensaje de éxito
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                '${garmentIds.length} prenda${garmentIds.length > 1 ? 's' : ''} eliminada${garmentIds.length > 1 ? 's' : ''} exitosamente. Las imágenes se eliminarán gradualmente.'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
          ),
        );
      }

      print('GarmentGrid: Successfully deleted ${garmentIds.length} garments');
    } catch (e, stackTrace) {
      print('GarmentGrid: Error deleting garments: $e');
      print('GarmentGrid: Stack trace: $stackTrace');

      // Cerrar indicador de carga si está abierto
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      // Mostrar mensaje de error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al eliminar las prendas: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
          ),
        );
      }
    }
  }
}

class _ErrorSkeleton extends StatelessWidget {
  final String error;

  const _ErrorSkeleton({required this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Icono de error
        Icon(
          Icons.error_outline,
          size: 64,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 16),
        // Mensaje de error
        Text(
          'Error al cargar las prendas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 8),
        // Detalles del error
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Botón de reintentar (opcional)
        ElevatedButton.icon(
          onPressed: () {
            // Aquí podrías agregar lógica para reintentar
          },
          icon: const Icon(Icons.refresh),
          label: const Text('Reintentar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}

class _SkeletonGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Número fijo de skeleton cards para evitar cálculos complejos
    const skeletonCount = 6;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: skeletonCount,
      itemBuilder: (context, index) {
        return _SkeletonCard();
      },
    );
  }
}

class _SkeletonCard extends StatefulWidget {
  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AnimatedBuilder(
          animation: _shimmerAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
              ),
              child: Stack(
                children: [
                  // Fondo base
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
                  ),
                  // Efecto shimmer simplificado
                  Transform.translate(
                    offset: Offset(
                      _shimmerAnimation.value *
                          200, // Valor fijo en lugar de MediaQuery
                      0,
                    ),
                    child: Container(
                      width: 200, // Ancho fijo
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.transparent,
                            Colors.white.withOpacity(0.4),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
