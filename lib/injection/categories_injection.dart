part of 'injection_container.dart';

void categoriesInit() {
  //  bloc
  sl.registerFactory<CategoriesBloc>(
      () => CategoriesBloc(categoriesRepository: sl()));

  //  Repository
  sl.registerLazySingleton<CategoriesRepository>(
      () => CategoriesRepository(local: sl(), remote: sl()));

  // data source
  sl.registerLazySingleton<LocalCategories>(
    () => LocalCategoriesImpl(),
  ); //local data source
  sl.registerLazySingleton<RemoteCategories>(
    () => RemoteCategoriesImpl(
      token: (sl.get<AuthBloc>().state as AuthLoadTokenSuccess).token,
      client: sl(),
    ),
  ); // remote data source
}
