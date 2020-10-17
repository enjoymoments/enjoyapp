import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class InterestRemoteDataSource {
  Future<CategoriesModel> getCategories();
}

class InterestRemoteDataSourceImpl implements InterestRemoteDataSource {
  InterestRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;

  @override
  Future<CategoriesModel> getCategories() async {
    final query = '''
      query categoriesQuery {
        categories {
          id
          name
          subCategories {
            id
            name
          }
        }
      }
    ''';

    var data = await remoteClientRepository.query(query);
    return CategoriesModel.fromJson(data);
  }
}
