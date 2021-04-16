part of 'invite_cubit.dart';

class InviteState extends DefaultState {
  InviteState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.forceRefresh,
    this.shareUrl,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final int forceRefresh;
  final String shareUrl;

  factory InviteState.initial() {
    return InviteState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      forceRefresh: null,
      shareUrl: null,
    );
  }

  InviteState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    int forceRefresh,
    String shareUrl,
  }) {
    return InviteState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      forceRefresh: forceRefresh ?? this.forceRefresh,
      shareUrl: shareUrl ?? this.shareUrl,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        forceRefresh,
        shareUrl,
      ];
}