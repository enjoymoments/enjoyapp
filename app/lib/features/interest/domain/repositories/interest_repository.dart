import 'package:dartz/dartz.dart';
import 'package:mozin/features/interest/data/models/categories_model.dart';

abstract class InterestRepository {
  Future<Either<List<CategoriesModel>, Exception>> getCategories();
}
