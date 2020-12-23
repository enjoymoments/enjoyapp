part of 'connected_cubit.dart';

class ConnectedState extends DefaultState {
  ConnectedState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    @required this.connectedTabEnum,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final ConnectedTabEnum connectedTabEnum;

  factory ConnectedState.initial() {
    return ConnectedState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: false,
      errorMessage: null,
      connectedTabEnum: ConnectedTabEnum.ALBUM,
    );
  }

  ConnectedState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    ConnectedTabEnum connectedTabEnum,
  }) {
    return ConnectedState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      connectedTabEnum: connectedTabEnum ?? this.connectedTabEnum,
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
      ];
}
