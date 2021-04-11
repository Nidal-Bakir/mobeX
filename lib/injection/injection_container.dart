import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/auth/data/data_source/local/local_auth.dart';
import 'package:mobox/core/auth/data/data_source/remote/remote_auth.dart';
import 'package:mobox/core/auth/data/repository/auth_repo.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/data/product_data_source/local/local_product_source.dart';
import 'package:mobox/core/data/product_data_source/remote/remote_product_source.dart';
import 'package:mobox/core/repository/product_repository.dart';
import 'package:mobox/core/utils/shared_initializer.dart';


part 'auth_injection.dart';

part 'home_injection.dart';

part 'core_injection.dart';

final sl = GetIt.instance;

void init() {
  // auth feature
  authInit();
  coreInit();
  // home feed feature
  homeInit();
}
