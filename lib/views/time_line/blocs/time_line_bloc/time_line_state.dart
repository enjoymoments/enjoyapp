part of 'time_line_bloc.dart';

abstract class DefaultBehavior {
  bool isSuccess;
  bool isFailure;
  bool isLoading;
}

class TimelineState extends Equatable implements DefaultBehavior {
  TimelineState({
    this.isFailure,
    this.isSuccess,
    this.isLoading,
    this.posts,
  });

  factory TimelineState.initial() {
    return TimelineState(
      isFailure: false,
      isSuccess: false,
      isLoading: false,
      posts: [],
    );
  }

  TimelineState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isFailure,
    List<TimeLineItemModel> posts,
  }) {
    return TimelineState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      posts: posts ?? this.posts,
    );
  }

  List<TimeLineItemModel> posts;

  @override
  bool isFailure;

  @override
  bool isSuccess;

  @override
  bool isLoading;

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isFailure,
        posts,
      ];
}
