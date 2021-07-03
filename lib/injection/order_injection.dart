part of 'injection_container.dart';

void ordersInit() {
  // bloc
  sl.registerFactory<OrderBloc>(() => OrderBloc(sl(), sl.get<CartBloc>()));

  sl.registerFactoryParam((orderItem, orderId) => OrderItemBloc(
      repository: sl(),
      initValueForItem: orderItem as OrderItem,
      orderId: orderId as int));

  // repository
  sl.registerLazySingleton<OrderRepository>(() => OrderRepository(
        sl(),
        sl(),
      ));

  // remote data source
  sl.registerLazySingleton<RemoteOrderDataSource>(
    () => RemoteOrderDataSourceImpl(
      (sl.get<AuthBloc>().state as AuthLoadUserProfileSuccess)
          .userProfile
          .token,
      sl(),
    ),
  );

  // local data source
  sl.registerLazySingleton<LocalOrderDataSource>(
      () => LocalOrderDataSourceImpl());
}
