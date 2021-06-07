import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/model/user_store.dart';

import 'package:mobox/features/profile/bloc/profile_bloc.dart';
import 'package:mobox/features/profile/data/model/editable_profile_info.dart';

class EditProfile extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfile({Key? key, required this.userProfile}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late var _editableProfileInfo =
      EditableProfileInfo.fromProfile(widget.userProfile);
  late UserProfile _userProfile = widget.userProfile;

  File? _image;
  var _isDataChanged = false;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserStore? _userStore = widget.userProfile.userStore;
    if (_userStore == null)
      return Center(
        child: Text('how did you get here??'),
      );

    return BlocProvider<ProfileBloc>(
      create: (context) => GetIt.I.get<ProfileBloc>(),
      child: Builder(
        builder: (context) => BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileInProgress) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => Dialog(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Loading...'),
                        CircularProgressIndicator()
                      ],
                    ),
                  ),
                ),
              );
              return; // exit the function immediately
            } else if (state is ProfileChangesUploadSuccess) {
              // update the profile data across the app
              context.read<AuthBloc>().add(AuthUpdateUserProfileLoaded());
              showSnack(context, 'Your info updated successfully.');
              Navigator.of(context).pop(); //pop loading dialog from stack

            } else if (state is ProfileChangesUploadFailure) {
              showSnack(
                  context, 'Something want wrong while updating your profile.');
            }

            //pop loading dialog from stack if failure or screen if success
            Navigator.of(context).pop();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('Edit profile'),
              actions: [
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _isDataChanged
                      ? () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            context.read<ProfileBloc>().add(ProfileInfoEdited(
                                _editableProfileInfo, _userProfile));
                          }
                        }
                      : null,
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: _getImageWidget(),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  var pickedImage = await ImagePicker()
                                      .getImage(source: ImageSource.gallery);
                                  if (pickedImage != null) {
                                    setState(() {
                                      _isDataChanged = true;
                                      _image = File(pickedImage.path);
                                      _editableProfileInfo =
                                          _editableProfileInfo.copyWith(
                                              profileImagePath: _image?.path);
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.camera_alt,
                                  ),
                                ),
                                style: Theme.of(context)
                                    .elevatedButtonTheme
                                    .style
                                    ?.copyWith(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          if (states.any(
                                              {MaterialState.pressed}.contains))
                                            return Colors.green;
                                          return Colors.grey.withAlpha(100);
                                        }),
                                        shape: MaterialStateProperty.all(
                                            CircleBorder())),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24.0,
                    ),
                    child: Form(onChanged: () =>dataChanged() ,
                      key: _formKey,
                      child: Column(
                        children: [
                          // store name TextField
                          TextFormField(
                            keyboardType: TextInputType.text,
                            maxLength: 50,
                            buildCounter: (context,
                                    {required currentLength,
                                    required isFocused,
                                    maxLength}) =>
                                Text('$currentLength/$maxLength'),
                            initialValue: _userStore.storeName,
                            decoration: InputDecoration(
                              labelText: 'Store name',
                            ),
                            style: TextStyle(color: Colors.black),
                            onSaved: (title) => _editableProfileInfo =
                                _editableProfileInfo = _editableProfileInfo
                                    .copyWith(storeName: title),
                            validator: (value) {
                              value = value ?? '';
                              if (value.trim().isEmpty) {
                                return 'please enter a title!';
                              }
                            },
                          ),

                          // city TextField
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _userProfile.address.city,
                              decoration: InputDecoration(
                                labelText: 'City',
                              ),

                              style: TextStyle(color: Colors.black),
                              onSaved: (city) {
                                _editableProfileInfo =
                                    _editableProfileInfo.copyWith(
                                        address: _userProfile.address
                                            .copyWith(city: city));
                              },
                              validator: (value) {
                                value = value ?? '';
                                if (value.trim().isEmpty) {
                                  return 'please enter a city!';
                                }
                              },
                            ),
                          ),

                          // street TextField
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: _userProfile.address.stAddress,
                              decoration: InputDecoration(
                                labelText: 'Street',
                              ),
                              style: TextStyle(color: Colors.black),
                              onSaved: (street) => _editableProfileInfo =
                                  _editableProfileInfo.copyWith(
                                      address: _userProfile.address
                                          .copyWith(stAddress: street)),
                              validator: (value) {
                                value = value ?? '';
                                if (value.trim().isEmpty) {
                                  return 'please enter a street!';
                                }
                              },
                            ),
                          ),

                          // Bio TextField
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 16.0,
                            ),
                            child: TextFormField(
                              maxLines: 4,
                              buildCounter: (context,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  Text('$currentLength/$maxLength'),
                              keyboardType: TextInputType.multiline,
                              initialValue: _userStore.bio,
                              maxLength: 250,
                              decoration: InputDecoration(
                                labelText: 'Bio',
                              ),
                              style: TextStyle(color: Colors.black),
                              onSaved: (bio) => _editableProfileInfo =
                                  _editableProfileInfo.copyWith(bio: bio),
                              validator: (value) {
                                value = value ?? '';
                                if (value.trim().isEmpty) {
                                  return 'please enter a bio!';
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dataChanged() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      setState(() {
        _isDataChanged =
            !_editableProfileInfo.shareSameDataWithUserProfile(_userProfile);
      });
    }
  }

  Widget _getImageWidget() {
    if (_image != null) {
      _editableProfileInfo =
          _editableProfileInfo.copyWith(profileImagePath: _image?.path);
      return Image.file(
        _image!.absolute,
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        _userProfile.profileImage,
        fit: BoxFit.cover,
      );
    }
  }

  void showSnack(BuildContext context, String text) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
          '$text',
        ),
      ),
    );
  }
}
