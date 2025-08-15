import 'package:drift/drift.dart';
import '../../../data/db/repositories/garment_repository_impl.dart';
import '../../../data/db/database.dart';

class CreateGarment {
  final GarmentRepositoryImpl _garmentRepository;
  CreateGarment(this._garmentRepository);

  Future<int> execute(String imagePath) async {
    // Eliminado el parámetro name
    try {
      print('CreateGarment: Creating garment with imagePath: $imagePath');
      print('CreateGarment: imagePath type: ${imagePath.runtimeType}');
      print('CreateGarment: imagePath is null: ${imagePath == null}');

      final garment = GarmentsCompanion(
        // Eliminado el campo name
        imagePath: Value(imagePath),
        createdAt: Value(DateTime.now()),
        isActive: Value(true),
      );

      print('CreateGarment: Garment companion created successfully');
      print('CreateGarment: garment.imagePath: ${garment.imagePath}');
      print(
          'CreateGarment: garment.imagePath.value: ${garment.imagePath.value}');
      print(
          'CreateGarment: garment.imagePath.runtimeType: ${garment.imagePath.runtimeType}');

      final garmentId = await _garmentRepository.insertGarment(garment);
      print('CreateGarment: Garment created successfully with ID: $garmentId');
      return garmentId;
    } catch (e, stackTrace) {
      print('CreateGarment: Error creating garment: $e');
      print('CreateGarment: Stack trace: $stackTrace');
      rethrow;
    }
  }
}
