import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:mozin/modules/authentication/repositories/authentication_repository.dart';
import 'package:mozin/modules/firebase/firebase_storage_service.dart';
import 'package:mozin/modules/shared/models/user.dart';
import 'package:mozin/modules/shared/services/device_info_service.dart';
import 'package:mozin/modules/shared/services/local_storage_service.dart';
import 'package:mozin/modules/shared/services/wrapper_media_service.dart';
import 'package:mozin/modules/time_line/repositories/time_line_repository.dart';
import 'package:mozin/modules/time_line/services/time_line_service.dart';
import 'package:mozin/views/login/bloc/authentication_bloc.dart';
import 'package:mozin/views/shared/blocs/queue_post/queue_post_bloc.dart';
import 'package:mozin/views/time_line/blocs/add_time_line_bloc/add_time_line_bloc.dart';
import 'package:mozin/views/time_line/blocs/time_line_bloc/time_line_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

GetIt getItInstance = GetIt.instance;

Future setup() async {
  getItInstance.allowReassignment = true;

  var localstorage = await _setupHive();
  getItInstance.registerSingleton(localstorage);

  _registerSingletonModels();
  _registerSingletonServices();
  _registerSingletonRepositories();
  _registerBlocs();
}

void _registerSingletonModels() {
  getItInstance.registerSingleton(User(id: '', email: '', name: '', photo: ''));
}

void _registerSingletonServices() {
  getItInstance
      .registerLazySingleton<WrapperMediaService>(() => WrapperMediaService());
  getItInstance.registerLazySingleton<Uuid>(() => Uuid());
  getItInstance.registerLazySingleton<FirebaseStorageService>(
      () => FirebaseStorageService());
  getItInstance
      .registerLazySingleton<DeviceInfoService>(() => DeviceInfoService());
  getItInstance.registerLazySingleton<TimeLineService>(
      () => TimeLineService(getItInstance()));
}

void _registerBlocs() {
  getItInstance.registerFactory<AddTimeLineBloc>(
      () => AddTimeLineBloc(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationBloc>(
      () => AuthenticationBloc(getItInstance()));

  getItInstance
      .registerLazySingleton<TimelineBloc>(() => TimelineBloc(getItInstance()));

  getItInstance.registerLazySingleton<QueuePostBloc>(
      () => QueuePostBloc(getItInstance(), getItInstance(), getItInstance()));
}

void _registerSingletonRepositories() {
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());

  getItInstance
      .registerLazySingleton<TimeLineRepository>(() => TimeLineRepository());
}

Future<LocalStorageService> _setupHive() async {
  final dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  final userBox = await Hive.openBox("user_box");
  return LocalStorageService(userBox);
}

Future<void> resetInstances() async {
  getItInstance.reset();

  await setup();
}
