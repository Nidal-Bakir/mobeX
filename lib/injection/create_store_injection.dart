part of 'injection_container.dart';

void createStoreInit() {
  // bloc
  sl.registerFactory<CreateStoreBloc>(() => CreateStoreBloc(sl()));

  // repository
  sl.registerLazySingleton<CreateStoreRepository>(
      () => CreateStoreRepository(sl()));

  // data source
  sl.registerLazySingleton<CreateStoreRemoteDataSource>(
      () => CreateStoreRemoteDataSourceImpl(
            (sl.get<AuthBloc>().state as AuthLoadUserProfileSuccess)
                .userProfile
                .token,
            sl(),
          ));
}
