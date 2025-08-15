import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stroufitapp/data/db/daos/garment_dao.dart';
import 'package:stroufitapp/domain/entities/garment_category.dart';
import 'package:stroufitapp/domain/use_cases/garments/createGarmentWithCategory.dart';
import 'package:stroufitapp/domain/use_cases/garments/getGarmentCategoriesByCategory.dart';
import '../data/db/database.dart';
import '../data/db/repositories/garment_repository_impl.dart';

// Provider para la base de datos
final garmentDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// Provider para inicializar la base de datos y asegurar que las tablas existan
final garmentDatabaseInitializerProvider =
    FutureProvider<AppDatabase>((ref) async {
  final database = ref.read(garmentDatabaseProvider);

  try {
    print('PhotoProvider: Initializing database...');
    await database.ensureTablesExist();
    print('PhotoProvider: Database initialization completed');
  } catch (e) {
    print('PhotoProvider: Error during database initialization: $e');
    print('PhotoProvider: Attempting to force fix garments table...');

    // Intentar corregir la tabla garments específicamente
    await database.forceFixGarmentsTable();
    print('PhotoProvider: Force fix completed');
  }

  return database;
});

// Provider para el DAO de garments
final garmentDaoProvider = Provider((ref) {
  final databaseAsync = ref.watch(garmentDatabaseInitializerProvider);
  return databaseAsync.when(
    data: (database) => GarmentDao(database),
    loading: () => throw Exception('Database is still initializing'),
    error: (error, stack) =>
        throw Exception('Failed to initialize database: $error'),
  );
});

// Provider para el repositorio de garments
final garmentRepositoryProvider = Provider((ref) {
  final dao = ref.watch(garmentDaoProvider);
  return GarmentRepositoryImpl(dao);
});

// Provider para el caso de uso de crear garment con categoría
final createGarmentWithCategoryUseCaseProvider = Provider((ref) {
  final repository = ref.watch(garmentRepositoryProvider);
  return CreateGarmentWithCategory(repository);
});

// Provider para el caso de uso de obtener garment categories por categoría
final getGarmentCategoriesByCategoryUseCaseProvider = Provider((ref) {
  final repository = ref.watch(garmentRepositoryProvider);
  return GetGarmentCategoriesByCategory(repository);
});

// Provider para crear un garment y asociarlo a una categoría
final createGarmentWithCategoryProvider =
    FutureProvider.family<void, Map<String, dynamic>>((ref, params) async {
  final useCase = ref.watch(createGarmentWithCategoryUseCaseProvider);

  // Validar que los parámetros no sean null
  final categoryIdParam = params['categoryId'];
  final imagePathParam = params['imagePath'];

  if (categoryIdParam == null) {
    throw Exception('categoryId no puede ser null');
  }

  if (imagePathParam == null) {
    throw Exception('imagePath no puede ser null');
  }

  final categoryId = categoryIdParam as int;
  final imagePath = imagePathParam as String;

  // Validar que imagePath no esté vacío
  if (imagePath.trim().isEmpty) {
    throw Exception('imagePath no puede estar vacío');
  }

  return await useCase.execute(categoryId, imagePath);
});

// Provider para obtener los garment categories de una categoría específica
final garmentCategoriesByCategoryProvider =
    FutureProvider.family<List<GarmentCategoryEntity>, int>(
        (ref, categoryId) async {
  final useCase = ref.watch(getGarmentCategoriesByCategoryUseCaseProvider);
  return await useCase.execute(categoryId);
});

// Provider para invalidar la lista de garment categories cuando se crea uno nuevo
final garmentCategoriesNotifierProvider =
    StateNotifierProvider<GarmentCategoriesNotifier, AsyncValue<void>>((ref) {
  return GarmentCategoriesNotifier(ref);
});

class GarmentCategoriesNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  GarmentCategoriesNotifier(this._ref) : super(const AsyncValue.data(null));

  void invalidateGarmentCategories(int categoryId) {
    _ref.invalidate(garmentCategoriesByCategoryProvider(categoryId));
  }
}
