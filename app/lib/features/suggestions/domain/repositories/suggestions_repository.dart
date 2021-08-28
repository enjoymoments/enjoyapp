import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/modules/shared/general/models/response_default_model.dart';

abstract class SuggestionsRepository {
  Future<Either<ResponseDefaultModel, Exception>> addSuggestion({
    @required SuggestionsModel model
  });

  Future<Either<ResponseDefaultModel, Exception>> updateSuggestions({
    @required SuggestionsModel model
  });

  Future<Either<ResponseDefaultModel, Exception>> removeSuggestions({
    @required SuggestionsModel model
  });
}
