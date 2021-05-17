import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/core/widget/retry_button.dart';
import 'package:mobox/core/widget/sliver_products_grid.dart';
import 'package:mobox/features/search/util/search_value_state_provider.dart';

class ProductSearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _searchStateProv = context.read<SearchValueStateProvider>();

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadSuccess) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) => notificationListener(
              notification: notification,
              onNotify: () => context.read<ProductBloc>().add(
                    ProductMoreSearchDataLoaded(
                      productName: _searchStateProv.getSearchTerms(),
                    ),
                  ),
            ),
            child: CustomScrollView(
              slivers: [
                SliverProductsGrid(productList: state.productList),
              ],
            ),
          );
        } else if (state is ProductLoadFailure) {
          return CustomScrollView(
            slivers: [
              SliverProductsGrid(
                productList: state.productList,
              ),
              SliverToBoxAdapter(
                child: RetryTextButton(
                  onClickCallback: () => context.read<ProductBloc>().add(
                        ProductSearchLoadRetried(
                          productName: _searchStateProv.getSearchTerms(),
                          priceLessThenOrEqual:
                              _searchStateProv.getPriceLessThenOrEqual(),
                        ),
                      ),
                ),
              )
            ],
          );
        } else if (state is ProductMoreInProgress) {
          return CustomScrollView(
            slivers: [
              SliverProductsGrid(
                productList: state.productList,
              ),
              SliverToBoxAdapter(
                child: LinearProgressIndicator(),
              ),
            ],
          );
        } else if (state is ProductNoData) {
          return Center(
            child: Text(
              'Your search return nothing!!',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        } else if (state is ProductSearchInitial) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          SvgPicture.asset(
            'assets/images/search1.svg',
            width: 150,
          ),

          Padding(
            padding: const EdgeInsets.only(top:24.0),
            child: Text(
              'Enter few words to search MobeX ...',
              textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
