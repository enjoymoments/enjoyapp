import 'package:mozin/features/calendar/data/models/activity_model.dart';
import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class ActivityRemoteDataSource {
  Future<List<ActivityModel>> getActivities();
}

class ActivityRemoteDataSourceImpl implements ActivityRemoteDataSource {
  ActivityRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository? remoteClientRepository;

  @override
  Future<List<ActivityModel>> getActivities() async {
    String _query = '''
    query getActivities {
      getActivities {
        id
        sessionName
        activities {
          id
          name
          codePoint
        }
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_query);

    List<ActivityModel> _list = <ActivityModel>[];

    for (var e in result['data']['getActivities']) {
      _list.add(ActivityModel.fromJson(e));
    }

    return _list;
  }
}
