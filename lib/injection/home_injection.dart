part of 'injection_container.dart';

void homeInit() {
  // bloc
  sl.registerFactory<AdBloc>(() => AdBloc(homeRepo: sl()));

  // Repository
  sl.registerLazySingleton<HomeRepo>(
      () => HomeRepo(localHomeDataSource: sl(), remoteHomeDataSource: sl()));

  // data source
  sl.registerLazySingleton<LocalHomeDataSource>(
      () => LocalHomeDataSourceImpl()); //local data source
  sl.registerLazySingleton<RemoteHomeDataSource>(() => RemoteHomeDataSourceImpl(
      client: sl(),
      token: (sl.get<AuthBloc>().state as AuthLoadTokenSuccess)
          .token)); // remote data source


}
