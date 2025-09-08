import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/core/services/garment_cache_service.dart';
import 'package:stroufitapp/data/db/daos/garment_dao.dart';
import 'package:stroufitapp/data/db/repositories/garment_repository_impl.dart';
import 'package:stroufitapp/data/db/repositories/cached_garment_repository_impl.dart';
import 'package:stroufitapp/domain/use_cases/garments/getGarmentCategoriesByCategory.dart';
import 'package:stroufitapp/domain/use_cases/outfits/generateOutfit.dart';
import 'package:stroufitapp/domain/use_cases/outfits/cachedGenerateOutfit.dart';

import 'category_provider.dart';

final garmentDaoProvider = Provider((ref) {
  final database = ref.watch(databaseProvider);
  return GarmentDao(database);
});

final garmentRepositoryProvider = Provider((ref) {
  final dao = ref.watch(garmentDaoProvider);
  return GarmentRepositoryImpl(dao);
});

final getGarmentCategoriesByCategoryUseCaseProvider = Provider((ref) {
  final repository = ref.watch(garmentRepositoryProvider);
  return GetGarmentCategoriesByCategory(repository);
});

final generateOutfitUseCaseProvider = Provider((ref) {
  final repository = ref.watch(garmentRepositoryProvider);
  return GenerateOutfit(repository);
});

// Cache service provider
final garmentCacheServiceProvider = Provider((ref) {
  return GarmentCacheService();
});

// Cached repository provider
final cachedGarmentRepositoryProvider = Provider((ref) {
  final dao = ref.watch(garmentDaoProvider);
  final cacheService = ref.watch(garmentCacheServiceProvider);
  return CachedGarmentRepositoryImpl(dao, cacheService);
});

// Cached generate outfit use case provider
final cachedGenerateOutfitUseCaseProvider = Provider((ref) {
  final repository = ref.watch(garmentRepositoryProvider);
  final cacheService = ref.watch(garmentCacheServiceProvider);
  return CachedGenerateOutfit(repository, cacheService);
});
