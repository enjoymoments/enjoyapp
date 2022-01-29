import 'package:dartz/dartz.dart';
import 'package:mozin/features/suggestions/data/models/new_suggestions_model.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:custom_utilities/custom_utilities.dart';

abstract class SuggestionsRepository {
  Future<Either<ResponseDefaultModel, Exception>> addSuggestion(
      {required NewSuggestionsModel model});

  Future<Either<ResponseDefaultModel, Exception>> updateSuggestions(
      {required SuggestionsModel model});

  Future<Either<ResponseDefaultModel, Exception>> removeSuggestions(
      {required SuggestionsModel model});
}
