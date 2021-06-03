import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mozin/features/notifications/data/models/notifications_model.dart';
import 'package:mozin/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:mozin/modules/config/setup.dart';
import 'package:mozin/modules/shared/user/services/user_service.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

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

    if (!state.initRequest || (byPass != null && byPass)) {
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
          initRequest: true,
          notAutenticated: false,
        ));
      }, (error) {
        emit(state.copyWith(
          isLoading: false,
          isError: true,
          isSuccess: false,
          initRequest: true,
          notAutenticated: false,
        ));
      });
    }
  }
}
