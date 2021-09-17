import 'package:mozin/features/time_line/data/models/get_time_line_model.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';

abstract class TimelineRepository {
  Future<String> addTimeLineItem(String? timelineID, String userId, TimeLineItemModel model);
  Future<List<TimeLineItemModel>> getPosts(String? timelineID, int? limit);
  Future<void> deletePost(String? timelineID, String? postID);
  Future<List<GetTimeLineModel>> getTimelines(String userId);
}
