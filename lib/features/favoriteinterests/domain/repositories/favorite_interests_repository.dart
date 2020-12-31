import 'package:dartz/dartz.dart';
import 'package:mozin/modules/shared/enums.dart';

abstract class FavoriteInterestsRepository {
  Future<Either<bool, Exception>> addFavoriteInterest(
    String interestId,
    InterestEnum interestType,
  );
}
