import 'package:bloc/bloc.dart';
import 'package:mozin/modules/shared/core_migrate/bloc/default_state.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit():
        super(HomeState.initial());
}
