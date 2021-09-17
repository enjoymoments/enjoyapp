import 'package:mozin/features/suggestions/data/models/suggestions_model.dart';
import 'package:mozin/modules/shared/general/models/response_default_model.dart';
import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class SuggestionsRemoteDataSource {
  Future<ResponseDefaultModel> addSuggestion(SuggestionsModel? model);
  Future<ResponseDefaultModel> updateSuggestions(SuggestionsModel? model);
  Future<ResponseDefaultModel> removeSuggestions(SuggestionsModel? model);
}

class SuggestionsRemoteDataSourceImpl implements SuggestionsRemoteDataSource {
  SuggestionsRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository? remoteClientRepository;

  @override
  Future<ResponseDefaultModel> addSuggestion(
    SuggestionsModel? model,
  ) async {
    String _query = '''
    mutation addSuggestion {
      addSuggestion(suggestion:{
        title: "${model!.title}",
        description: "${model.description}"
      }) {
          isSuccess
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_query);
    return ResponseDefaultModel.fromJson(result['data']['addSuggestion']);
  }

  @override
  Future<ResponseDefaultModel> updateSuggestions(SuggestionsModel? model) async {
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
  Future<ResponseDefaultModel> removeSuggestions(SuggestionsModel? model) async {
    String _query = '''
    mutation removeSuggestion {
      removeSuggestion(id: "${model!.id}") {
          isSuccess
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_query);
    return ResponseDefaultModel.fromJson(result['data']['removeSuggestion']);
  }
}
