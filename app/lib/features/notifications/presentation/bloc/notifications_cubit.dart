import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/notifications/data/models/notifications_model.dart';
import 'package:mozin/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(
      {@required NotificationsRepository notificationsRepository})
      : assert(notificationsRepository != null),
        _notificationsRepository = notificationsRepository,
        super(NotificationsState.initial());

  final NotificationsRepository _notificationsRepository;

  void getNotifications({bool byPass}) async {
    if (getItInstance<UserService>().notAuthenticated()) {
      emit(state.copyWith(
        notAutenticated: true,
      ));
      return;
    }

    if (state.notifications.length == 0 || (byPass != null && byPass)) {
      emit(state.copyWith(
        isLoading: true,
        notAutenticated: false,
      ));

      Either<List<NotificationsModel>, Exception> _response =
          await _notificationsRepository.getNotifications();

      _response.fold((model) {
        emit(state.copyWith(
          isLoading: false,
          isError: false,
          isSuccess: true,
          notifications: model,
          notAutenticated: false,
        ));
      }, (error) {
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          isSuccess: false,
          notAutenticated: false,
        ));
      });
    }
  }
}