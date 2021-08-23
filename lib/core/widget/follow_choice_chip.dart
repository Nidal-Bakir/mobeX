import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/bloc/store_bloc/store_bloc.dart';
import 'package:mobox/core/model/store_model.dart';
import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/utils/const_data.dart';

class FollowChoiceChip extends StatefulWidget {
  final Store store;

  const FollowChoiceChip({Key? key, required this.store}) : super(key: key);

  @override
  _FollowChoiceChipState createState() => _FollowChoiceChipState();
}

class _FollowChoiceChipState extends State<FollowChoiceChip> {
  late final UserProfile _userProfile;

  @override
  void initState() {
    _userProfile =
        (context.read<AuthBloc>().state as AuthLoadUserProfileSuccess)
            .userProfile;

    // no need for the api call in case is is a guest
    if (_userProfile.token != ConstData.guestDummyToken)
      context.read<StoreBloc>().add(
          StoreFollowStateLoaded(storeUserName: widget.store.ownerUserName));

    super.initState();
  }

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
          _message = 'You are following ${widget.store.storeName}';
        } else {
          _message = 'You un followed ${widget.store.storeName}';
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
          if (_userProfile.token == ConstData.guestDummyToken) {
            Navigator.of(context).pushNamed('/login');
          } else {
            context.read<StoreBloc>().add(StoreFollowStateChanged(
                isFollowing: !_localIsFollowing,
                storeUserName: widget.store.ownerUserName));
          }
        },
        label: Text(
          _localIsFollowing ? 'Following' : 'Follow',
          style: TextStyle(fontSize: 12),
        ),
      );
    });
  }
}
