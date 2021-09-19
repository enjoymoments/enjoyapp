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
              r'/(((http|ftp|https):\/{2})+(([0-9a-z_-]+\.)+(aero|asia|biz|cat|com|coop|edu|gov|info|int|jobs|mil|mobi|museum|name|net|org|pro|tel|travel|ac|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|cr|cu|cv|cx|cy|cz|cz|de|dj|dk|dm|do|dz|ec|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|io|iq|ir|is|it|je|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mk|ml|mn|mn|mo|mp|mr|ms|mt|mu|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nu|nz|nom|pa|pe|pf|pg|ph|pk|pl|pm|pn|pr|ps|pt|pw|py|qa|re|ra|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tf|tg|th|tj|tk|tl|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|yu|za|zm|zw|arpa)(:[0-9]+)?((\/([~0-9a-zA-Z\#\+\%@\.\/_-]+))?(\?[0-9a-zA-Z\+\%@\/&\[\];=_-]+)?)?))\b/imuS')
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
