import 'dart:io';
import 'package:drift/drift.dart';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:stroufitapp/data/db/tables/categories_table.dart';
import 'package:stroufitapp/data/db/tables/garments_table.dart';
import 'package:stroufitapp/data/db/tables/garment_categories_table.dart';
import 'package:stroufitapp/data/db/tables/outfits_table.dart';
import 'package:stroufitapp/data/db/tables/outfits_garments_table.dart';

part 'database.g.dart';

@DriftDatabase(
    tables: [Categories, Garments, GarmentCategories, Outfits, OutfitsGarments])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection()) {
    print('Database: AppDatabase constructor called');
    // Llamar a ensureTablesExist automáticamente
    _initializeDatabase();
  }

  /// Método privado para inicializar la base de datos
  void _initializeDatabase() {
    // Usar un Future.microtask para evitar problemas de inicialización
    Future.microtask(() async {
      try {
        print('Database: Starting automatic table verification...');
        await ensureTablesExist();
        print('Database: Automatic table verification completed');
      } catch (e, stackTrace) {
        print('Database: Error during automatic table verification: $e');
        print('Database: Stack trace: $stackTrace');
      }
    });
  }

  @override
  int get schemaVersion =>
      7; // Incrementado de 6 a 7 para agregar outfits y outfits_garments

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        print('Database: Running onCreate migration');
        await m.createAll();
        print('Database: onCreate migration completed');
      },
      onUpgrade: (Migrator m, int from, int to) async {
        print('Database: Running onUpgrade migration from $from to $to');

        if (from < 3) {
          print('Database: Creating new tables for version 3');
          // Crear las nuevas tablas Garments y GarmentCategories
          await m.createTable(garments);
          await m.createTable(garmentCategories);
          print('Database: New tables created successfully');
        }

        if (from < 4) {
          print('Database: Adding isFavorite column to categories table');
          // Agregar columna isFavorite a la tabla categories
          await customStatement(
              'ALTER TABLE categories ADD COLUMN is_favorite BOOLEAN NOT NULL DEFAULT 0');
          print('Database: isFavorite column added successfully');
        }

        if (from < 5) {
          print(
              'Database: Adding scale and position columns to categories table');
          // Agregar columnas de escala y posición a la tabla categories
          await customStatement(
              'ALTER TABLE categories ADD COLUMN scale REAL NOT NULL DEFAULT 1.0');
          await customStatement(
              'ALTER TABLE categories ADD COLUMN position_x REAL NOT NULL DEFAULT 0.0');
          await customStatement(
              'ALTER TABLE categories ADD COLUMN position_y REAL NOT NULL DEFAULT 0.0');
          print('Database: scale and position columns added successfully');
        }

        if (from < 6) {
          print('Database: Adding rotation column to categories table');
          // Agregar columna de rotación a la tabla categories
          await customStatement(
              'ALTER TABLE categories ADD COLUMN rotation REAL NOT NULL DEFAULT 0.0');
          print('Database: rotation column added successfully');
        }

        if (from < 7) {
          print('Database: Creating outfits and outfits_garments tables');
          // Crear tabla outfits
          await customStatement('''
            CREATE TABLE outfits (
              outfit_id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              image_path TEXT NOT NULL,
              created_at INTEGER NOT NULL,
              deleted_at INTEGER,
              is_active INTEGER NOT NULL DEFAULT 1
            )
          ''');

          // Crear tabla outfits_garments
          await customStatement('''
            CREATE TABLE outfits_garments (
              outfit_garment_id INTEGER PRIMARY KEY AUTOINCREMENT,
              outfit_id INTEGER NOT NULL,
              garment_id INTEGER NOT NULL,
              scale REAL NOT NULL DEFAULT 1.0,
              position_x REAL NOT NULL DEFAULT 0.0,
              position_y REAL NOT NULL DEFAULT 0.0,
              rotation REAL NOT NULL DEFAULT 0.0,
              created_at INTEGER NOT NULL,
              deleted_at INTEGER,
              is_active INTEGER NOT NULL DEFAULT 1,
              FOREIGN KEY (outfit_id) REFERENCES outfits (outfit_id),
              FOREIGN KEY (garment_id) REFERENCES garments (garment_id)
            )
          ''');
          print(
              'Database: outfits and outfits_garments tables created successfully');
        }

        print('Database: onUpgrade migration completed');
      },
    );
  }

  /// Método para verificar que todas las tablas existan
  Future<void> ensureTablesExist() async {
    try {
      print('Database: Ensuring all tables exist...');

      // Verificar si las tablas existen ejecutando una consulta simple
      await select(categories).get();
      print('Database: Categories table exists');

      try {
        await select(garments).get();
        print('Database: Garments table exists');

        // Verificar la estructura de la tabla garments
        await _checkGarmentsTableStructure();
      } catch (e) {
        print('Database: Garments table does not exist, creating...');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS garments (
            garment_id INTEGER PRIMARY KEY AUTOINCREMENT,
            image_path TEXT NOT NULL,
            created_at DATETIME NOT NULL,
            deleted_at DATETIME,
            is_active BOOLEAN NOT NULL DEFAULT 1
          )
        ''');
        print('Database: Garments table created');
      }

      try {
        await select(garmentCategories).get();
        print('Database: GarmentCategories table exists');
      } catch (e) {
        print('Database: GarmentCategories table does not exist, creating...');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS garment_categories (
            garment_categories_id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_id INTEGER NOT NULL,
            garment_id INTEGER NOT NULL,
            created_at DATETIME NOT NULL,
            deleted_at DATETIME,
            is_active BOOLEAN NOT NULL DEFAULT 1,
            FOREIGN KEY (category_id) REFERENCES categories (category_id),
            FOREIGN KEY (garment_id) REFERENCES garments (garment_id)
          )
        ''');
        print('Database: GarmentCategories table created');
      }

      print('Database: All tables verified/created successfully');
    } catch (e, stackTrace) {
      print('Database: Error ensuring tables exist: $e');
      print('Database: Stack trace: $stackTrace');

      // Si hay un error crítico, intentar recrear la base de datos
      print('Database: Attempting to recreate database...');
      await _recreateDatabase();
    }
  }

  /// Método para verificar la estructura de la tabla garments
  Future<void> _checkGarmentsTableStructure() async {
    try {
      print('Database: Checking garments table structure...');

      // Obtener información de la tabla
      final result = await customSelect('PRAGMA table_info(garments)').get();
      print('Database: Garments table columns:');
      for (final row in result) {
        final name = row.read<String>('name');
        final type = row.read<String>('type');
        final notNull = row.read<int>('notnull');
        final defaultValue = row.read<String?>('dflt_value');
        print(
            'Database:   Column: $name, Type: $type, NotNull: $notNull, Default: $defaultValue');
      }

      // Verificar si existe la columna 'name' (que no debería existir)
      final hasNameColumn =
          result.any((row) => row.read<String>('name') == 'name');
      if (hasNameColumn) {
        print('Database: WARNING: garments table still has name column!');
        print('Database: Attempting to drop name column...');
        await _dropNameColumnFromGarments();
      } else {
        print('Database: Garments table structure is correct (no name column)');
      }
    } catch (e, stackTrace) {
      print('Database: Error checking garments table structure: $e');
      print('Database: Stack trace: $stackTrace');
    }
  }

  /// Método para eliminar la columna name de la tabla garments
  Future<void> _dropNameColumnFromGarments() async {
    try {
      print('Database: Dropping name column from garments table...');

      // En SQLite no se puede eliminar columnas directamente, así que recreamos la tabla
      await customStatement('''
        CREATE TABLE garments_new (
          garment_id INTEGER PRIMARY KEY AUTOINCREMENT,
          image_path TEXT NOT NULL,
          created_at DATETIME NOT NULL,
          deleted_at DATETIME,
          is_active BOOLEAN NOT NULL DEFAULT 1
        )
      ''');

      // Copiar datos existentes (excluyendo la columna name)
      await customStatement('''
        INSERT INTO garments_new (garment_id, image_path, created_at, deleted_at, is_active)
        SELECT garment_id, image_path, created_at, deleted_at, is_active FROM garments
      ''');

      // Eliminar tabla antigua y renombrar la nueva
      await customStatement('DROP TABLE garments');
      await customStatement('ALTER TABLE garments_new RENAME TO garments');

      print('Database: Name column successfully removed from garments table');
    } catch (e, stackTrace) {
      print('Database: Error dropping name column: $e');
      print('Database: Stack trace: $stackTrace');
    }
  }

  /// Método para recrear la base de datos desde cero
  Future<void> _recreateDatabase() async {
    try {
      print('Database: Recreating database...');

      // Cerrar la conexión actual
      await close();

      // Eliminar el archivo de base de datos
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/app.sqlite');
      if (await file.exists()) {
        await file.delete();
        print('Database: Old database file deleted');
      }

      // Crear nueva base de datos
      await customStatement('''
        CREATE TABLE IF NOT EXISTS categories (
          category_id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          created_at DATETIME NOT NULL,
          deleted_at DATETIME,
          is_active BOOLEAN NOT NULL DEFAULT 1,
          is_favorite BOOLEAN NOT NULL DEFAULT 0
        )
      ''');

      await customStatement('''
        CREATE TABLE IF NOT EXISTS garments (
          garment_id INTEGER PRIMARY KEY AUTOINCREMENT,
          image_path TEXT NOT NULL,
          created_at DATETIME NOT NULL,
          deleted_at DATETIME,
          is_active BOOLEAN NOT NULL DEFAULT 1
        )
      ''');

      await customStatement('''
        CREATE TABLE IF NOT EXISTS garment_categories (
          garment_categories_id INTEGER PRIMARY KEY AUTOINCREMENT,
          category_id INTEGER NOT NULL,
          garment_id INTEGER NOT NULL,
          created_at DATETIME NOT NULL,
          deleted_at DATETIME,
          is_active BOOLEAN NOT NULL DEFAULT 1,
          FOREIGN KEY (category_id) REFERENCES categories (category_id),
          FOREIGN KEY (garment_id) REFERENCES garments (garment_id)
        )
      ''');

      print('Database: Database recreated successfully');

      // Verificar que las tablas se crearon correctamente
      await _checkGarmentsTableStructure();
    } catch (e, stackTrace) {
      print('Database: Error recreating database: $e');
      print('Database: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Método público para forzar la corrección de la tabla garments
  Future<void> forceFixGarmentsTable() async {
    try {
      print('Database: Force fixing garments table...');

      // Verificar si la tabla existe
      try {
        await select(garments).get();
        print('Database: Garments table exists, checking structure...');

        // Verificar estructura y corregir si es necesario
        await _checkGarmentsTableStructure();
      } catch (e) {
        print('Database: Garments table does not exist, creating...');
        await customStatement('''
          CREATE TABLE IF NOT EXISTS garments (
            garment_id INTEGER PRIMARY KEY AUTOINCREMENT,
            image_path TEXT NOT NULL,
            created_at DATETIME NOT NULL,
            deleted_at DATETIME,
            is_active BOOLEAN NOT NULL DEFAULT 1
          )
        ''');
        print('Database: Garments table created successfully');
      }

      print('Database: Garments table fix completed');
    } catch (e, stackTrace) {
      print('Database: Error force fixing garments table: $e');
      print('Database: Stack trace: $stackTrace');

      // Si hay un error crítico, recrear la base de datos
      print(
          'Database: Attempting to recreate database due to critical error...');
      await _recreateDatabase();
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    try {
      print('Database: Getting application documents directory');
      final dir = await getApplicationDocumentsDirectory();
      print('Database: Documents directory: ${dir.path}');

      final file = File(p.join(dir.path, 'app.sqlite'));
      print('Database: Database file path: ${file.path}');

      final database = NativeDatabase(file);
      print('Database: NativeDatabase created successfully');

      return database;
    } catch (e, stackTrace) {
      print('Database: Error opening connection: $e');
      print('Database: Stack trace: $stackTrace');
      rethrow;
    }
  });
}

// DAO para outfits
@DriftAccessor(tables: [Outfits, OutfitsGarments, Garments])
class OutfitsDao extends DatabaseAccessor<AppDatabase> with _$OutfitsDaoMixin {
  OutfitsDao(AppDatabase db) : super(db);

  /// Obtiene todos los outfits activos
  Future<List<Outfit>> getAllOutfits() async {
    try {
      print('OutfitsDAO: Getting all outfits');
      final outfitsList = await (select(outfits)
            ..where((tbl) => tbl.isActive.equals(true))
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
          .get();
      print('OutfitsDAO: Found ${outfitsList.length} outfits');
      return outfitsList;
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error getting outfits: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Obtiene un outfit por ID con sus prendas
  Future<Outfit?> getOutfitById(int outfitId) async {
    try {
      print('OutfitsDAO: Getting outfit by ID: $outfitId');
      final outfit = await (select(outfits)
            ..where((tbl) =>
                tbl.outfitId.equals(outfitId) & tbl.isActive.equals(true)))
          .getSingleOrNull();
      print('OutfitsDAO: Found outfit: ${outfit?.name}');
      return outfit;
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error getting outfit by ID: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Obtiene las prendas de un outfit
  Future<List<OutfitsGarment>> getOutfitGarments(int outfitId) async {
    try {
      print('OutfitsDAO: Getting garments for outfit: $outfitId');
      final outfitGarments = await (select(outfitsGarments)
            ..where((tbl) =>
                tbl.outfitId.equals(outfitId) & tbl.isActive.equals(true)))
          .get();
      print('OutfitsDAO: Found ${outfitGarments.length} garments for outfit');
      return outfitGarments;
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error getting outfit garments: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Inserta un nuevo outfit
  Future<int> insertOutfit(OutfitsCompanion outfit) async {
    try {
      print('OutfitsDAO: Inserting outfit: ${outfit.name.value}');
      final outfitId = await into(outfits).insert(outfit);
      print('OutfitsDAO: Outfit inserted with ID: $outfitId');
      return outfitId;
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error inserting outfit: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Inserta prendas para un outfit
  Future<void> insertOutfitGarments(
      List<OutfitsGarmentsCompanion> outfitGarments) async {
    try {
      print('OutfitsDAO: Inserting ${outfitGarments.length} outfit garments');
      await batch((batch) {
        batch.insertAll(outfitsGarments, outfitGarments);
      });
      print('OutfitsDAO: Outfit garments inserted successfully');
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error inserting outfit garments: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Actualiza un outfit
  Future<void> updateOutfit(OutfitsCompanion outfit) async {
    try {
      print('OutfitsDAO: Updating outfit: ${outfit.outfitId.value}');
      await (update(outfits)
            ..where((tbl) => tbl.outfitId.equals(outfit.outfitId.value!)))
          .write(outfit);
      print('OutfitsDAO: Outfit updated successfully');
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error updating outfit: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Elimina un outfit (soft delete)
  Future<void> softDeleteOutfit(int outfitId) async {
    try {
      print('OutfitsDAO: Soft deleting outfit: $outfitId');
      await (update(outfits)..where((tbl) => tbl.outfitId.equals(outfitId)))
          .write(OutfitsCompanion(
        isActive: const Value(false),
        deletedAt: Value(DateTime.now()),
      ));

      // También eliminar las prendas del outfit
      await (update(outfitsGarments)
            ..where((tbl) => tbl.outfitId.equals(outfitId)))
          .write(OutfitsGarmentsCompanion(
        isActive: const Value(false),
        deletedAt: Value(DateTime.now()),
      ));

      print('OutfitsDAO: Outfit soft deleted successfully');
    } catch (e, stackTrace) {
      print('OutfitsDAO: Error soft deleting outfit: $e');
      print('OutfitsDAO: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
