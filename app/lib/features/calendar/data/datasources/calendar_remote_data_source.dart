import 'package:mozin/features/calendar/data/models/grouped_date_calendar_model.dart';
import 'package:mozin/features/calendar/data/models/grouped_year_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';
import 'package:mozin/modules/shared/core_migrate/remote_client_repository.dart';

abstract class CalendarRemoteDataSource {
  Future<bool?> addTaskInCalendar(String? coupleId, AddTaskCalendar? model);
  Future<bool?> removeTaskInCalendar(String? coupleId, String? taskId);
  Future<List<GroupedDateCalendarModel>> getTasksInCalendar(String? coupleId);
  Future<List<GroupedYearCalendarModel>> getTasksUserCalendarGroupedByYear(
      String? coupleId);
}

class CalendarRemoteDataSourceImpl implements CalendarRemoteDataSource {
  CalendarRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository? remoteClientRepository;

  @override
  Future<bool?> addTaskInCalendar(
    String? coupleId,
    AddTaskCalendar? model,
  ) async {
    var _listActivities = <String>[];

    for (var activity in model!.activities!) {
      _listActivities.add('''
         {
            sessionId:"${activity.sessionId}"
            activityId:"${activity.activityId}"
          }
        ''');
    }

    var _activitiesFormated = _listActivities.join(',');

    String _query = '''
    mutation addTask {
      addTaskInCalendar(
        coupleId: ${_formatCoupleId(coupleId)},
        task:{
          title: "${model.title}"
          description: "${model.description}"
          url: "${model.url}"
          dateTime: "${model.dateTime}"
          activities: [$_activitiesFormated]
      })
    }
    ''';

    var result = await remoteClientRepository!.query(_query);
    return result['data']['addTaskInCalendar'];
  }

  @override
  Future<List<GroupedYearCalendarModel>> getTasksUserCalendarGroupedByYear(
      String? coupleId) async {
    String _query = '''
    query getTasksUserCalendarGroupedByYear {
      getTasksUserCalendarGroupedByYear(coupleId: ${_formatCoupleId(coupleId)}) {
        year
        months {
          month
          tasks {
            taskId
            title
            description
            url
            dateTime
            activities {
              sessionId
              activityId
            }
          }
        }
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_query);

    List<GroupedYearCalendarModel> _list = <GroupedYearCalendarModel>[];

    for (var e in result['data']['getTasksUserCalendarGroupedByYear']) {
      _list.add(GroupedYearCalendarModel.fromJson(e));
    }

    return _list;
  }

  @override
  Future<bool?> removeTaskInCalendar(String? coupleId, String? taskId) async {
    String _query = '''
    mutation removeTaskInUserCalendar{
      removeTaskInUserCalendar(
        coupleId: ${_formatCoupleId(coupleId)},
        taskId:"$taskId")
    }
    ''';

    var result = await remoteClientRepository!.query(_query);

    return result['data']['removeTaskInUserCalendar'];
  }

  @override
  Future<List<GroupedDateCalendarModel>> getTasksInCalendar(
      String? coupleId) async {
    String _query = '''
    query getTasksUserCalendar {
      getTasksUserCalendar(coupleId: ${_formatCoupleId(coupleId)}) {
        date
        tasks {
          taskId
          title
          description
          url
          dateTime
          activities {
            sessionId
            activityId
          }
        }
      }
    }
    ''';

    var result = await remoteClientRepository!.query(_query);

    List<GroupedDateCalendarModel> _list = <GroupedDateCalendarModel>[];

    for (var e in result['data']['getTasksUserCalendar']) {
      _list.add(GroupedDateCalendarModel.fromJson(e));
    }

    return _list;
  }

  String? _formatCoupleId(String? coupleId) {
    return coupleId != null ? "\"$coupleId\"" : null;
  }
}
