part of 'connected_cubit.dart';

class ConnectedState extends DefaultState {
  ConnectedState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    @required this.connectedTabEnum,
    this.favoriteInterests,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final ConnectedTabEnum connectedTabEnum;
  final InterestType favoriteInterests;

  factory ConnectedState.initial() {
    return ConnectedState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      connectedTabEnum: ConnectedTabEnum.ALBUM,
      favoriteInterests: null,
    );
  }

  ConnectedState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    ConnectedTabEnum connectedTabEnum,
    InterestType favoriteInterests,
  }) {
    return ConnectedState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      connectedTabEnum: connectedTabEnum ?? this.connectedTabEnum,
      favoriteInterests: favoriteInterests ?? this.favoriteInterests,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        connectedTabEnum,
        favoriteInterests,
      ];
}
