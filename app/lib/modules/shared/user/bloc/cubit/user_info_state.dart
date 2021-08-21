import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

class UserInfoState extends DefaultState {
  UserInfoState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.existCoupleId,
    this.forceRefresh,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final bool existCoupleId;
  final int forceRefresh;

  factory UserInfoState.initial() {
    return UserInfoState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      existCoupleId: false,
      forceRefresh: null,
    );
  }

  UserInfoState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    bool existCoupleId,
    int forceRefresh,
  }) {
    return UserInfoState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      existCoupleId: existCoupleId ?? this.existCoupleId,
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
        existCoupleId,
        forceRefresh,
      ];
}
