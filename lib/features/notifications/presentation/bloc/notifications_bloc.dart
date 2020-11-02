import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc({@required NotificationsRepository notificationsRepository})
      : assert(notificationsRepository != null),
        _notificationsRepository = notificationsRepository,
        super(NotificationsState.initial());

  final NotificationsRepository _notificationsRepository;

  @override
  Stream<NotificationsState> mapEventToState(
    NotificationsEvent event,
  ) async* {
  }
}