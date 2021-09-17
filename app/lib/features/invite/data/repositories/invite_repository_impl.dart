import 'package:dartz/dartz.dart';
import 'package:mozin/features/invite/data/datasources/invite_remote_data_source.dart';
import 'package:mozin/features/invite/data/models/user_sync_info_model.dart';
import 'package:mozin/features/invite/domain/repositories/invite_repository.dart';
import 'package:flutter/material.dart';
import 'package:mozin/modules/shared/general/enums.dart';

class InviteRepositoryImpl implements InviteRepository {
  InviteRepositoryImpl({
    required this.remoteDataSource,
  });

  final InviteRemoteDataSource? remoteDataSource;

  @override
  Future<Either<String?, Exception>> generateShareUrl(
      DynamicLinksTypeEnum action, String? userInternalId) async {
    try {
      var response =
          await remoteDataSource!.generateShareUrl(action, userInternalId);
      return Left<String?, Exception>(response);
    } on dynamic catch (e) {
      return Right<String, Exception>(Exception('error'));
    }
  }

  @override
  Future<Either<UserSyncInfoModel, Exception>> getUserSyncInfo(
      String userSyncInfoId) async {
    try {
      var response = await remoteDataSource!.getUserSyncInfo(userSyncInfoId);
      return Left<UserSyncInfoModel, Exception>(response);
    } on dynamic catch (e) {
      return Right<UserSyncInfoModel, Exception>(
          Exception((e is Exception) ? e : Exception(e.toString())));
    }
  }
}
