import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/auth/data/data_source/local/local_auth.dart';
import 'package:mobox/core/auth/data/data_source/remote/remote_auth.dart';
import 'package:mobox/core/auth/data/repository/auth_repo.dart';
import 'package:mobox/core/utils/shared_initializer.dart';
import 'package:mobox/features/home_feed/bloc/ad_bloc/ad_bloc.dart';
import 'package:mobox/features/home_feed/data/data_source/local/local_home_data_souce.dart';
import 'package:mobox/features/home_feed/data/data_source/remote/remote_home_data_source.dart';
import 'package:mobox/features/home_feed/data/repository/home_repo.dart';

part 'auth_injection.dart';

part 'home_injection.dart';

final sl = GetIt.instance;

void init() async {
  // auth feature
  authInit();
  // home feed feature
  homeInit();
}
