import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:mozin/modules/config/constants.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';

part 'time_line_event.dart';
part 'time_line_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(this.timelineRepository) : super(TimelineState.initial());

  final TimelineRepository timelineRepository;

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
      final posts = await this.timelineRepository.getPosts(temp_time_line);

      yield state.copyWith(isLoading: false, isSuccess: true, posts: posts);
    } catch (e) {
      yield state.copyWith(isLoading: false, isFailure: true);
    }
  }
}
