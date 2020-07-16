import 'package:get_it/get_it.dart';

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
  // getItInstance.registerLazySingleton<Uuid>(() => Uuid());
  // getItInstance.registerLazySingleton<CategoryService>(() => CategoryService());

  // getItInstance.registerLazySingleton<DatabaseService>(
  //     () => DatabaseService(getItInstance(), getItInstance()));
}

void _registerBlocs() {
  // getItInstance.registerLazySingleton<YourIdeasBloc>(() => YourIdeasBloc(getItInstance()));
  // getItInstance.registerLazySingleton<IdeaBloc>(() => IdeaBloc(getItInstance()));
  // getItInstance.registerLazySingleton<CategoryBloc>(() => CategoryBloc(getItInstance()));
  // getItInstance.registerLazySingleton<HomeBloc>(() => HomeBloc(getItInstance()));
}
