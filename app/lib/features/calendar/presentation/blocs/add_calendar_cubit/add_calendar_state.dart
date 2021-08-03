part of 'add_calendar_cubit.dart';

class AddCalendarState extends DefaultState {
  AddCalendarState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.forceRefresh,
    this.model,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final TaskCalendarModel model;
  final int forceRefresh;

  factory AddCalendarState.initial() {
    return AddCalendarState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      model: TaskCalendarModel(
        activities: List(),
        dateTime: DateTime.now(),
      ),
      forceRefresh: null,
    );
  }

  AddCalendarState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    TaskCalendarModel model,
    int forceRefresh,
  }) {
    return AddCalendarState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      model: model ?? this.model,
      forceRefresh: forceRefresh ?? this.forceRefresh,
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
        forceRefresh,
      ];
}
