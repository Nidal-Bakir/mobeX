part of 'injection_container.dart';

void profileInit() {
  // bloc
  sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl()));
  // repository
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepository(remoteProfileDataSource: sl()));

  // remote data source
  sl.registerLazySingleton<RemoteProfileDataSource>(
      () => RemoteProfileDataSourceImpl(
            client: sl(),
            token: (sl.get<AuthBloc>().state as AuthLoadUserProfileSuccess)
                .userProfile
                .token,
          ));
}
