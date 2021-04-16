import 'package:dartz/dartz.dart';

abstract class InviteRepository {
  Future<Either<String, Exception>> generateShareUrl(String userInternalId);
}
