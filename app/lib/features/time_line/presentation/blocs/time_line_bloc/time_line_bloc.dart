import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/features/time_line/data/models/get_time_line_model.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';
import 'package:mozin/modules/config/utils.dart';

part 'time_line_event.dart';
part 'time_line_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(
    this.timelineRepository,
    this.userWrapper,
  ) : super(TimelineState.initial());

  final TimelineRepository timelineRepository;
  final UserWrapper userWrapper;

  @override
  Stream<TimelineState> mapEventToState(
    TimelineEvent event,
  ) async* {
    if (event is LoadPosts) {
      yield* mapPostsToState();
    } else if (event is DeletePost) {
      yield* mapDeletePostToState(event);
    } else if (event is VerifyAuthenticated) {
      yield* mapVerifyAuthenticatedToState(event);
    } else if (event is SelectedTimeline) {
      yield* mapSelectedTimelineToState(event);
    }
  }

  Stream<TimelineState> mapSelectedTimelineToState(
      SelectedTimeline event) async* {
    var _user = userWrapper.getUser;

    var _newInstance = _user.copyWith(timelineSelected: event.timeline);
    userWrapper.assignment(_newInstance);

    yield state.copyWith(
      forceRefresh: StateUtils.generateRandomNumber(),
      timelineSelected: event.timeline,
    );

    this.add(LoadPosts());
  }

  Stream<TimelineState> mapVerifyAuthenticatedToState(
      VerifyAuthenticated event) async* {
    var _user = userWrapper.getUser;
    if (_user == UserAppModel.empty) {
      yield state.copyWith(unauthenticated: true);
      return;
    }

    yield state.copyWith(unauthenticated: false);
    if (state.posts.isEmpty) {
      this.add(LoadPosts());
    }
  }

  Stream<TimelineState> mapDeletePostToState(DeletePost event) async* {
    try {
      if (state.posts.remove(event.post)) {
        var user = userWrapper.getUser;
        if (user.timelineSelected == null) {
          user = await _updateInstanceUserWithTimelines(user);
        }

        await this
            .timelineRepository
            .deletePost(user.timelineSelected.id, event.post.id);
        yield state.copyWith(
          isLoading: false,
          isSuccess: true,
          posts: state.posts,
          forceRefresh: StateUtils.generateRandomNumber(),
        );
      }
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true);
    }
  }

  Stream<TimelineState> mapPostsToState() async* {
    yield state.copyWith(isLoading: true);

    try {
      var user = userWrapper.getUser;
      if (user.timelineSelected == null) {
        user = await _updateInstanceUserWithTimelines(user);
      }

      final posts = await this
          .timelineRepository
          .getPosts(user.timelineSelected.id, state.limit);

      yield state.copyWith(
        isLoading: false,
        isSuccess: true,
        posts: posts,
        timelines: user.timelines,
        timelineSelected: user.timelineSelected,
        forceRefresh: StateUtils.generateRandomNumber(),
      );
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true);
    }
  }

  Future<UserAppModel> _updateInstanceUserWithTimelines(UserAppModel user) async {
    var _timelines = await this.timelineRepository.getTimelines(user.id);
    UserAppModel newInstance;

    if (_timelines != null && _timelines.length > 0) {
      var _element = _timelines.firstWhere(
          (element) => element.type == TimeLineTypeEnum.Personal,
          orElse: () => null);

      newInstance =
          user.copyWith(timelines: _timelines, timelineSelected: _element);
    } else {
      var _newTimelineId = await this
          .timelineRepository
          .setTimeline([user.id], TimeLineTypeEnum.Personal);

      var _newTimeline =
          GetTimeLineModel(id: _newTimelineId, type: TimeLineTypeEnum.Personal);

      newInstance = user
          .copyWith(timelines: [_newTimeline], timelineSelected: _newTimeline);
    }

    userWrapper.assignment(newInstance);
    return newInstance;
  }
}
