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
import 'package:mobox/core/model/order_item.dart';
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
import 'package:mobox/features/create_store/data/data_sources/create_store_remote_data_source.dart';
import 'package:mobox/features/create_store/presentation/manager/create_store_bloc/create_store_bloc.dart';
import 'package:mobox/features/create_store/repositories/create_store_repository.dart';
import 'package:mobox/features/follow_list/data/local/data_sources/follow_list_local_data_source.dart';
import 'package:mobox/features/follow_list/data/remote/data_sources/follow_list_remote_data_source.dart';
import 'package:mobox/features/follow_list/presentation/manager/follow_list_bloc.dart';
import 'package:mobox/features/order/data/local/local_order_data_source.dart';
import 'package:mobox/features/order/data/remote/remote_order_data_source.dart';
import 'package:mobox/features/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:mobox/features/order/presentation/bloc/order_item_bloc/order_item_bloc.dart';
import 'package:mobox/features/order/repositories/order_repository.dart';
import 'package:mobox/features/product_management/data/remote/data_sources/store_management_remote_data_source.dart';
import 'package:mobox/features/product_management/repositories/store_management_repository.dart';
import 'package:mobox/features/profile/bloc/profile_bloc.dart';
import 'package:mobox/features/profile/data/remote/remote_profile_data_source.dart';
import 'package:mobox/features/profile/repository/profile_repository.dart';
import 'package:mobox/features/purchase_orders/data/local/purchase_orders_local_data_source.dart';
import 'package:mobox/features/purchase_orders/data/model/purchase_orders.dart';
import 'package:mobox/features/purchase_orders/data/remote/purchase_order_remote_data_source.dart';
import 'package:mobox/features/purchase_orders/presentation/manager/purchase_order_bloc/purchase_order_bloc.dart';
import 'package:mobox/features/purchase_orders/presentation/manager/purchase_orders_bloc/purchase_orders_bloc.dart';
import 'package:mobox/features/purchase_orders/repositories/follow_list_repository.dart';
import 'package:mobox/features/purchase_orders/repositories/purchase_orders_repository.dart';
import 'package:mobox/features/search/bloc/store_search_bloc.dart';
import 'package:mobox/features/search/data/remote_data_source/remote_search_data_source.dart';
import 'package:mobox/features/search/repository/search_repository.dart';

part 'auth_injection.dart';
part 'cart_injection.dart';
part 'categories_injection.dart';
part 'core_injection.dart';
part 'create_store_injection.dart';
part 'follow_list_injection.dart';
part 'order_injection.dart';
part 'product_manage_injection.dart';
part 'profile_injection.dart';
part 'purchase_orders_injection.dart';
part 'search_injection.dart';

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

  // cart init feature
  cartInit();

  // order init feature
  ordersInit();

  // purchase orders init feature
  purchaseOrdersInit();

  // create store feature
  createStoreInit();

  // follow list feature
  followListInit();
}
