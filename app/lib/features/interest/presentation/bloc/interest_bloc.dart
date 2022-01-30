import 'package:collection/collection.dart' show IterableExtension;
import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:mozin/features/interest/domain/repositories/interest_repository.dart';
import 'package:mozin/modules/shared/filter_choosed/filter_choosed_wrapper.dart';
import 'package:mozin/modules/shared/filter_choosed/models/filter_choosed_model.dart';
import 'package:custom_utilities/custom_utilities.dart';

part 'interest_event.dart';
part 'interest_state.dart';

class InterestBloc extends Bloc<InterestEvent, InterestState> {
  InterestBloc({
    required InterestRepository interestRepository,
    required FilterChoosedWrapper filterChoosedWrapper,
  })  : _interestRepository = interestRepository,
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
    } else if (event is SelectSubCategorie) {
      yield* mapSelectSubCategorieToState(event);
    }
    //TODO:in development
    // else if (event is ChangePrice) {
    //   yield* mapChangePriceToState(event);
    // } else if (event is ChangeDistance) {
    //   yield* mapChangeDistanceToState(event);
    // } else if (event is ChangeTime) {
    //   yield* mapChangeTimeToState(event);
    // }
  }

//TODO:in development
  // Stream<InterestState> mapChangeTimeToState(ChangeTime event) async* {
  //   _filterChoosedWrapper.changeTime(event.minTime, event.maxTime);

  //   yield state.copyWith(
  //       forceRefresh: StateUtils.generateRandomNumber() as int?);
  // }

  // Stream<InterestState> mapChangeDistanceToState(ChangeDistance event) async* {
  //   _filterChoosedWrapper.changeDistance(event.minDistance, event.maxDistance);

  //   yield state.copyWith(
  //       forceRefresh: StateUtils.generateRandomNumber() as int?);
  // }

  // Stream<InterestState> mapChangePriceToState(ChangePrice event) async* {
  //   _filterChoosedWrapper.changePrice(event.minPrice, event.maxPrice);

  //   yield state.copyWith(
  //       forceRefresh: StateUtils.generateRandomNumber() as int?);
  // }

  Stream<InterestState> mapSelectSubCategorieToState(
      SelectSubCategorie event) async* {
    if (event.selected == true) {
      _filterChoosedWrapper.insertSubCategorie(
          event.categorie, event.itemSelected);
    } else {
      _filterChoosedWrapper.removeSubCategorie(
          event.categorie, event.itemSelected);
    }

    yield state.copyWith(
        showNextButtonSubCategories: _getShowNextButtonSubCategories(),
        forceRefresh: StateUtils.generateRandomNumber() as int?);
  }

  Stream<InterestState> mapSelectCategorieToState(
      SelectCategorie event) async* {
    if (event.selected == true) {
      _filterChoosedWrapper.insertCategorie(event.itemSelected);
    } else {
      _filterChoosedWrapper.removeCategorie(event.itemSelected);
    }

    yield state.copyWith(
        showNextButtonCategories:
            _filterChoosedWrapper.getFilterChoosed!.categories!.length > 0,
        showNextButtonSubCategories: _getShowNextButtonSubCategories(),
        forceRefresh: StateUtils.generateRandomNumber() as int?);
  }

  Stream<InterestState> mapLoadCategoriesToState() async* {
    yield state.copyWith(isLoading: true);

    final response = await _interestRepository.getCategories();
    yield response.fold((categories) {
      _loadCategoriesSelected(categories);

      return state.copyWith(
        isLoading: false,
        categories: categories,
        showNextButtonCategories:
            _filterChoosedWrapper.getFilterChoosed!.categories!.length > 0,
        showNextButtonSubCategories: _getShowNextButtonSubCategories(),
      );
    }, (exception) {
      return state.copyWith(isLoading: false, isError: true);
    });
  }

  void _loadCategoriesSelected(List<CategoriesModel> categories) {
    final FilterChoosedModel filterChoosed =
        _filterChoosedWrapper.getFilterChoosed!;

    filterChoosed.categories!.forEach((filterElement) {
      var element = categories
          .firstWhereOrNull((categorie) => categorie.id == filterElement.id);

      if (element != null) {
        element.selected = true;
      }
    });
  }

  bool _getShowNextButtonSubCategories() {
    if (_filterChoosedWrapper.getFilterChoosed!.categories!.length > 0) {
      final CategoriesModel? _exist = _filterChoosedWrapper
          .getFilterChoosed!.categories!
          .firstWhereOrNull((element) => element.subCategories!.any((sub) {
                var _cast = sub as SubCategoriesModel;
                return (_cast.selected ?? false) == true;
              }));
      return _exist != null;
    }

    return false;
  }
}
