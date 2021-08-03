import 'package:bloc/bloc.dart';
import 'package:mozin/package_view/blocs/default_state.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit():
        super(HomeState.initial());
}
