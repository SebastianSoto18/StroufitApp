import 'dart:io';
import 'package:flutter/material.dart';
import 'package:stroufitapp/domain/entities/garment_category.dart';

class DraggableGarmentWidget extends StatefulWidget {
  final GarmentCategoryEntity garmentCategory;
  final VoidCallback? onTap;
  final VoidCallback? onDoubleTap;
  final double initialX;
  final double initialY;
  final double initialWidth;
  final double initialHeight;
  final double initialScale;
  final double initialRotation;
  final Function(
          double scale, double positionX, double positionY, double rotation)?
      onPositionChanged;
  final VoidCallback? onInteractionEnd;
  final bool isLocked;
  final VoidCallback? onToggleLock;

  const DraggableGarmentWidget({
    super.key,
    required this.garmentCategory,
    this.onTap,
    this.onDoubleTap,
    this.initialX = 0.0,
    this.initialY = 0.0,
    this.initialWidth = 120.0,
    this.initialHeight = 150.0,
    this.initialScale = 1.0,
    this.initialRotation = 0.0,
    this.onPositionChanged,
    this.onInteractionEnd,
    this.isLocked = false,
    this.onToggleLock,
  });

  @override
  State<DraggableGarmentWidget> createState() => _DraggableGarmentWidgetState();
}

class _DraggableGarmentWidgetState extends State<DraggableGarmentWidget> {
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  bool _isDragging = false;
  bool _isSelected = false;
  bool _isResizing = false;
  double _baseScale = 1.0;
  double _currentScale = 1.0;
  double _currentRotation = 0.0;

  @override
  void initState() {
    super.initState();
    _x = widget.initialX;
    _y = widget.initialY;
    _width = widget.initialWidth;
    _height = widget.initialHeight;
    _baseScale = widget.initialScale;
    _currentScale = widget.initialScale;
    _currentRotation = widget.initialRotation;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _x,
      top: _y,
      child: GestureDetector(
        onScaleStart: (details) {
          setState(() {
            _isDragging = true;
            _isResizing = false;
            _baseScale = _currentScale;
          });
        },
        onScaleUpdate: (details) {
          setState(() {
            // Handle dragging, scaling, and rotation
            if (details.scale != 1.0) {
              // Scaling gesture
              _isResizing = true;
              _isDragging = false;
              _currentScale = (_baseScale * details.scale).clamp(0.5, 3.0);
            } else if (details.rotation.abs() > 0.01) {
              // Rotation gesture (con umbral mínimo para evitar rotaciones accidentales)
              _isResizing = true;
              _isDragging = false;
              _currentRotation += details.rotation;
              // Normalizar la rotación entre 0 y 2π
              while (_currentRotation < 0) _currentRotation += 2 * 3.14159;
              while (_currentRotation >= 2 * 3.14159)
                _currentRotation -= 2 * 3.14159;
              print(
                  'Rotation updated: ${_currentRotation} (${_currentRotation * 180 / 3.14159} degrees)');
            } else if (details.focalPointDelta.dx.abs() > 1.0 ||
                details.focalPointDelta.dy.abs() > 1.0) {
              // Panning gesture (con umbral mínimo para evitar movimientos accidentales)
              _isDragging = true;
              _isResizing = false;
              _x += details.focalPointDelta.dx;
              _y += details.focalPointDelta.dy;

              // Mantener dentro de los límites de la pantalla
              final screenSize = MediaQuery.of(context).size;
              final scaledWidth = _width * _currentScale;
              final scaledHeight = _height * _currentScale;
              _x = _x.clamp(0.0, screenSize.width - scaledWidth);
              _y = _y.clamp(
                  0.0,
                  screenSize.height -
                      scaledHeight -
                      100); // -100 para la barra de navegación
            }
          });
        },
        onScaleEnd: (details) {
          setState(() {
            _isDragging = false;
            _isResizing = false;
            _baseScale = _currentScale;
          });
          // Notificar cambio de posición con las posiciones finales
          widget.onPositionChanged
              ?.call(_currentScale, _x, _y, _currentRotation);
          // Notificar fin de interacción
          widget.onInteractionEnd?.call();
        },
        onTap: widget.onTap,
        onDoubleTap: () {
          print(
              'Double tap detected on garment ${widget.garmentCategory.categoryId}');
          print('Current lock state: ${widget.isLocked}');
          widget.onToggleLock?.call();
          widget.onDoubleTap?.call();
        },
        child: Transform.scale(
          scale: _currentScale,
          child: Transform.rotate(
            angle: _currentRotation,
            child: AnimatedContainer(
              duration: _isDragging || _isResizing
                  ? Duration.zero
                  : const Duration(milliseconds: 200),
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color:
                        Colors.black.withValues(alpha: _isDragging ? 0.3 : 0.1),
                    blurRadius: _isDragging ? 15 : 8,
                    offset: Offset(0, _isDragging ? 8 : 4),
                  ),
                ],
                border: _isSelected
                    ? Border.all(color: Colors.blue, width: 3)
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    // Imagen de la prenda
                    Positioned.fill(
                      child: Image.file(
                        File(widget.garmentCategory.garment.imagePath),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),

                    // Indicador de arrastre (solo cuando se está arrastrando)
                    if (_isDragging)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.open_with,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),

                    // Indicador de selección
                    if (_isSelected)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),

                    // Indicador de candado (aparece cuando está bloqueado)
                    if (widget.isLocked)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),

                    // Indicador de rotación (solo cuando se está rotando)
                    if (_isResizing && _currentRotation != 0.0)
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            '${(_currentRotation * 180 / 3.14159).round()}°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  void resetPosition() {
    setState(() {
      _x = widget.initialX;
      _y = widget.initialY;
      _currentScale = widget.initialScale;
      _currentRotation = widget.initialRotation;
      _baseScale = widget.initialScale;
    });
  }

  void setPosition(double x, double y) {
    setState(() {
      _x = x;
      _y = y;
    });
  }

  Offset getPosition() {
    return Offset(_x, _y);
  }

  Size getSize() {
    return Size(_width, _height);
  }
}
