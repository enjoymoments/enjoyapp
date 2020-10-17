import 'package:mozin/features/interest/data/models/categories_model.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class InterestRemoteDataSource {
  Future<List<CategoriesModel>> getCategories();
}

class InterestRemoteDataSourceImpl implements InterestRemoteDataSource {
  InterestRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;

  @override
  Future<List<CategoriesModel>> getCategories() async {
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

    var resultQuery = await remoteClientRepository.query(query);
    var resultList = <CategoriesModel>[];

    resultQuery['data']['categories'].forEach((dynamic v) {
      resultList.add(CategoriesModel.fromJson(v));
    });

    return resultList;
  }
}
