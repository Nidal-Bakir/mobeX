part of 'injection_container.dart';

void purchaseOrdersInit() {
  // blocs

  sl.registerFactoryParam((purchaseOrder, _) =>
      PurchaseOrderBloc(purchaseOrder as PurchaseOrder, sl()));
  sl.registerFactory(() => PurchaseOrdersBloc(sl()));

  // repository
  sl.registerLazySingleton<PurchaseOrdersRepository>(
      () => PurchaseOrdersRepository(sl(), sl()));

  // data source
  // remote
  sl.registerLazySingleton<PurchaseOrdersRemoteDataSource>(() =>
      PurchaseOrdersRemoteDataSourceImpl(
          (sl.get<AuthBloc>().state as AuthLoadUserProfileSuccess)
              .userProfile
              .token,
          sl()));
  // local
  sl.registerLazySingleton<PurchaseOrdersLocalDataSource>(
      () => PurchaseOrderLocalDataSourceImpl());
}
