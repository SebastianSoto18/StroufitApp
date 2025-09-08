import 'package:stroufitapp/domain/repositories/category_repository.dart';

class ToggleFavorite {
  final CategoryRepository _repository;

  ToggleFavorite(this._repository);

  Future<void> execute(int categoryId, bool isFavorite) async {
    await _repository.toggleFavorite(categoryId, isFavorite);
  }
}
