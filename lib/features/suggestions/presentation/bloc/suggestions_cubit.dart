import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/features/suggestions/domain/repositories/suggestions_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'suggestions_state.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit({
    @required SuggestionsRepository suggestionsRepository,
  })  : assert(suggestionsRepository != null),
        _suggestionsRepository = suggestionsRepository,
        super(SuggestionsState.initial());

  final SuggestionsRepository _suggestionsRepository;

  void getSuggestions() async {
      emit(state.copyWith(
        isLoading: true,
      ));

      Either<List<SuggestionsModel>, Exception> _response =
          await _suggestionsRepository.getSuggestions();

      _response.fold((model) {
        emit(state.copyWith(
          isLoading: false,
          isError: false,
          isSuccess: true,
          suggestions: model,
        ));
      }, (error) {
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          isSuccess: false,
        ));
      });
    
  }
}
