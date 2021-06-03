part of 'notifications_cubit.dart';

class NotificationsState extends DefaultState {
  NotificationsState({
    bool isLoading,
    bool isEmpty,
    bool isError,
    bool isSuccess,
    String errorMessage,
    this.notifications,
    this.initRequest,
    this.notAutenticated,
  }) : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isEmpty: isEmpty,
          isError: isError,
          errorMessage: errorMessage,
        );

  final List<NotificationsModel> notifications;
  final bool initRequest;
  final bool notAutenticated;

  factory NotificationsState.initial() {
    return NotificationsState(
      isSuccess: false,
      isEmpty: false,
      isError: false,
      isLoading: true,
      errorMessage: null,
      notifications: [],
      initRequest: false,
      notAutenticated: null,
    );
  }

  NotificationsState copyWith({
    bool isLoading,
    bool isSuccess,
    bool isEmpty,
    bool isError,
    String errorMessage,
    List<NotificationsModel> notifications,
    bool initRequest,
    bool notAutenticated,
  }) {
    return NotificationsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isEmpty: isEmpty ?? this.isEmpty,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      notifications: notifications ?? this.notifications,
      initRequest: initRequest ?? this.initRequest,
      notAutenticated: notAutenticated ?? this.notAutenticated,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isEmpty,
        isError,
        errorMessage,
        notifications,
        initRequest,
        notAutenticated,
      ];
}
