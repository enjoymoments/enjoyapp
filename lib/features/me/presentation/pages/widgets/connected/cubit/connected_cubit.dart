import 'package:bloc/bloc.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'connected_state.dart';

class ConnectedCubit extends Cubit<ConnectedState> {
  ConnectedCubit() : super(ConnectedState.initial());
}
