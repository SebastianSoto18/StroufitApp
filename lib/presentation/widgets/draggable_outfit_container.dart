import 'package:flutter/material.dart';
import 'package:stroufitapp/domain/entities/garment_category.dart';
import 'draggable_garment_widget.dart';

class DraggableOutfitContainer extends StatefulWidget {
  final List<GarmentCategoryEntity> garments;
  final VoidCallback? onGarmentTapped;
  final VoidCallback? onGarmentDoubleTapped;
  final VoidCallback? onResetLayout;
  final VoidCallback? onSavePositions;
  final Function(int categoryId, double scale, double positionX,
      double positionY, double rotation)? onPositionChanged;
  final VoidCallback? onInteractionEnd;
  final Map<int, Map<String, double>>? savedPositions;
  final Map<int, bool>? lockedGarments;
  final Function(int categoryId, bool isLocked)? onToggleLock;

  const DraggableOutfitContainer({
    super.key,
    required this.garments,
    this.onGarmentTapped,
    this.onGarmentDoubleTapped,
    this.onResetLayout,
    this.onSavePositions,
    this.onPositionChanged,
    this.onInteractionEnd,
    this.savedPositions,
    this.lockedGarments,
    this.onToggleLock,
  });

  @override
  State<DraggableOutfitContainer> createState() =>
      _DraggableOutfitContainerState();
}

class _DraggableOutfitContainerState extends State<DraggableOutfitContainer> {
  final List<DraggableGarmentWidget> _draggableWidgets = [];
  final GlobalKey _containerKey = GlobalKey();
  bool _showGrid = false;

  @override
  void initState() {
    super.initState();
    // No crear widgets aquí, se hará en build()
  }

  @override
  void didUpdateWidget(DraggableOutfitContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Limpiar si cambió el número de prendas, las prendas son diferentes, el estado de bloqueo cambió, o las posiciones guardadas cambiaron
    if (oldWidget.garments.length != widget.garments.length) {
      print('Garment count changed, clearing widgets');
      _draggableWidgets.clear();
    } else if (oldWidget.lockedGarments != widget.lockedGarments) {
      print('Lock state changed, clearing widgets');
      _draggableWidgets.clear();
    } else if (oldWidget.savedPositions != widget.savedPositions) {
      print('Saved positions changed, clearing widgets');
      _draggableWidgets.clear();
    } else {
      // Verificar si las prendas son las mismas (mismo garmentId)
      bool garmentsChanged = false;
      for (int i = 0; i < widget.garments.length; i++) {
        if (oldWidget.garments[i].garmentId != widget.garments[i].garmentId) {
          garmentsChanged = true;
          break;
        }
      }
      if (garmentsChanged) {
        print('Garments changed, clearing widgets');
        _draggableWidgets.clear();
      } else {
        print('Same garments, lock state, and positions, keeping widgets');
      }
    }
  }

