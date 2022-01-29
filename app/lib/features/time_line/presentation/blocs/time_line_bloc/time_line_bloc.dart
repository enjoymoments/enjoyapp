import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:equatable/equatable.dart';
import 'package:mozin/features/time_line/data/models/get_time_line_model.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/general/enums.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';
import 'package:custom_utilities/custom_utilities.dart';

part 'time_line_event.dart';
part 'time_line_state.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(
    this.timelineRepository,
  ) : super(TimelineState.initial());

  final TimelineRepository? timelineRepository;

  @override
  Stream<TimelineState> mapEventToState(
    TimelineEvent event,
  ) async* {
    if (event is LoadPosts) {
      yield* mapPostsToState();
    } else if (event is DeletePost) {
      yield* mapDeletePostToState(event);
    } else if (event is SelectedTimeline) {
      yield* mapSelectedTimelineToState(event);
    } else if (event is InitLoad) {
      yield* mapInitLoadToState();
    }
  }

  Stream<TimelineState> mapInitLoadToState() async* {
    if (state.posts!.isNotEmpty) {
      yield state.copyWith(
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      );
    } else {
      this.add(LoadPosts());
    }
  }

  Stream<TimelineState> mapSelectedTimelineToState(
      SelectedTimeline event) async* {
    var _user = getItInstance<UserWrapper>().getUser!;

    var _newInstance = _user.copyWith(timelineSelected: event.timeline);
    getItInstance<UserWrapper>().assignment(_newInstance);

    yield state.copyWith(
      forceRefresh: StateUtils.generateRandomNumber() as int?,
      timelineSelected: event.timeline,
    );

    this.add(LoadPosts());
  }

  Stream<TimelineState> mapDeletePostToState(DeletePost event) async* {
    try {
      if (state.posts!.remove(event.post)) {
        var user = getItInstance<UserWrapper>().getUser!;

        await this
            .timelineRepository!
            .deletePost(user.timelineSelected!.id, event.post.id);
        yield state.copyWith(
          isLoading: false,
          isSuccess: true,
          posts: state.posts,
          forceRefresh: StateUtils.generateRandomNumber() as int?,
        );
      }
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true);
    }
  }

  Stream<TimelineState> mapPostsToState() async* {
    yield state.copyWith(isLoading: true);

    try {
      var user = getItInstance<UserWrapper>().getUser!;
      if (user.timelineSelected == null) {
        user = await _updateInstanceUserWithTimelines(user);
      }

      final posts = await this
          .timelineRepository!
          .getPosts(user.timelineSelected!.id, state.limit);

      yield state.copyWith(
        isLoading: false,
        isSuccess: true,
        posts: posts,
        timelines: user.timelines,
        timelineSelected: user.timelineSelected,
        forceRefresh: StateUtils.generateRandomNumber() as int?,
      );
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true);
    }
  }

  Future<UserAppModel> _updateInstanceUserWithTimelines(
      UserAppModel user) async {
    var _timelines = await timelineRepository!.getTimelines(user.id);

    if (_timelines != null && _timelines.length > 0) {
      GetTimeLineModel? _element = _timelines.firstWhereOrNull(
          (element) => element.type == TimeLineTypeEnum.Couple);

      if (_element == null) {
        _element = _timelines.firstWhereOrNull(
            (element) => element.type == TimeLineTypeEnum.Personal);
      }

      var _newInstance =
          user.copyWith(timelines: _timelines, timelineSelected: _element);
      getItInstance<UserWrapper>().assignment(_newInstance);

      return _newInstance;
    }

    return user;
  }
}
