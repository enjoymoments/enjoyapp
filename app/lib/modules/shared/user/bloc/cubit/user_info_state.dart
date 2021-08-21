import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

class UserInfoState extends DefaultState {
  UserInfoState({
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

  factory UserInfoState.initial() {
    return UserInfoState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      existCoupleId: false
    );
  }

  UserInfoState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    bool existCoupleId,
  }) {
    return UserInfoState(
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
