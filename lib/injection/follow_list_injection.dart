part of 'injection_container.dart';

void followListInit() {
  // bloc
  sl.registerFactory<FollowListBloc>(() => FollowListBloc(sl()));

  // repository
  sl.registerLazySingleton<FollowListRepository>(
      () => FollowListRepository(sl(), sl()));

  // data source
  sl.registerLazySingleton<FollowListRemoteDataSource>(
      () => FollowListRemoteDataSourceImpl(
            (sl.get<AuthBloc>().state as AuthLoadUserProfileSuccess)
                .userProfile
                .token,
            sl(),
          ));

  sl.registerLazySingleton<FollowListLocalDataSource>(
      () => FollowListLocalDataSourceImpl());
}
