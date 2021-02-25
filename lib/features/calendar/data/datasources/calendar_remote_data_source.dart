import 'package:mozin/features/calendar/data/models/grouped_date_calendar_model.dart';
import 'package:mozin/features/calendar/data/models/grouped_year_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class CalendarRemoteDataSource {
  Future<bool> addTaskInCalendar(AddTaskCalendar model);
  Future<bool> removeTaskInCalendar(String taskId);
  Future<List<GroupedDateCalendarModel>> getTasksInCalendar();
  Future<List<GroupedYearCalendarModel>> getTasksUserCalendarGroupedByYear();
  
}

class CalendarRemoteDataSourceImpl implements CalendarRemoteDataSource {
  CalendarRemoteDataSourceImpl(this.remoteClientRepository);

  final RemoteClientRepository remoteClientRepository;

  @override
  Future<bool> addTaskInCalendar(
    AddTaskCalendar model,
  ) async {
    var _listActivities = List<String>();

    for (var activity in model.activities) {
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
      addTaskInCalendar(task:{
        title: "${model.title}"
        description: "${model.description}"
        dateTime: "${model.dateTime}"
        activities: [$_activitiesFormated]
      })
    }
    ''';

    var result = await remoteClientRepository.query(_query);
    return result['data']['addTaskInCalendar'];
  }

  @override
  Future<List<GroupedYearCalendarModel>> getTasksUserCalendarGroupedByYear() async {
    String _query = '''
    query getTasksUserCalendarGroupedByYear {
      getTasksUserCalendarGroupedByYear {
        year
        months {
          month
          tasks {
            taskId
            title
            description
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

    var result = await remoteClientRepository.query(_query);

    List<GroupedYearCalendarModel> _list = List<GroupedYearCalendarModel>();

    for (var e in result['data']['getTasksUserCalendarGroupedByYear']) {
      _list.add(GroupedYearCalendarModel.fromJson(e));
    }

    return _list;
  }

  @override
  Future<bool> removeTaskInCalendar(String taskId) async {
    String _query = '''
    mutation removeTaskInUserCalendar{
      removeTaskInUserCalendar(taskId:"$taskId")
    }
    ''';

    var result = await remoteClientRepository.query(_query);

    return result['data'];
  }

  @override
  Future<List<GroupedDateCalendarModel>> getTasksInCalendar() async {
    String _query = '''
    query getTasksUserCalendar {
      getTasksUserCalendar {
        date
        tasks {
          taskId
          title
          description
          dateTime
          activities {
            sessionId
            activityId
          }
        }
      }
    }
    ''';

    var result = await remoteClientRepository.query(_query);

    List<GroupedDateCalendarModel> _list = List<GroupedDateCalendarModel>();

    for (var e in result['data']['getTasksUserCalendar']) {
      _list.add(GroupedDateCalendarModel.fromJson(e));
    }

    return _list;
  }
}
