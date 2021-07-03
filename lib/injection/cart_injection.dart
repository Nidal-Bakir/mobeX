part of 'injection_container.dart';

void cartInit() {
  //  bloc
  
  sl.registerLazySingleton<CartBloc>(() =>CartBloc(sl()) );
  //  Repository
  sl.registerLazySingleton<CartRepository>(() =>
      CartRepository(cartLocalDataSource: sl(), cartRemoteDataSource: sl()));

  // data source
  sl.registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImpl());
  sl.registerLazySingleton<CartRemoteDataSource>(() => CartRemoteDataSourceImpl(
      (sl.get<AuthBloc>().state as AuthLoadUserProfileSuccess)
          .userProfile
          .token,
      sl()));
}
