import 'package:dartz/dartz.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/interest_type.dart';

abstract class FavoriteInterestsRepository {
  Future<Either<bool, Exception>> addFavoriteInterest(
    String? interestId,
    String? categoryId,
    String? subCategoryId,
    InterestEnum interestType,
  );

  Future<Either<bool, Exception>> removeFavoriteInterest(String? interestId);

  Future<Either<InterestType, Exception>> getFavoriteInterests();
}
