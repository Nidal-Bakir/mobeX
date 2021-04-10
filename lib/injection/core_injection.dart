part of 'injection_container.dart';

void coreInit() {
  // bloc
  sl.registerFactoryParam(
      (endpoint, _) => ProductBloc(sl(), endpoint.toString()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepository(
      localProductDataSource: sl(), remoteProductDataSource: sl()));

  // data source
  sl.registerLazySingleton<LocalProductDataSource>(
    () => LocalProductDataSourceImpl(),
  ); //local data source
  sl.registerLazySingleton<RemoteProductDataSource>(() =>
      RemoteProductDataSourceImpl(
          client: sl(),
          token: (sl.get<AuthBloc>().state as AuthLoadTokenSuccess)
              .token)); // remote data source
}
