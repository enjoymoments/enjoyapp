import 'package:bloc/bloc.dart';
import 'package:custom_utilities/custom_utilities.dart';

part 'connected_state.dart';

class ConnectedCubit extends Cubit<ConnectedState> {
  ConnectedCubit() : super(ConnectedState.initial());
}