  void _createDraggableWidgets(BuildContext context) {
    print(
        'Creating draggable widgets. Current count: ${_draggableWidgets.length}, Garments count: ${widget.garments.length}');
    print('Locked garments: ${widget.lockedGarments}');
    print('Saved positions: ${widget.savedPositions}');

    // Siempre recrear los widgets para asegurar que el estado se actualice
    print('Recreating widgets to update state');
    _draggableWidgets.clear();

    for (int i = 0; i < widget.garments.length; i++) {
      final garment = widget.garments[i];

      // Usar posiciones guardadas si están disponibles, sino calcular posición inicial
      double x, y, scale = 1.0, rotation = 0.0;

      if (widget.savedPositions != null &&
          widget.savedPositions!.containsKey(garment.categoryId)) {
        final savedPosition = widget.savedPositions![garment.categoryId]!;
        x = savedPosition['positionX'] ?? 0.0;
        y = savedPosition['positionY'] ?? 0.0;
        scale = savedPosition['scale'] ?? 1.0;
        rotation = savedPosition['rotation'] ?? 0.0;
        print(
            'Using saved position for garment ${garment.garmentId} (category ${garment.categoryId}): scale=$scale, x=$x, y=$y, rotation=$rotation');
      } else {
        // Calcular posición inicial para distribuir las prendas
        final screenWidth = MediaQuery.of(context).size.width;
        final cols = (widget.garments.length / 2).ceil();
        final itemWidth = (screenWidth - 40) / cols;
        final itemHeight = 150.0;
        final row = i ~/ cols;
        final col = i % cols;
        x = 20 + (col * itemWidth);
        y = 100 + (row * (itemHeight + 20));
      }

      final itemWidth = 120.0;
      final itemHeight = 150.0;

      _draggableWidgets.add(
        DraggableGarmentWidget(
          key: ValueKey('garment_${garment.garmentId}'),
          garmentCategory: garment,
          initialX: x,
          initialY: y,
          initialWidth: itemWidth - 10,
          initialHeight: itemHeight,
          initialScale: scale,
          initialRotation: rotation,
          onTap: () {
            _toggleSelection(i);
            widget.onGarmentTapped?.call();
          },
          onDoubleTap: () {
            // El doble tap ahora se maneja en el widget individual para bloquear/desbloquear
            widget.onGarmentDoubleTapped?.call();
          },
          onPositionChanged: (scale, positionX, positionY, rotation) {
            widget.onPositionChanged?.call(
                garment.categoryId, scale, positionX, positionY, rotation);
          },
          onInteractionEnd: () {
            widget.onInteractionEnd?.call();
          },
          isLocked: widget.lockedGarments?[garment.categoryId] ?? false,
          onToggleLock: () {
            widget.onToggleLock?.call(garment.categoryId,
                !(widget.lockedGarments?[garment.categoryId] ?? false));
          },
        ),
      );
    }
  }

  void _toggleSelection(int index) {
    setState(() {
      // La selección se maneja internamente en cada DraggableGarmentWidget
    });
  }

  void _resetPosition(int index) {
    setState(() {
      // La posición se resetea internamente en cada DraggableGarmentWidget
    });
  }

  void resetAllPositions() {
    setState(() {
      // Limpiar widgets para que se recreen en el próximo build
      _draggableWidgets.clear();
    });
    // Notificar el reset para que se actualicen las posiciones guardadas
    widget.onResetLayout?.call();
  }

  void forceUpdate() {
    setState(() {
      // Forzar actualización limpiando widgets
      _draggableWidgets.clear();
    });
  }

  void toggleGrid() {
    setState(() {
      _showGrid = !_showGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Crear los widgets draggables aquí donde ya tenemos acceso al context
    _createDraggableWidgets(context);

    return Container(
      key: _containerKey,
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        image: _showGrid
            ? DecorationImage(
                image: AssetImage('assets/images/grid_pattern.png'),
                fit: BoxFit.cover,
                opacity: 0.1,
              )
            : null,
      ),
      child: Stack(
        children: [
          // Grid de fondo (opcional)
          if (_showGrid) _buildGrid(),

          // Prendas draggables
          ..._draggableWidgets,

          // Controles flotantes
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Botón para mostrar/ocultar grid
                FloatingActionButton.small(
                  onPressed: toggleGrid,
                  backgroundColor: _showGrid ? Colors.blue : Colors.grey[600],
                  child: Icon(
                    _showGrid ? Icons.grid_off : Icons.grid_on,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),

                // Botones de control
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Botón para guardar posiciones
                    FloatingActionButton.small(
                      onPressed: widget.onSavePositions,
                      backgroundColor: Colors.green,
                      child: const Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Botón para resetear posiciones
                    FloatingActionButton.small(
                      onPressed: resetAllPositions,
                      backgroundColor: Colors.orange,
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Instrucciones (más sutiles)
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Arrastra para organizar • Toca para seleccionar • Doble toca para resetear',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return CustomPaint(
      painter: GridPainter(),
      size: Size.infinite,
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 1.0;

    const gridSize = 20.0;

    // Líneas verticales
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Líneas horizontales
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
