import 'package:dartz/dartz.dart';
import 'package:mozin/features/interest/data/datasources/interest_remote_data_source.dart';
import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/features/interest/domain/repositories/interest_repository.dart';
import 'package:flutter/material.dart';

class InterestRepositoryImpl implements InterestRepository {
  InterestRepositoryImpl({
    @required this.remoteDataSource,
  });

  final InterestRemoteDataSource remoteDataSource;

  @override
  Future<Either<List<CategoriesModel>, Exception>> getCategories() async {
    try {
      var response = await remoteDataSource.getCategories();
      return Left<List<CategoriesModel>, Exception>(response);
    } on dynamic catch (e) {
      return Right<List<CategoriesModel>, Exception>(Exception('error'));
    }
  }
}
