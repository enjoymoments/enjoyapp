part of 'time_line_bloc.dart';

class TimelineState extends DefaultState {
  TimelineState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.posts,
    this.forceRefresh,
    this.limit,
    this.timelines,
    this.timelineSelected
  }): super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  factory TimelineState.initial() {
    return TimelineState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: true,
      errorMessage: null,
      posts: [],
      forceRefresh: 0,
      limit: 10,
      timelines: [],
      timelineSelected: null,
    );
  }

  TimelineState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isEmpty,
    bool? isError,
    String? errorMessage,
    List<TimeLineItemModel>? posts,
    int? forceRefresh,
    int? limit,
    List<GetTimeLineModel>? timelines,
    GetTimeLineModel? timelineSelected,
  }) {
    return TimelineState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      posts: posts ?? this.posts,
      forceRefresh: forceRefresh ?? this.forceRefresh,
      limit: limit ?? this.limit,
      timelines: timelines ?? this.timelines,
      timelineSelected: timelineSelected ?? this.timelineSelected,
    );
  }

  final List<TimeLineItemModel>? posts;
  final int? forceRefresh;
  final int? limit;
  final List<GetTimeLineModel>? timelines;
  final GetTimeLineModel? timelineSelected;

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        posts,
        forceRefresh,
        limit,
        timelines,
        timelineSelected,
      ];
}
