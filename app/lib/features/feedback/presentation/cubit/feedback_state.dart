part of 'feedback_cubit.dart';

class FeedbackState extends DefaultState {
  FeedbackState({
    bool? isLoading,
    bool? isEmpty,
    bool? isError,
    bool? isSuccess,
    String? errorMessage,
    this.model,
    this.forceRefresh,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final FeedbackModel? model;
  final int? forceRefresh;

  factory FeedbackState.initial() {
    return FeedbackState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      model: null,
      forceRefresh: null,
    );
  }

  FeedbackState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isEmpty,
    bool? isError,
    String? errorMessage,
    FeedbackModel? model,
    int? forceRefresh,
  }) {
    return FeedbackState(
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
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        model,
        forceRefresh,
      ];
}
