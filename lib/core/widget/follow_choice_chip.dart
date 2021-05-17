import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/bloc/store_bloc/store_bloc.dart';
import 'package:mobox/core/model/store_model.dart';

class FollowChoiceChip extends StatelessWidget {
  final Store store;

  const FollowChoiceChip({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _localIsFollowing = false;

    return BlocConsumer<StoreBloc, StoreState>(listener: (context, state) {
      var _message = '';
      if (state is StoreFollowStateLoadFailure) {
        _message = 'Check your internet connection!';
      } else if (state is StoreFollowStateChangeFailure) {
        _message = 'some thing went wrong try again later!';
      } else if (state is StoreFollowStateChangSuccess) {
        if (state.isFollowing) {
          _message = 'You are following ${store.storeName}';
        } else {
          _message = 'You un followed ${store.storeName}';
        }
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(_message)));
    }, builder: (context, state) {
      if (state is StoreFollowStateLoadSuccess) {
        _localIsFollowing = state.isFollowing;
      } else if (state is StoreFollowStateChangSuccess) {
        _localIsFollowing = state.isFollowing;
      }
      return ChoiceChip(
        selected: _localIsFollowing,
        backgroundColor:
            _localIsFollowing ? Theme.of(context).accentColor : Colors.white,
        visualDensity: VisualDensity.compact,
        selectedColor:
            _localIsFollowing ? Theme.of(context).accentColor : Colors.white,
        onSelected: (selection) {
          context.read<StoreBloc>().add(StoreFollowStateChanged(
              isFollowing: !_localIsFollowing, storeUserName: store.ownerUserName));
        },
        label: Text(
          _localIsFollowing ? 'Following' : 'Follow',
          style: TextStyle(fontSize: 12),
        ),
      );
    });
  }
}
