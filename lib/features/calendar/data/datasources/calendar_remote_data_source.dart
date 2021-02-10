import 'package:mozin/features/calendar/data/models/task_calendar_model.dart';
import 'package:mozin/features/calendar/domain/entities/add_task_calendar.dart';
import 'package:mozin/modules/shared/remote_client_repository.dart';

abstract class CalendarRemoteDataSource {
  Future<bool> addTaskInCalendar(AddTaskCalendar model);
  Future<bool> removeTaskInCalendar(String taskId);
  Future<List<TaskCalendarModel>> getTasksInCalendar();
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
        dateTime: "${model.dateTime}"
        activities: [$_activitiesFormated]
      })
    }
    ''';

    var result = await remoteClientRepository.query(_query);
    return result['data'];
  }

  @override
  Future<List<TaskCalendarModel>> getTasksInCalendar() async {
    String _query = '''
    query getTasksUserCalendar {
      getTasksUserCalendar {
        taskId
        title
        dateTime
        activities {
          sessionId
          activityId
        }
      }
    }
    ''';

    var result = await remoteClientRepository.query(_query);

    List<TaskCalendarModel> _list = List<TaskCalendarModel>();

    result['data'].map((e) => _list.add(TaskCalendarModel.fromJson(e)));

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
}
