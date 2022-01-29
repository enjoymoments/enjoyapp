import 'package:dartz/dartz.dart';
import 'package:mozin/features/user_action/data/models/user_action_model.dart';
import 'package:custom_utilities/custom_utilities.dart';

abstract class UserActionRepository {
  Future<Either<ResponseDefaultModel, Exception>> addUserAction(
      {required UserActionModel model});
}
