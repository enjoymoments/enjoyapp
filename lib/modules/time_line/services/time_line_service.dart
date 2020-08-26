import 'package:mozin/modules/time_line/interfaces/time_line_interface.dart';
import 'package:mozin/modules/time_line/models/time_line_model.dart';
import 'package:mozin/modules/time_line/repositories/time_line_repository.dart';

class TimeLineService implements TimeLineInterface {
  final TimeLineRepository timeLineRepository;

  TimeLineService(this.timeLineRepository);

  @override
  Future<String> addTimeLineItem(String timelineID, TimeLineItemModel model) {
    try {
      return timeLineRepository.addTimeLineItem(timelineID, model);
    } catch (e) {
      return Future.value(null);
    }
  }

  @override
  Future<List<TimeLineItemModel>> getPosts(String timelineID) {
    try {
      return timeLineRepository.getPosts(timelineID);
    } catch (e) {
      return Future.value(null);
    }
  }
}
