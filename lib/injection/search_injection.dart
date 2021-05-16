part of 'injection_container.dart';

void searchInit() {
  // bloc
  sl.registerFactory<StoreSearchBloc>(
      () => StoreSearchBloc(searchRepository: sl()));
  // repository
  sl.registerLazySingleton<SearchRepository>(
      () => SearchRepository(remoteSearchDataSource: sl()));

  // remote data source
  sl.registerLazySingleton<RemoteSearchDataSource>(
    () => RemoteSearchDataSourceImpl(
      client: sl(),
      token: (sl.get<AuthBloc>().state as AuthLoadUserProfileSuccess)
          .userProfile
          .token,
    ),
  );
}
