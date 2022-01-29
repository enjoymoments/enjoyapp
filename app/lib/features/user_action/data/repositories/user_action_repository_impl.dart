import 'package:dartz/dartz.dart';
import 'package:mozin/features/user_action/data/datasources/user_action_remote_data_source.dart';
import 'package:mozin/features/user_action/data/models/user_action_model.dart';
import 'package:mozin/features/user_action/domain/repositories/user_action_repository.dart';
import 'package:custom_utilities/custom_utilities.dart';

class UserActionRepositoryImpl implements UserActionRepository {
  UserActionRepositoryImpl({
    required this.remoteDataSource,
  });

  final UserActionRemoteDataSource? remoteDataSource;

  @override
  Future<Either<ResponseDefaultModel, Exception>> addUserAction(
      {UserActionModel? model}) async {
    try {
      var response = await remoteDataSource!.addUserAction(model);
      return Left<ResponseDefaultModel, Exception>(response);
    } on dynamic catch (e) {
      return Right<ResponseDefaultModel, Exception>(
          (e is Exception) ? e : Exception(e.toString()));
    }
  }
}
