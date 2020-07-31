import 'package:get_it/get_it.dart';
import 'package:mozin/modules/shared/wrapper_media_service.dart';
import 'package:mozin/views/time_line/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:uuid/uuid.dart';

GetIt getItInstance = GetIt.instance;

Future setup() async {
  getItInstance.allowReassignment = true;

  _registerSingletonModels();
  _registerSingletonProviders();
  _registerSingletonServices();
  _registerBlocs();
}

void _registerSingletonModels() {
  //TODO:mock
  // UserModel userModel = new UserModel(userId: "123");
  // getItInstance.registerSingleton(userModel);
}

void _registerSingletonProviders() {
  // getItInstance
  //     .registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());
}

void _registerSingletonServices() {
  getItInstance
      .registerLazySingleton<WrapperMediaService>(() => WrapperMediaService());
  getItInstance.registerLazySingleton<Uuid>(() => Uuid());
}

void _registerBlocs() {
  getItInstance.registerLazySingleton<AddTimeLineBloc>(
      () => AddTimeLineBloc(getItInstance(), getItInstance()));
}
