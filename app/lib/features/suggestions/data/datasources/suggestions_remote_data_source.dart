import 'package:mozin/features/suggestions/data/models/new_suggestions_model.dart';
import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:custom_utilities/custom_utilities.dart';
import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class SuggestionsRemoteDataSource {
  Future<ResponseDefaultModel> addSuggestion(NewSuggestionsModel? model);
  Future<ResponseDefaultModel> updateSuggestions(SuggestionsModel? model);
  Future<ResponseDefaultModel> removeSuggestions(SuggestionsModel? model);
}

class SuggestionsRemoteDataSourceImpl implements SuggestionsRemoteDataSource {
  SuggestionsRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository? remoteClientRepository;

  @override
  Future<ResponseDefaultModel> addSuggestion(
    NewSuggestionsModel? model,
  ) async {
    String _query = '''
    mutation addSuggestion {
      addSuggestion(suggestion:{
        title: "${model!.title}",
        description: "${model.description}",
        url: "${model.url ?? ''}",
        categoryId: "${model.categoryId}",
        subCategoryId: "${model.subCategoryId}",
      }) {
          isSuccess
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_query);
    return ResponseDefaultModel.fromJson(result['data']['addSuggestion']);
  }

  @override
  Future<ResponseDefaultModel> updateSuggestions(
      SuggestionsModel? model) async {
    String _query = '''
    mutation updateSuggestion {
      updateSuggestion(suggestion:{
        id: "${model!.id}",
        title: "${model.title}",
        description: "${model.description}"
      }) {
          isSuccess
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_query);
    return ResponseDefaultModel.fromJson(result['data']['updateSuggestion']);
  }

  @override
  Future<ResponseDefaultModel> removeSuggestions(
      SuggestionsModel? model) async {
    String _query = '''
    mutation removeSuggestion {
      removeSuggestion(suggestion:{
        id: "${model!.id}",
        categoryId: "${model.categoryId}",
        subCategoryId: "${model.subCategoryId}",
      }) {
          isSuccess
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_query);
    return ResponseDefaultModel.fromJson(result['data']['removeSuggestion']);
  }
}
