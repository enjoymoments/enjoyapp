import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'configuration_state.dart';

class ConfigurationCubit extends Cubit<ConfigurationState> {
  ConfigurationCubit() : super(ConfigurationInitial());
}
