import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/favoriteinterests/data/datasources/favorite_interests_remote_data_source.dart';
import 'package:mozin/features/favoriteinterests/domain/repositories/favorite_interests_repository.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/interest_type.dart';

class FavoriteInterestsRepositoryImpl implements FavoriteInterestsRepository {
  FavoriteInterestsRepositoryImpl({
    @required this.remoteDataSource,
  });

  final FavoriteInterestsRemoteDataSource remoteDataSource;

  @override
  Future<Either<bool, Exception>> addFavoriteInterest(
      String interestId, InterestEnum interestType) async {
    try {
      var response =
          await remoteDataSource.addFavoriteInterest(interestId, interestType);
      return Left<bool, Exception>(response);
    } on dynamic catch (e) {
      return Right<bool, Exception>(e is Exception ? e : Exception('error in add favorite interests'));
    }
  }

  @override
  Future<Either<InterestType, Exception>> getFavoriteInterests() async {
    try {
      var response = await remoteDataSource.getFavoriteInterests();
      return Left<InterestType, Exception>(response);
    } on dynamic catch (e) {
      return Right<InterestType, Exception>(e is Exception ? e : Exception('error in get favorite interests'));
    }
  }

  @override
  Future<Either<bool, Exception>> removeFavoriteInterest(
      String interestId) async {
    try {
      var response = await remoteDataSource.removeFavoriteInterest(interestId);
      return Left<bool, Exception>(response);
    } on dynamic catch (e) {
      return Right<bool, Exception>(e is Exception ? e : Exception('error in remove favorite interests'));
    }
  }
}
