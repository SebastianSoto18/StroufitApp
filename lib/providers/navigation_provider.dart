import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) {
  return 0; // Default index
});

// Provider to get the total number of pages
final totalPagesProvider = Provider<int>((ref) {
  return 3; // Categories, My Outfits, Generate Outfit
});
