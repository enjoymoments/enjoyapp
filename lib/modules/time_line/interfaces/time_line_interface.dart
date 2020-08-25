import 'package:mozin/modules/time_line/models/time_line_model.dart';

abstract class TimeLineInterface {
  Future<String> addTimeLineItem(String timelineID, TimeLineItemModel model);
}