import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/auth/data/data_source/local/local_auth.dart';
import 'package:mobox/core/auth/data/data_source/remote/remote_auth.dart';
import 'package:mobox/core/auth/repository/auth_repo.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/bloc/product_management/product_manage_bloc.dart';
import 'package:mobox/core/bloc/store_bloc/store_bloc.dart';
import 'package:mobox/core/data/product_data_source/local/local_product_source.dart';
import 'package:mobox/core/data/product_data_source/remote/remote_product_source.dart';
import 'package:mobox/core/data/store_data_source/remote/store_follow_remote_data_source.dart';
import 'package:mobox/core/repository/product_repository.dart';
import 'package:mobox/core/repository/store_repository.dart';
import 'package:mobox/core/utils/shared_initializer.dart';
import 'package:mobox/features/cart/data/local/data_sources/cart_local_data_source.dart';
import 'package:mobox/features/cart/data/remote/data_sources/cart_remote_source.dart';
import 'package:mobox/features/cart/data/repositories/cart_repository.dart';
import 'package:mobox/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:mobox/features/categories/bloc/categories_bloc.dart';
import 'package:mobox/features/categories/data/local/local_categories_data_source.dart';
import 'package:mobox/features/categories/data/remote/romote_categories_data_source.dart';
import 'package:mobox/features/categories/repository/categories_repository.dart';
import 'package:mobox/features/product_management/data/remote/data_sources/store_management_remote_data_source.dart';
import 'package:mobox/features/product_management/repositories/store_management_repository.dart';
import 'package:mobox/features/profile/bloc/profile_bloc.dart';
import 'package:mobox/features/profile/data/remote/remote_profile_data_source.dart';
import 'package:mobox/features/profile/repository/profile_repository.dart';
import 'package:mobox/features/search/bloc/store_search_bloc.dart';
import 'package:mobox/features/search/data/remote_data_source/remote_search_data_source.dart';
import 'package:mobox/features/search/repository/search_repository.dart';

part 'auth_injection.dart';

part 'search_injection.dart';

part 'core_injection.dart';

part 'categories_injection.dart';

part 'product_manage_injection.dart';

part 'profile_injection.dart';

part 'cart_injection.dart';

final sl = GetIt.instance;

void init() {
  // auth feature
  authInit();

  // core app
  coreInit();

  // categories feature
  categoriesInit();

  // search feature
  searchInit();

  // product management feature
  productManageInit();

  // profile init feature
  profileInit();

  // cart init
  cartInit();
}
