import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stroufitapp/theme/custom_styles.dart';
import '../../domain/entities/category.dart';
import '../../domain/helpers/foto_picker_helper.dart';

class CategoryBottomSheet extends StatelessWidget {
  final CategoryEntity category;

  const CategoryBottomSheet({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.4, // Altura inicial
      minChildSize: 0.3,     // Altura mínima
      maxChildSize: 0.85,    // Altura máxima al arrastrar
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              /// Nombre centrado
              Center(
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: 20),

              /// Botón de agregar prenda
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    _showPhotoOptions(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Agregar prenda'),
                      SizedBox(width: 8),
                      Icon(Icons.checkroom, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  void _showPhotoOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Seleccionar opción'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Seleccionar de la galería'),
              onTap: () {
                onPickFromGallery(context);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Tomar foto'),
              onTap: () {
                onTakePhoto(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }


  void onPickFromGallery(BuildContext context) {
    pickMultipleImages().then((paths) {
      if (paths.isNotEmpty) {
  //TODO: Implementar logica para guardar las prendas y asociarlas a la categoria
      } else {

      }
    });
  }

  void onTakePhoto(BuildContext context) {
    // Implementar lógica para tomar una foto
  }
}
