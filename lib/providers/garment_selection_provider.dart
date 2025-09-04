import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider para manejar la selección múltiple de prendas
class GarmentSelectionNotifier extends StateNotifier<Set<int>> {
  GarmentSelectionNotifier() : super({});

  /// Alternar selección de una prenda
  void toggleSelection(int garmentId) {
    if (state.contains(garmentId)) {
      state = Set.from(state)..remove(garmentId);
    } else {
      state = Set.from(state)..add(garmentId);
    }
  }

  /// Seleccionar una prenda
  void selectGarment(int garmentId) {
    if (!state.contains(garmentId)) {
      state = Set.from(state)..add(garmentId);
    }
  }

  /// Deseleccionar una prenda
  void deselectGarment(int garmentId) {
    if (state.contains(garmentId)) {
      state = Set.from(state)..remove(garmentId);
    }
  }

  /// Limpiar todas las selecciones
  void clearSelection() {
    state = {};
  }

  /// Verificar si una prenda está seleccionada
  bool isSelected(int garmentId) {
    return state.contains(garmentId);
  }

  /// Obtener el número de prendas seleccionadas
  int get selectedCount => state.length;

  /// Verificar si hay prendas seleccionadas
  bool get hasSelection => state.isNotEmpty;
}

/// Provider para el estado de selección de prendas
final garmentSelectionProvider =
    StateNotifierProvider<GarmentSelectionNotifier, Set<int>>((ref) {
  return GarmentSelectionNotifier();
});

/// Provider para obtener el número de prendas seleccionadas
final selectedGarmentsCountProvider = Provider<int>((ref) {
  return ref.watch(garmentSelectionProvider).length;
});

/// Provider para verificar si hay prendas seleccionadas
final hasSelectedGarmentsProvider = Provider<bool>((ref) {
  return ref.watch(garmentSelectionProvider).isNotEmpty;
});
