part of 'day_one_bloc.dart';

class DayOneState extends DefaultState {
  DayOneState({
    bool isLoading,
    bool isError,
    bool isEmpty,
  }) : super(
          isLoading: isLoading,
          isError: isError,
          isEmpty: isEmpty,
        );

  factory DayOneState.initial() {
    return DayOneState();
  }

  DayOneState copyWith() {
    return DayOneState();
  }

  @override
  List<Object> get props => [];
}
