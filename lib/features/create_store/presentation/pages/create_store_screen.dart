import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/utils/global_function.dart';

import 'package:mobox/features/create_store/presentation/manager/create_store_bloc/create_store_bloc.dart';

import 'package:mobox/core/model/editable_profile_info.dart';

class CreateStoreScreen extends StatefulWidget {
  const CreateStoreScreen({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<CreateStoreScreen> {
  // the data will change on save for the form
  var _editableProfileInfo = EditableProfileInfo.emptyFields();
  File? _image;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateStoreBloc>(
      create: (context) => GetIt.I.get<CreateStoreBloc>(),
      child: Builder(
        builder: (context) => BlocListener<CreateStoreBloc, CreateStoreState>(
          listenWhen: (previous, current) => current is! CreateStoreInProgress,
          listener: (context, state) {
            if (state is CreateStoreSuccess) {
              context.read<AuthBloc>().add(AuthUpdateUserProfileLoaded());
              // exit form the screen
              Navigator.of(context).pop();
            } else if (state is CreateStoreFailure) {
              showSnack(context, 'Your info updated successfully.');
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('Edit profile'),
              actions: [
                BlocBuilder<CreateStoreBloc, CreateStoreState>(
                  builder: (context, state) {
                    if (state is CreateStoreInProgress) {
                      return CircularProgressIndicator();
                    }
                    return IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          if ((_formKey.currentState?.validate() ?? false) &&
                              _editableProfileInfo
                                  .profileImagePath.isNotEmpty) {
                            _formKey.currentState?.save();
                            context.read<CreateStoreBloc>().add(
                                CreateStoreRequested(_editableProfileInfo));
                          }
                        });
                  },
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
                    child: Form(
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
                            decoration: InputDecoration(
                              labelText: 'Store name',
                            ),
                            style: TextStyle(color: Colors.black),
                            onSaved: (title) {
                              _editableProfileInfo = _editableProfileInfo =
                                  _editableProfileInfo.copyWith(
                                      storeName: title);
                            },
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
                              decoration: InputDecoration(
                                labelText: 'City',
                              ),
                              style: TextStyle(color: Colors.black),
                              onSaved: (city) {
                                _editableProfileInfo =
                                    _editableProfileInfo.copyWith(
                                        address: _editableProfileInfo.address
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
                              decoration: InputDecoration(
                                labelText: 'Street',
                              ),
                              style: TextStyle(color: Colors.black),
                              onSaved: (street) {
                                _editableProfileInfo =
                                    _editableProfileInfo.copyWith(
                                        address: _editableProfileInfo.address
                                            .copyWith(stAddress: street));
                              },
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
                              maxLength: 250,
                              decoration: InputDecoration(
                                labelText: 'Bio',
                              ),
                              style: TextStyle(color: Colors.black),
                              onSaved: (bio) {
                                _editableProfileInfo =
                                    _editableProfileInfo.copyWith(bio: bio);
                              },
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

  Widget _getImageWidget() {
    if (_image != null) {
      _editableProfileInfo =
          _editableProfileInfo.copyWith(profileImagePath: _image?.path);
      return Image.file(
        _image!.absolute,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/productimg2.png',
        fit: BoxFit.cover,
      );
    }
  }
}
