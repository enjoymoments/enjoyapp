import 'package:bloc/bloc.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'unsynccouple_state.dart';

class UnsyncCoupleCubit extends Cubit<UnsyncCoupleState> {
  UnsyncCoupleCubit() : super(UnsyncCoupleState.initial());
}
