import 'package:flutter/material.dart';
import 'package:mobox/core/widget/no_data.dart';
import 'package:mobox/features/categories/bloc/categories_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/features/categories/presentation/widget/categorires_custom_scroll_view.dart';

class CategoriesTab extends StatefulWidget {
  @override
  _CategoriesTabState createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  @override
  void initState() {
    context.read<CategoriesBloc>().add(CategoriesListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoadSuccess) {
          return CategoriesCustomScrollView(
            categoriesList: state.categoriesList,
          );
        } else if (state is CategoriesLoadFailure) {
          return CategoriesCustomScrollView(
            categoriesList: state.categoriesList,
            withRetryButton: true,
          );
        } else if (state is CategoriesLoadNoData) {
          return Center(child: NoData(vertical: true));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
