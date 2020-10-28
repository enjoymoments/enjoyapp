import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mozin/features/time_line/domain/repositories/time_line_repository.dart';
import 'package:mozin/modules/config/constants.dart';
import 'package:mozin/features/time_line/data/models/time_line_model.dart';
import 'package:mozin/modules/shared/general/models/user_app_model.dart';
import 'package:mozin/modules/shared/general/models/user_wrapper.dart';
import 'package:mozin/package_view/blocs/default_state.dart';
import 'package:mozin/package_view/utils.dart';

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
    }
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
        await this.timelineRepository.deletePost(temp_time_line, event.post.id);
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
      final posts =
          await this.timelineRepository.getPosts(temp_time_line, state.limit);

      yield state.copyWith(isLoading: false, isSuccess: true, posts: posts);
    } catch (e) {
      yield state.copyWith(isLoading: false, isError: true);
    }
  }
}
