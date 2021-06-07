part of 'injection_container.dart';

void coreInit() {
  // bloc
  sl.registerFactoryParam<ProductBloc, String, Null>(
      (endpoint, _) => ProductBloc(sl(), endpoint.toString(), sl()));

  sl.registerFactory<StoreBloc>(() => StoreBloc(storeRepository: sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepository(
      localProductDataSource: sl(), remoteProductDataSource: sl()));

  sl.registerLazySingleton<StoreRepository>(
      () => StoreRepository(remoteStoreDataSource: sl()));

  // data source

  //local data source
  sl.registerLazySingleton<LocalProductDataSource>(
    () => LocalProductDataSourceImpl(),
  );

  // remote data source
  sl.registerLazySingleton<RemoteProductDataSource>(
    () => RemoteProductDataSourceImpl(
      client: sl(),
      token: (sl.get<AuthBloc>().state as AuthLoadUserProfileSuccess)
          .userProfile
          .token,
    ),
  );
  sl.registerLazySingleton<RemoteStoreDataSource>(
    () => RemoteStoreDataSourceImpl(
      client: sl(),
      token: (sl.get<AuthBloc>().state as AuthLoadUserProfileSuccess)
          .userProfile
          .token,
    ),
  );
}
