part of 'unsyncoption_cubit.dart';

class UnsyncOptionState extends DefaultState {
  UnsyncOptionState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.existCoupleId,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final bool existCoupleId;

  factory UnsyncOptionState.initial() {
    return UnsyncOptionState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      existCoupleId: false,
    );
  }

  UnsyncOptionState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    bool existCoupleId,
  }) {
    return UnsyncOptionState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      existCoupleId: existCoupleId ?? this.existCoupleId,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        existCoupleId,
      ];
}