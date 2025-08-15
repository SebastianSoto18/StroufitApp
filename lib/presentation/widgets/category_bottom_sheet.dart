import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/category.dart';
import '../../domain/helpers/foto_picker_helper.dart';
import 'add_garment_form.dart';
import 'garment_grid.dart';

class CategoryBottomSheet extends ConsumerWidget {
  final CategoryEntity category;
  final Function(String imagePath)?
      onImageSelected; // Callback para cuando se selecciona una imagen

  const CategoryBottomSheet({
    super.key,
    required this.category,
    this.onImageSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Header con título y botón de cerrar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              // Contenido principal
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.zero,
                  children: [
                    // Botones de acción
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () {
                            _showPhotoOptions(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text('Agregar prenda'),
                              SizedBox(width: 8),
                              Icon(Icons.add_a_photo, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Grid de prendas
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: GarmentGrid(categoryId: category.categoryId),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Seleccionar imagen',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onPickFromGallery();
                    },
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galería'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onTakePhoto();
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Cámara'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
    );
  }

  void onPickFromGallery() {
    pickMultipleImages().then((paths) {
      if (paths.isNotEmpty) {
        for (String imagePath in paths) {
          if (imagePath.isNotEmpty) {
            print('CategoryBottomSheet: Gallery image path: $imagePath');
            _handleImageSelection(imagePath);
          } else {
            print('CategoryBottomSheet: Empty image path from gallery');
          }
        }
      } else {
        print('CategoryBottomSheet: No images selected from gallery');
      }
    }).catchError((error) {
      print('CategoryBottomSheet: Error picking images from gallery: $error');
    });
  }

  void onTakePhoto() async {
    try {
      // Usar un contexto global para la cámara
      final photoPath = await pickImageFromCamera(
          null); // Pasamos null para evitar problemas de contexto
      print('CategoryBottomSheet: Camera photo path: $photoPath');

      if (photoPath != null && photoPath.isNotEmpty) {
        _handleImageSelection(photoPath);
      } else {
        print(
            'CategoryBottomSheet: Invalid photo path from camera: $photoPath');
      }
    } catch (e) {
      print('CategoryBottomSheet: Error taking photo: $e');
    }
  }

  void _handleImageSelection(String imagePath) {
    // Usar un enfoque simple y directo
    _showAddGarmentFormDirect(imagePath);
  }

  void _showAddGarmentFormDirect(String imagePath) {
    print(
        'CategoryBottomSheet: Showing form with categoryId: ${category.categoryId}, imagePath: $imagePath');
    if (imagePath.isEmpty) {
      print('CategoryBottomSheet: Error: imagePath is empty');
      return;
    }

    // Usar un enfoque que no dependa del contexto del CategoryBottomSheet
    // En lugar de Navigator, vamos a usar un callback o un provider
    _showAddGarmentFormUsingProvider(imagePath);
  }

  void _showAddGarmentFormUsingProvider(String imagePath) {
    // Usar Riverpod para manejar la navegación de manera más robusta
    // Por ahora, vamos a usar un enfoque simple con un delay
    Future.delayed(const Duration(milliseconds: 100), () {
      // Intentar mostrar el formulario usando el contexto del widget padre
      _tryShowFormWithParentContext(imagePath);
    });
  }

  void _tryShowFormWithParentContext(String imagePath) {
    // Este método será llamado desde el widget padre que tiene un contexto válido
    if (onImageSelected != null) {
      onImageSelected!(imagePath);
    } else {
      print(
          'CategoryBottomSheet: No callback provided, cannot show AddGarmentForm');
      // Aquí podrías implementar un fallback
    }
  }
}
