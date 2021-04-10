import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/widget/no_data.dart';
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
      height: 250,
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
            return NoData(
              title: 'Ad',
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
