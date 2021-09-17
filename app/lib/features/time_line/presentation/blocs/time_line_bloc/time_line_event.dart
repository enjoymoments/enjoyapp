part of 'time_line_bloc.dart';

class TimelineEvent extends Equatable  {
  @override
  List<Object> get props => [];
}

class InitLoad extends TimelineEvent {}

class LoadPosts extends TimelineEvent {}

class DeletePost extends TimelineEvent {
  final TimeLineItemModel post;

  DeletePost(this.post);
}

class SelectedTimeline extends TimelineEvent {
  final GetTimeLineModel? timeline;

  SelectedTimeline(this.timeline);
}