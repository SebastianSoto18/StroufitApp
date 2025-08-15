import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/providers/photo_provider.dart';
import 'dart:io';

class AddGarmentForm extends ConsumerStatefulWidget {
  final int categoryId;
  final String imagePath;
  const AddGarmentForm(
      {super.key, required this.categoryId, required this.imagePath});

  @override
  ConsumerState<AddGarmentForm> createState() => _AddGarmentFormState();
}

class _AddGarmentFormState extends ConsumerState<AddGarmentForm> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Guardar automáticamente al abrir el formulario
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _saveGarment();
    });
  }

  Future<void> _saveGarment() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      print('AddGarmentForm: Saving garment automatically');
      print(
          'AddGarmentForm: categoryId: ${widget.categoryId} (type: ${widget.categoryId.runtimeType})');
      print(
          'AddGarmentForm: imagePath: ${widget.imagePath} (type: ${widget.imagePath.runtimeType})');

      final params = {
        'categoryId': widget.categoryId,
        'imagePath': widget.imagePath,
      };

      print('AddGarmentForm: params: $params');
      print(
          'AddGarmentForm: params types - categoryId: ${params['categoryId'].runtimeType}, imagePath: ${params['imagePath'].runtimeType}');

      await ref.read(createGarmentWithCategoryProvider(params).future);
      ref
          .read(garmentCategoriesNotifierProvider.notifier)
          .invalidateGarmentCategories(widget.categoryId);

      // Cerrar el diálogo primero
      if (mounted) {
        Navigator.of(context).pop();

        // Mostrar notificación de éxito después de cerrar el diálogo
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prenda agregada exitosamente'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
          ),
        );
      }
    } catch (e) {
      print('AddGarmentForm: Error saving garment: $e');
      print('AddGarmentForm: Error type: ${e.runtimeType}');
      if (e is TypeError) {
        print('AddGarmentForm: TypeError details: ${e.toString()}');
      }

      // Cerrar el diálogo primero
      if (mounted) {
        Navigator.of(context).pop();

        // Mostrar error después de cerrar el diálogo
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al agregar la prenda: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Agregando Prenda'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading) ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 24),
              const Text(
                'Guardando prenda...',
                style: TextStyle(fontSize: 18),
              ),
            ] else ...[
              const Text(
                'La prenda se guardará automáticamente',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 32),
            // Vista previa de la imagen
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.error,
                        size: 80,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
