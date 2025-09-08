import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/domain/entities/category.dart';
import 'package:stroufitapp/domain/entities/garment_category.dart';
import 'package:stroufitapp/domain/entities/garment.dart';
import 'package:stroufitapp/domain/use_cases/outfits/cachedGenerateOutfit.dart';
import 'package:stroufitapp/providers/category_provider.dart';
import 'package:stroufitapp/providers/garment_provider.dart';
import 'package:stroufitapp/presentation/widgets/draggable_outfit_container.dart';
import 'package:stroufitapp/presentation/widgets/category_bottom_sheet.dart';

class GenerateOufit extends ConsumerStatefulWidget {
  const GenerateOufit({super.key});

  @override
  ConsumerState<GenerateOufit> createState() => _GenerateOufitState();
}

class _GenerateOufitState extends ConsumerState<GenerateOufit>
    with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Set<int> _selectedCategories = {};
  List<GarmentCategoryEntity> _generatedOutfit = [];
  List<GarmentCategoryEntity> _previousOutfit = [];
  bool _isGenerating = false;
  final Map<int, Map<String, double>> _categoryPositions = {};
  final Map<int, bool> _lockedGarments = {};
  Timer? _saveTimer;
  List<CategoryEntity>? _categories;
  int _resetCounter = 0; // Counter to force widget recreation on reset

  @override
  void initState() {
    super.initState();
    // Add observer to detect app state changes
    WidgetsBinding.instance.addObserver(this);
    // Pre-select favorite categories when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preSelectFavorites();
      // Open the drawer automatically
      _scaffoldKey.currentState?.openDrawer();
    });
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    // Remove observer
    WidgetsBinding.instance.removeObserver(this);
    // Guardar posiciones automáticamente al salir de la pantalla
    _savePositions();
    super.dispose();
  }

  void _preSelectFavorites() {
    final categories = ref.read(categoryListProvider).value;
    if (categories != null && _categories == null) {
      setState(() {
        _categories = categories;
        _selectedCategories = categories
            .where((category) => category.isFavorite)
            .map((category) => category.categoryId)
            .toSet();

        // Solo cargar posiciones guardadas si no hay posiciones en memoria
        if (_categoryPositions.isEmpty) {
          for (final category in categories) {
            print(
                'Loading saved position for category ${category.categoryId}: scale=${category.scale}, x=${category.positionX}, y=${category.positionY}, rotation=${category.rotation}');
            _categoryPositions[category.categoryId] = {
              'scale': category.scale,
              'positionX': category.positionX,
              'positionY': category.positionY,
              'rotation': category.rotation,
            };
          }
          print('Loaded _categoryPositions: $_categoryPositions');
        } else {
          print('Keeping existing _categoryPositions: $_categoryPositions');
        }
      });
    }
  }

  void _savePositions() {
    if (!mounted) return;
    print('Saving positions: $_categoryPositions');

    final updatePositionUseCase =
        ref.read(updateCategoryPositionUseCaseProvider);

    for (final entry in _categoryPositions.entries) {
      final categoryId = entry.key;
      final position = entry.value;

      print(
          'Saving category $categoryId: scale=${position['scale']}, x=${position['positionX']}, y=${position['positionY']}, rotation=${position['rotation']}');

      updatePositionUseCase.execute(
        categoryId,
        position['scale']!,
        position['positionX']!,
        position['positionY']!,
        position['rotation']!,
      );
    }
  }

  void _onPositionChanged(int categoryId, double scale, double positionX,
      double positionY, double rotation) {
    print(
        'Position changed - Category: $categoryId, Scale: $scale, X: $positionX, Y: $positionY, Rotation: $rotation');

    setState(() {
      _categoryPositions[categoryId] = {
        'scale': scale,
        'positionX': positionX,
        'positionY': positionY,
        'rotation': rotation,
      };
    });

    print('Updated _categoryPositions: $_categoryPositions');

    // Guardar automáticamente después de 2 segundos de inactividad
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 2), () {
      _savePositions();
    });
  }

  void _onToggleLock(int categoryId, bool isLocked) {
    print(
        'Before toggle - Category: $categoryId, Current state: ${_lockedGarments[categoryId]}, New state: $isLocked');
    setState(() {
      _lockedGarments[categoryId] = isLocked;
    });
    print('After toggle - Category: $categoryId, Locked: $isLocked');
    print('Current locked garments: $_lockedGarments');
  }

  void _onGarmentSelected(String imagePath) {
    // Encontrar la categoría de la prenda seleccionada
    final garmentCategory = _generatedOutfit.firstWhere(
      (garment) => garment.garment.imagePath == imagePath,
      orElse: () => _generatedOutfit.first,
    );

    // Mostrar el CategoryBottomSheet en modo solo lectura
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CategoryBottomSheet(
        category: _categories!.firstWhere(
          (cat) => cat.categoryId == garmentCategory.categoryId,
        ),
        isReadOnly: true,
        onGarmentSelected: (selectedImagePath) {
          // Reemplazar la prenda actual con la seleccionada
          _replaceGarment(garmentCategory.categoryId, selectedImagePath);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _replaceGarment(int categoryId, String newImagePath) {
    print(
        'Replacing garment for category $categoryId with new path: $newImagePath');

    // Encontrar el índice de la prenda actual en _generatedOutfit
    final currentIndex = _generatedOutfit.indexWhere(
      (garment) => garment.categoryId == categoryId,
    );

    if (currentIndex == -1) {
      print('Error: Category $categoryId not found in generated outfit');
      return;
    }

    // Obtener la prenda actual para mantener las posiciones guardadas
    final currentGarment = _generatedOutfit[currentIndex];

    // Crear una nueva GarmentEntity con la nueva imagen
    final newGarment = GarmentEntity(
      garmentId: currentGarment.garment.garmentId,
      imagePath: newImagePath,
      createdAt: currentGarment.garment.createdAt,
      isActive: currentGarment.garment.isActive,
      deletedAt: currentGarment.garment.deletedAt,
    );

    // Crear una nueva GarmentCategoryEntity con la nueva prenda
    final newGarmentCategory = GarmentCategoryEntity(
      garmentCategoriesId: currentGarment.garmentCategoriesId,
      categoryId: currentGarment.categoryId,
      garmentId: currentGarment.garmentId,
      createdAt: currentGarment.createdAt,
      isActive: currentGarment.isActive,
      deletedAt: currentGarment.deletedAt,
      garment: newGarment,
    );

    // Actualizar la lista _generatedOutfit
    setState(() {
      _generatedOutfit[currentIndex] = newGarmentCategory;

      // Incrementar el contador de reset para forzar recreación del widget
      _resetCounter++;

      // Si hay posiciones guardadas para esta categoría, mantenerlas
      if (_categoryPositions.containsKey(categoryId)) {
        // Las posiciones ya están guardadas, no necesitamos hacer nada más
        print('Maintaining saved positions for category $categoryId');
      } else {
        // Si no hay posiciones guardadas, usar las posiciones por defecto
        _categoryPositions[categoryId] = {
          'scale': 1.0,
          'positionX': 0.0,
          'positionY': 0.0,
          'rotation': 0.0,
        };
        print('Using default positions for category $categoryId');
      }
    });

    print('Garment replaced successfully for category $categoryId');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // Guardar posiciones cuando la app pasa a segundo plano
      _savePositions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildCategoryDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header con botón de menú
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                  Expanded(
                    child: Text(
                      'Generar Outfit',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  if (_selectedCategories.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear_all),
                      onPressed: _clearSelection,
                      tooltip: 'Limpiar selección',
                    ),
                ],
              ),
              const SizedBox(height: 20),

              /// Contenido principal
              Expanded(
                child: _buildMainContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Seleccionar Categorías',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          Expanded(
            child: _categories == null
                ? const Center(child: CircularProgressIndicator())
                : _buildCategoryList(_categories!),
          ),
          if (_selectedCategories.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: const Border(top: BorderSide(color: Colors.grey)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${_selectedCategories.length} categoría${_selectedCategories.length == 1 ? '' : 's'} seleccionada${_selectedCategories.length == 1 ? '' : 's'}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _generateOutfit,
                        icon:
                            const Icon(Icons.auto_awesome, color: Colors.white),
                        label: const Text('Generar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _clearSelection,
                        icon: const Icon(Icons.clear),
                        label: const Text('Limpiar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(List<CategoryEntity> categories) {
    if (categories.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.category_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No hay categorías disponibles',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = _selectedCategories.contains(category.categoryId);
        final isFavorite = category.isFavorite;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading: GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedCategories.remove(category.categoryId);
                  } else {
                    _selectedCategories.add(category.categoryId);
                  }
                });
              },
              child: Icon(
                isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isSelected ? Colors.blue : Colors.grey,
                size: 24,
              ),
            ),
            title: Row(
              children: [
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight:
                            isFavorite ? FontWeight.bold : FontWeight.normal,
                      ),
                ),
                if (isFavorite) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 16,
                  ),
                ],
              ],
            ),
            subtitle: isFavorite
                ? Text(
                    'Categoría favorita',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.red,
                        ),
                  )
                : null,
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedCategories.remove(category.categoryId);
                } else {
                  _selectedCategories.add(category.categoryId);
                }
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        /// Botón de generar (fijo, sin animación)
        if (_selectedCategories.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _isGenerating ? null : _generateOutfit,
              icon: _isGenerating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Icon(Icons.auto_awesome, color: Colors.white),
              label: Text(_isGenerating ? 'Generando...' : 'Generar Outfit'),
            ),
          ),
        const SizedBox(height: 16),

        /// Contenido principal con animación
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 650),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0.0,
                child: child,
              ),
            ),
            child: _buildContentState(),
          ),
        ),
      ],
    );
  }

  Widget _buildContentState() {
    if (_isGenerating) {
      return Center(
        key: const ValueKey('generating'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(
              'Generando tu outfit...',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Esto puede tomar unos segundos',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (_generatedOutfit.isNotEmpty) {
      return _buildDraggableOutfit();
    }

    if (_selectedCategories.isEmpty) {
      return Center(
        key: const ValueKey('empty'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 120,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'Selecciona categorías para generar tu outfit',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Abre el menú lateral para comenzar',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.white),
              label: const Text('Abrir Menú'),
            ),
          ],
        ),
      );
    }

    return Center(
      key: ValueKey(_selectedCategories.length),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 120,
            color: Colors.green[400],
          ),
          const SizedBox(height: 24),
          Text(
            '¡Perfecto! Tienes ${_selectedCategories.length} categoría${_selectedCategories.length == 1 ? '' : 's'} seleccionada${_selectedCategories.length == 1 ? '' : 's'}',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Toca "Generar" para crear tu outfit',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableOutfit() {
    return DraggableOutfitContainer(
      key: ValueKey(
          'outfit_${_generatedOutfit.length}_${_resetCounter}'), // Unique key for reset
      garments: _generatedOutfit,
      savedPositions: _categoryPositions,
      lockedGarments: _lockedGarments,
      onGarmentTapped: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prenda seleccionada'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      onGarmentDoubleTapped: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prenda bloqueada/desbloqueada'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      onResetLayout: () async {
        // Resetear todas las posiciones a valores por defecto
        setState(() {
          _resetCounter++; // Incrementar contador para forzar recreación
          for (final garment in _generatedOutfit) {
            _categoryPositions[garment.categoryId] = {
              'scale': 1.0,
              'positionX': 0.0,
              'positionY': 0.0,
              'rotation': 0.0,
            };
          }
        });

        // Guardar las posiciones reseteadas en la base de datos
        try {
          final updatePositionUseCase =
              ref.read(updateCategoryPositionUseCaseProvider);

          for (final garment in _generatedOutfit) {
            await updatePositionUseCase.execute(
              garment.categoryId,
              1.0, // scale
              0.0, // positionX
              0.0, // positionY
              0.0, // rotation
            );
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Layout reseteado y guardado'),
              duration: Duration(seconds: 2),
            ),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al guardar reset: $e'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      onSavePositions: () {
        _savePositions();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Posiciones guardadas'),
            duration: Duration(seconds: 1),
          ),
        );
      },
      onPositionChanged: _onPositionChanged,
      onToggleLock: _onToggleLock,
      onGarmentSelected: _onGarmentSelected, // Add garment selection callback
    );
  }

  void _clearSelection() {
    setState(() {
      _selectedCategories.clear();
      _generatedOutfit.clear();
      _previousOutfit.clear();
    });
  }

  Future<List<GarmentCategoryEntity>> _generateDifferentOutfit(
      CachedGenerateOutfit generateOutfit) async {
    const maxAttempts = 10; // Máximo de intentos para evitar bucle infinito
    int attempts = 0;

    print('Generating outfit with locked garments: $_lockedGarments');
    print('Selected categories: $_selectedCategories');

    // Crear lista de categorías no bloqueadas
    final unlockedCategories = _selectedCategories
        .where((categoryId) => !(_lockedGarments[categoryId] ?? false))
        .toList();

    print('Unlocked categories: $unlockedCategories');

    // Si todas las categorías están bloqueadas, devolver el outfit actual
    if (unlockedCategories.isEmpty) {
      print('All categories are locked, returning current outfit');
      return _generatedOutfit;
    }

    while (attempts < maxAttempts) {
      final outfit = await generateOutfit.execute(unlockedCategories);

      // Si no hay outfit anterior, devolver el primero generado
      if (_generatedOutfit.isEmpty) {
        return outfit;
      }

      // Crear outfit final combinando prendas bloqueadas con nuevas
      final finalOutfit = <GarmentCategoryEntity>[];

      // Agregar prendas bloqueadas del outfit actual
      for (final garment in _generatedOutfit) {
        if (_lockedGarments[garment.categoryId] == true) {
          print('Keeping locked garment: ${garment.categoryId}');
          finalOutfit.add(garment);
        }
      }

      // Agregar nuevas prendas generadas
      print('Adding new garments: ${outfit.length}');
      finalOutfit.addAll(outfit);

      print('Final outfit has ${finalOutfit.length} garments');

      // Verificar si el nuevo outfit es diferente al anterior
      if (_isOutfitDifferent(finalOutfit, _generatedOutfit)) {
        return finalOutfit;
      }

      attempts++;
    }

    // Si después de varios intentos no se encuentra uno diferente, devolver el último generado
    final lastOutfit = await generateOutfit.execute(unlockedCategories);
    final finalOutfit = <GarmentCategoryEntity>[];

    // Agregar prendas bloqueadas del outfit actual
    for (final garment in _generatedOutfit) {
      if (_lockedGarments[garment.categoryId] == true) {
        finalOutfit.add(garment);
      }
    }

    // Agregar nuevas prendas generadas
    finalOutfit.addAll(lastOutfit);

    return finalOutfit;
  }

  bool _isOutfitDifferent(List<GarmentCategoryEntity> newOutfit,
      List<GarmentCategoryEntity> previousOutfit) {
    if (newOutfit.length != previousOutfit.length) {
      return true; // Diferente número de prendas
    }

    // Verificar si todas las prendas son diferentes
    for (int i = 0; i < newOutfit.length; i++) {
      final newGarment = newOutfit[i];
      final previousGarment = previousOutfit[i];

      // Si alguna prenda es igual, el outfit no es completamente diferente
      if (newGarment.garmentId == previousGarment.garmentId) {
        return false;
      }
    }

    return true; // Todas las prendas son diferentes
  }

  Future<void> _generateOutfit() async {
    if (_selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Selecciona al menos una categoría'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Cerrar el panel lateral automáticamente
    if (_scaffoldKey.currentState?.isDrawerOpen == true) {
      Navigator.of(context).pop();
    }

    setState(() {
      _isGenerating = true;
    });

    try {
      final generateOutfit = ref.read(cachedGenerateOutfitUseCaseProvider);
      final outfit = await _generateDifferentOutfit(generateOutfit);

      if (mounted) {
        // Cancelar timer pendiente
        _saveTimer?.cancel();

        setState(() {
          _previousOutfit =
              List.from(_generatedOutfit); // Guardar el outfit anterior
          _generatedOutfit = outfit;
          _isGenerating = false;
        });

        print('Outfit generated. Locked garments: $_lockedGarments');

        // Guardar posiciones después de generar outfit
        _savePositions();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '¡Outfit generado exitosamente! Se encontraron ${outfit.length} prendas.',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al generar outfit: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
