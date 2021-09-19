import 'package:bloc/bloc.dart';
import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/features/interest/data/models/sub_categories_model.dart';
import 'package:mozin/features/interest/domain/entities/sub_categories.dart';
import 'package:mozin/features/interest/domain/repositories/interest_repository.dart';
import 'package:mozin/features/suggestions/data/models/new_suggestions_model.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/features/suggestions/domain/repositories/suggestions_repository.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';
import 'package:mozin_core/utils.dart';

part 'suggestions_state.dart';

class SuggestionsCubit extends Cubit<SuggestionsState> {
  SuggestionsCubit({
    required InterestRepository interestRepository,
    required SuggestionsRepository suggestionsRepository,
  })   : _interestRepository = interestRepository,
        _suggestionsRepository = suggestionsRepository,
        super(SuggestionsState.initial());

  final InterestRepository _interestRepository;
  final SuggestionsRepository _suggestionsRepository;

  void loadCategories() async {
    emit(state.copyWith(isLoading: true));

    final response = await _interestRepository.getCategories();

    emit(
      response.fold(
        (categories) {
          return state.copyWith(
            isLoading: false,
            isError: false,
            categories: categories,
          );
        },
        (exception) {
          return state.copyWith(isLoading: false, isError: true);
        },
      ),
    );
  }

  void selectedSubCategorie(
      CategoriesModel category, SubCategoriesModel subCategory) {
    var _categoriesSelected = state.categoriesSelected;
    var _category = _categoriesSelected[category.id!];

    if (subCategory.selected!) {
      //TODO:only 1 subCategory select for now
      // if (_category != null) {
      //   _category.add(subCategory.id!);
      // } else {
      //   _category = [subCategory.id!];
      // }
      _category = [subCategory.id!];
      _categoriesSelected[category.id!] = _category;
    } else {
      if (_category != null) {
        _category.removeWhere((element) => element == subCategory.id!);
        if (_category.isEmpty) {
          _categoriesSelected.remove(category.id!);
        } 
        //TODO:only 1 subCategory select for now
        // else {
        //   _categoriesSelected[category.id!] = _category;
        // }
      }
    }

    //TODO:only 1 subCategory select for now
    List<CategoriesModel> _categories = state.categories;

    for (var item in _categories) {
      for (SubCategories subItem in item.subCategories!) {
        if (subItem is SubCategoriesModel) {
          if(subCategory.selected!) {
            subItem.selected = subCategory.id == subItem.id;
          } else {
            subItem.selected = false;
          } 
        }
      }
    }

    emit(state.copyWith(
      categoriesSelected: _categoriesSelected,
      categories: _categories,
      isError: false,
      forceRefresh: StateUtils.generateRandomNumber() as int?,
    ));
  }

  void remove(String? id) {
    _suggestionsRepository.removeSuggestions(model: SuggestionsModel(id: id));
  }

  void save(String? title, String? description, String? url) {
    if (title == null || title.isEmpty) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Informe um título',
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ));
      return;
    }

    if (url != null && url.isNotEmpty) {
      final Match? stringMatch = RegExp(
              r'https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)')
          .matchAsPrefix(url);

      if (stringMatch == null) {
        emit(state.copyWith(
          isError: true,
          errorMessage: 'Informe uma url válida',
          forceRefresh: StateUtils.generateRandomNumber() as int?,
        ));
        return;
      }
    }

    if (state.categoriesSelected.isEmpty) {
      emit(state.copyWith(
        isError: true,
        errorMessage: 'Selecione ao menos uma categoria',
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      ));
      return;
    }

    _suggestionsRepository.addSuggestion(
      model: NewSuggestionsModel(
        title: title,
        description: description,
        url: url,
        
        //TODO:only 1 subCategory select for now
        //categoriesSelected: state.categoriesSelected,
        categoryId: state.categoriesSelected.keys.first,
        subCategoryId: state.categoriesSelected[state.categoriesSelected.keys.first]!.first, 
      ),
    );

    emit(state.copyWith(
      isSuccess: true,
    ));
  }
}
