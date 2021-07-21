import 'package:mozin/features/suggestions/data/datasources/suggestions_remote_data_source.dart';
import 'package:mozin/features/suggestions/domain/repositories/suggestions_repository.dart';
import 'package:flutter/material.dart';

class SuggestionsRepositoryImpl implements SuggestionsRepository {
  SuggestionsRepositoryImpl({
    @required this.remoteDataSource,
  });

  final SuggestionsRemoteDataSource remoteDataSource;
}
