import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/features/suggestions/domain/repositories/suggestions_repository.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'suggestions_state.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit({
    required SuggestionsRepository suggestionsRepository,
  })  : assert(suggestionsRepository != null),
        _suggestionsRepository = suggestionsRepository,
        super(SuggestionsState.initial());

  final SuggestionsRepository _suggestionsRepository;

  void remove(String? id) {
    _suggestionsRepository.removeSuggestions(
        model: SuggestionsModel(id:id));
  }

  void save(String title, String description) {
    _suggestionsRepository.addSuggestion(
        model: SuggestionsModel(title: title, description: description));

    emit(state.copyWith(
      isSuccess: true,
    ));
  }
}
