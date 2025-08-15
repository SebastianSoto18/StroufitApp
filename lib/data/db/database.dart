import 'dart:io';
import 'package:drift/drift.dart';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:stroufitapp/data/db/tables/categories_table.dart';
import 'package:stroufitapp/data/db/tables/garments_table.dart';
import 'package:stroufitapp/data/db/tables/garment_categories_table.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Categories, Garments, GarmentCategories])
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
  int get schemaVersion => 3; // Incrementado de 2 a 3 para forzar migración

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
          is_active BOOLEAN NOT NULL DEFAULT 1
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
