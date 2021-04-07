import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/widget/products_list.dart';
import 'package:mobox/features/home_feed/bloc/ad_bloc/ad_bloc.dart';

class AdList extends StatefulWidget {
  @override
  _AdListState createState() => _AdListState();
}

class _AdListState extends State<AdList> {
  @override
  void initState() {
    context.read<AdBloc>().add(AdDataLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdBloc, AdState>(
      builder: (context, state) {
        if (state is AdLoadSuccess) {
          return ProductsList(
            title: 'Ad',
            products: state.adList,
          );
        } else if (state is AdLoadFailure) {
          return ProductsList(
            title: 'Ad',
            products: state.adList,
            withRetryButton: true,
          );
        } else if (state is AdNoData) {
          return Center(
            child: Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('/assets/images/nothing_to_show.png'),
                  Text(
                    'Nothing to show rightKnow',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
