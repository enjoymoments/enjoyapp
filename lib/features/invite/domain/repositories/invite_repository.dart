import 'package:dartz/dartz.dart';
import 'package:mozin/modules/shared/general/enums.dart';

abstract class InviteRepository {
  Future<Either<String, Exception>> generateShareUrl(DynamicLinksTypeEnum action, String userInternalId);
}
