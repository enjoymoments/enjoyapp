import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/features/interest/domain/repositories/interest_repository.dart';
import 'package:mozin/modules/shared/filter_choosed/filter_choosed_wrapper.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'interest_event.dart';
part 'interest_state.dart';

class InterestBloc extends Bloc<InterestEvent, InterestState> {
  InterestBloc({
    @required InterestRepository interestRepository,
    @required FilterChoosedWrapper filterChoosedWrapper,
  })  : assert(interestRepository != null),
        _interestRepository = interestRepository,
        assert(filterChoosedWrapper != null),
        _filterChoosedWrapper = filterChoosedWrapper,
        super(InterestState.initial());

  final InterestRepository _interestRepository;
  final FilterChoosedWrapper _filterChoosedWrapper;

  @override
  Stream<InterestState> mapEventToState(
    InterestEvent event,
  ) async* {
    if (event is LoadCategories) {
      yield* mapLoadCategoriesToState();
    } else if (event is SelectCategorie) {
      yield* mapSelectCategorieToState(event);
    }
  }

  Stream<InterestState> mapSelectCategorieToState(
      SelectCategorie event) async* {
    if (event.selected) {
      _filterChoosedWrapper.insertCategorie(event.itemSelected);
    }

    _filterChoosedWrapper.removeCategorie(event.itemSelected);
  }

  Stream<InterestState> mapLoadCategoriesToState() async* {
    yield state.copyWith(isLoading: true);

    final response = await _interestRepository.getCategories();
    yield response.fold((categories) {
      return state.copyWith(isLoading: false, categories: categories);
    }, (exception) {
      return state.copyWith(isLoading: false, isError: true);
    });
  }
}
