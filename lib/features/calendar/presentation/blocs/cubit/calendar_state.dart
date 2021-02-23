part of 'calendar_cubit.dart';

class CalendarState extends DefaultState {
  CalendarState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.model,
    this.events,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<GroupedDateCalendarModel> model;
  final Map<DateTime, List> events;

  factory CalendarState.initial() {
    return CalendarState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      model: List(),
      events: {},
    );
  }

  CalendarState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    List<GroupedDateCalendarModel> model,
    Map<DateTime, List> events,
  }) {
    return CalendarState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      model: model ?? this.model,
      events: events ?? this.events,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        model,
        events,
      ];
}
