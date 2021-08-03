import 'package:bloc/bloc.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'connected_state.dart';

class ConnectedCubit extends Cubit<ConnectedState> {
  ConnectedCubit() : super(ConnectedState.initial());
}
