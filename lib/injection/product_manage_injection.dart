part of 'injection_container.dart';

void productManageInit() {
  // bloc
  // LazySingleton used to inject the same bloc in product bloc
  sl.registerLazySingleton<ProductManageBloc>(() => ProductManageBloc(sl()));

  // repository
  sl.registerLazySingleton<ProductManagementRepository>(
      () => ProductManagementRepository(storeManagementRemoteDataSource: sl()));

  // data source
  sl.registerLazySingleton<ProductManagementRemoteDataSource>(
      () => ProductManagementRemoteDataSourceImpl(
            client: sl(),
            token: (sl.get<AuthBloc>().state as AuthLoadUserProfileSuccess)
                .userProfile
                .token,
          ));
}
