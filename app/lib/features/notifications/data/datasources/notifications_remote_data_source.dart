import 'package:mozin/features/notifications/data/models/notifications_model.dart';
import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationsModel>> getNotifications();
}

class NotificationsRemoteDataSourceImpl implements NotificationsRemoteDataSource {
  NotificationsRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;

  @override
  Future<List<NotificationsModel>> getNotifications() async {
    final query = '''
      query notifications {
        getNotifications {
          notificationType
          message
          dateTime
        }
      }
    ''';

    var resultQuery = await remoteClientRepository.query(query);
    var resultList = <NotificationsModel>[];

    resultQuery['data']['getNotifications'].forEach((dynamic v) {
      resultList.add(NotificationsModel.fromJson(v));
    });

    return resultList;
  }
}
