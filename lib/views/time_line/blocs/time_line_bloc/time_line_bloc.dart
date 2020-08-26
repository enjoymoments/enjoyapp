import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/constants.dart';
import 'package:mozin/modules/time_line/models/time_line_model.dart';
import 'package:mozin/modules/time_line/services/time_line_service.dart';

part 'time_line_event.dart';
part 'time_line_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(this.timeLineService) : super(TimelineState.initial());

  final TimeLineService timeLineService;

  @override
  Stream<TimelineState> mapEventToState(
    TimelineEvent event,
  ) async* {
    if (event is LoadPosts) {
      yield* mapPostsToState();
    }
  }

  Stream<TimelineState> mapPostsToState() async* {
    yield state.copyWith(isLoading: true);

    try {
      final posts = await this.timeLineService.getPosts(temp_time_line);

      yield state.copyWith(isLoading: false, isSuccess: true, posts: posts);
    } catch (e) {
      yield state.copyWith(isLoading: false, isFailure: true);
    }
  }
}
