import 'package:dartz/dartz.dart';
import 'package:mozin/features/suggestions/data/datasources/suggestions_remote_data_source.dart';
import 'package:mozin/features/suggestions/data/models/new_suggestions_model.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/features/suggestions/domain/repositories/suggestions_repository.dart';
import 'package:mozin/modules/shared/general/models/response_default_model.dart';

class SuggestionsRepositoryImpl implements SuggestionsRepository {
  SuggestionsRepositoryImpl({
    required this.remoteDataSource,
  });

  final SuggestionsRemoteDataSource? remoteDataSource;

  @override
  Future<Either<ResponseDefaultModel, Exception>> addSuggestion(
      {NewSuggestionsModel? model}) async {
    try {
      var response = await remoteDataSource!.addSuggestion(model);
      return Left<ResponseDefaultModel, Exception>(response);
    } on dynamic catch (e) {
      return Right<ResponseDefaultModel, Exception>(
          (e is Exception) ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Either<ResponseDefaultModel, Exception>> removeSuggestions(
      {SuggestionsModel? model}) async {
    try {
      var response = await remoteDataSource!.removeSuggestions(model);
      return Left<ResponseDefaultModel, Exception>(response);
    } on dynamic catch (e) {
      return Right<ResponseDefaultModel, Exception>(
          (e is Exception) ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Either<ResponseDefaultModel, Exception>> updateSuggestions(
      {SuggestionsModel? model}) async {
    try {
      var response = await remoteDataSource!.updateSuggestions(model);
      return Left<ResponseDefaultModel, Exception>(response);
    } on dynamic catch (e) {
      return Right<ResponseDefaultModel, Exception>(
          (e is Exception) ? e : Exception(e.toString()));
    }
  }
}
