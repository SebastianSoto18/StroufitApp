import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/providers/photo_provider.dart';
import 'package:stroufitapp/domain/helpers/rembg_helper.dart';

class AddGarmentForm extends ConsumerStatefulWidget {
  final int categoryId;
  final String imagePath;
  final VoidCallback? onSuccess;
  final Function(String)? onError;

  const AddGarmentForm({
    super.key,
    required this.categoryId,
    required this.imagePath,
    this.onSuccess,
    this.onError,
  });

  @override
  ConsumerState<AddGarmentForm> createState() => _AddGarmentFormState();
}

class _AddGarmentFormState extends ConsumerState<AddGarmentForm> {
  bool _isLoading = false;
  bool _isProcessingBackground = false;
  String _currentImagePath = '';
  bool _rembgAvailable = false;

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.imagePath;
    // Procesar fondo automáticamente después de verificar disponibilidad
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAndProcess();
    });
  }

  Future<void> _initializeAndProcess() async {
    print('AddGarmentForm: Initializing and processing...');
    await _checkRembgAvailability();
    print('AddGarmentForm: Rembg available: $_rembgAvailable');
    await _processBackgroundAutomatically();
  }

  Future<void> _checkRembgAvailability() async {
    final isAvailable = await RembgHelper.isAvailable();
    if (mounted) {
      setState(() {
        _rembgAvailable = isAvailable;
      });
    }
  }

  Future<void> _processBackgroundAutomatically() async {
    print('AddGarmentForm: _processBackgroundAutomatically called');
    print('AddGarmentForm: _isProcessingBackground: $_isProcessingBackground');
    print('AddGarmentForm: _rembgAvailable: $_rembgAvailable');

    if (_isProcessingBackground || !_rembgAvailable) {
      // Si no está disponible, guardar directamente
      print('AddGarmentForm: Skipping background removal, saving directly');
      _saveGarment();
      return;
    }

    if (mounted) {
      setState(() {
        _isProcessingBackground = true;
      });
    }

    try {
      print('AddGarmentForm: Starting automatic background removal');

      final result = await RembgHelper.removeBackground(_currentImagePath);

      if (result != null && result.isNotEmpty) {
        if (mounted) {
          setState(() {
            _currentImagePath = result;
          });
        }

        print('AddGarmentForm: Background removal successful: $result');

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fondo removido automáticamente con rembg'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
            ),
          );
        }
      } else {
        print(
            'AddGarmentForm: Background removal failed, using original image');
      }
    } catch (e) {
      print('AddGarmentForm: Error removing background: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isProcessingBackground = false;
        });
        // Guardar la prenda después del procesamiento
        _saveGarment();
      }
    }
  }

  Future<void> _saveGarment() async {
    if (_isLoading) return;

    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      print('AddGarmentForm: Saving garment automatically');
      print(
          'AddGarmentForm: categoryId: ${widget.categoryId} (type: ${widget.categoryId.runtimeType})');
      print(
          'AddGarmentForm: imagePath: ${widget.imagePath} (type: ${widget.imagePath.runtimeType})');

      final params = {
        'categoryId': widget.categoryId,
        'imagePath': _currentImagePath,
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

        // Usar callback para mostrar notificación desde el contexto correcto
        if (widget.onSuccess != null) {
          widget.onSuccess!();
        } else {
          // Fallback si no se proporciona callback
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

        // Usar callback para mostrar error desde el contexto correcto
        if (widget.onError != null) {
          widget.onError!(e.toString());
        } else {
          // Fallback si no se proporciona callback
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Loader principal
            const CircularProgressIndicator(
              color: Colors.blue,
              strokeWidth: 4,
            ),
            const SizedBox(height: 32),
            // Mensaje de procesamiento
            Text(
              _isProcessingBackground
                  ? 'Procesando imagen...'
                  : 'Guardando prenda...',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            // Mensaje secundario
            Text(
              _isProcessingBackground
                  ? 'Removiendo fondo automáticamente'
                  : 'Finalizando proceso...',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 48),
            // Indicador de progreso (opcional)
            if (_isProcessingBackground)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_fix_high,
                        color: Colors.blue.shade700, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Usando inteligencia artificial',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
