import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:mozin/features/monitoring/domain/repositories/monitoring_repository.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'monitoring_event.dart';
part 'monitoring_state.dart';

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  MonitoringBloc({required MonitoringRepository monitoringRepository})
      : assert(monitoringRepository != null),
        _monitoringRepository = monitoringRepository,
        super(MonitoringState.initial());

  final MonitoringRepository _monitoringRepository;

  @override
  Stream<MonitoringState> mapEventToState(
    MonitoringEvent event,
  ) async* {
  }
}