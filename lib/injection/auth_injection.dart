part of 'injection_container.dart';

void authInit() {
  //  bloc
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(authRepo: sl()));

  //  Repository
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepo(localAuth: sl(), remoteAuth: sl()));

  // data source
  sl.registerLazySingleton<LocalAuth>(
      () => LocalAuthImpl(sharedInitializer: sl())); //local data source
  sl.registerLazySingleton<RemoteAuth>(
      () => RemoteAuthImpl(client: sl())); // remote data source

  // External
  sl.registerLazySingleton<Client>(() => Client());

  /// to init the SharedPreferences before we use it
  /// we use this Technique to avoid the (await) async before create the hole app
  ///otherwise we forced to do so!
  /// see:: https://github.com/ResoCoder/flutter-tdd-clean-architecture-course/blob/6c5156142f0e0ed84023793a417bc5e1e60d7ac0/lib/main.dart#L7
  sl.registerSingleton<SharedInitializer>(SharedInitializer(),
      signalsReady: true);
}
