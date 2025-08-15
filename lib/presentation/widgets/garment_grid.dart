import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/domain/entities/garment_category.dart';
import 'package:stroufitapp/providers/photo_provider.dart';
import 'dart:io';

class GarmentGrid extends ConsumerWidget {
  final int categoryId;
  const GarmentGrid({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final garmentCategoriesAsync =
        ref.watch(garmentCategoriesByCategoryProvider(categoryId));
    return garmentCategoriesAsync.when(
      data: (garmentCategories) {
        return GridView.builder(
          padding: const EdgeInsets.all(16), // Aumentado el padding
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12, // Aumentado el espaciado
            mainAxisSpacing: 12, // Aumentado el espaciado
            childAspectRatio:
                1.0, // Cambiado a 1.0 para hacer las tarjetas más grandes
          ),
          itemCount: garmentCategories.length,
          itemBuilder: (context, index) {
            final garmentCategory = garmentCategories[index];
            return _GarmentCard(garmentCategory: garmentCategory);
          },
        );
      },
      loading: () => _SkeletonGrid(),
      error: (error, stackTrace) => _ErrorSkeleton(error: error.toString()),
    );
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
    // Calcular cuántas skeleton cards mostrar basado en el tamaño de pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calcular cuántas filas caben en la pantalla
    final cardHeight =
        (screenWidth - 32 - 12) / 2; // Ancho de card menos padding y spacing
    final availableHeight =
        screenHeight * 0.5; // Altura disponible para el grid
    final rows = (availableHeight / cardHeight).floor();

    // Mostrar skeleton cards para llenar aproximadamente 2-3 filas
    final skeletonCount = (rows * 2).clamp(4, 8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Skeleton header
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16),
          child: Container(
            width: 120,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        // Skeleton grid
        Expanded(
          child: GridView.builder(
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
          ),
        ),
      ],
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
                  // Efecto shimmer
                  Transform.translate(
                    offset: Offset(
                      _shimmerAnimation.value *
                          MediaQuery.of(context).size.width,
                      0,
                    ),
                    child: Container(
                      width: double.infinity,
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
                  // Patrón de ondas sutiles
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 0.8,
                        colors: [
                          Colors.grey[300]!,
                          Colors.grey[400]!.withOpacity(0.3),
                        ],
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

class _GarmentCard extends StatelessWidget {
  final GarmentCategoryEntity garmentCategory;
  const _GarmentCard({required this.garmentCategory});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3, // Aumentado el elevation
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Aumentado el border radius
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(garmentCategory.garment.imagePath)),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
