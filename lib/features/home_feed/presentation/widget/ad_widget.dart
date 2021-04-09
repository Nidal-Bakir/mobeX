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
    return Container(
      height: 200,
      child: BlocBuilder<AdBloc, AdState>(
        builder: (context, state) {
          if (state is AdLoadSuccess) {
            return ProductsList(
              title: 'Ad',
              productList: state.adList,
            );
          } else if (state is AdLoadFailure) {
            return ProductsList(
              title: 'Ad',
              productList: state.adList,
              withReTryButton: true,
            );
          } else if (state is AdNoData) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Image.asset('/assets/images/nothing_to_show.png'),
                  ),
                  Text(
                    'Nothing to show rightKnow',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
