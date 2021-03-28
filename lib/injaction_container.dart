import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mobox/business_logic/auth/auth_bloc.dart';
import 'package:mobox/data/local_data_source/local_auth.dart';
import 'package:mobox/data/remote_data_source/remote_auth.dart';
import 'package:mobox/data/repository/auth_repo.dart';
import 'package:mobox/utils/shared_initializer.dart';

final sl = GetIt.instance;

void init() async {
  // auth bloc
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepo: sl()));

  // auth Repository
  sl.registerLazySingleton<AuthRepo>(
      () => AuthRepo(localAuth: sl(), remoteAuth: sl()));

  // data saucer
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
