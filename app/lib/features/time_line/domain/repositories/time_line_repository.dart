import 'package:mozin/features/time_line/data/models/time_line_model.dart';

abstract class TimelineRepository {
  Future<String> addTimeLineItem(String timelineID, String userId, TimeLineItemModel model);
  Future<List<TimeLineItemModel>> getPosts(String timelineID, int limit);
  Future<void> deletePost(String timelineID, String postID);
}
