import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobox/core/bloc/product_management/product_manage_bloc.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/features/product_management/data/model/editable_product_info.dart';

class ProductManagement extends StatefulWidget {
  final Product? product;

  const ProductManagement({Key? key, this.product}) : super(key: key);

  @override
  _ProductManagementState createState() => _ProductManagementState();
}

class _ProductManagementState extends State<ProductManagement> {
  late bool _withOffer = _product?.sale == null ? false : true;

  late final Product? _product = widget.product;
  var _isDataChanged = false;
  late var _editableProductInfo = _product == null
      ? EditableProductInfo.emptyFields()
      : EditableProductInfo.fromProduct(_product!);

  var _isScrolling = false;

  File? _image;

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductManageBloc, ProductManageState>(
      listener: (context, state) {
        if (state is ProductManageInProgress) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Loading...'), CircularProgressIndicator()],
                ),
              ),
            ),
          );
          return; // exit the function immediately
        } else if (state is ProductManageAddProductSuccess) {
          showSnack(context, 'Product added successfully');
          Navigator.of(context).pop(); //pop loading dialog from stack

        } else if (state is ProductManageEditProductSuccess) {
          showSnack(context, 'Your update\'s has been propagated');
          Navigator.of(context).pop(); //pop loading dialog from stack

        } else if (state is ProductManageDeleteProductSuccess) {
          showSnack(context, 'Your product has been deleted successfully');
          Navigator.of(context).pop(); //pop loading dialog from stack

        } else if (state is ProductManageDeleteProductFailure ||
            state is ProductManageAddProductFailure ||
            state is ProductManageEditProductFailure) {
          showSnack(context,
              'Something want wrong! please check your internet connection!');
        }

        //pop loading dialog from stack if failure or screen if success
        Navigator.of(context).pop(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_product == null ? 'Add Product' : 'Edit product'),
          actions: [
            if (_product != null)
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('NO')),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context
                                  .read<ProductManageBloc>()
                                  .add(ProductManageProductDeleted(_product!));
                            },
                            child: Text('YES')),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollStartNotification ||
                notification.metrics.maxScrollExtent * 0.8 <=
                    notification.metrics.pixels) {
              setState(() {
                _isScrolling = true;
              });
            } else if (notification is ScrollEndNotification) {
              setState(() {
                _isScrolling = false;
              });
            }
            return true;
          },
          child: SingleChildScrollView(
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
                                    _editableProductInfo = _editableProductInfo
                                        .copyWith(imagePath: _image?.path);
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
                    onChanged: () => dataChanged(),
                    key: _formKey,
                    child: Column(
                      children: [
                        // Title Text Form Field
                        TextFormField(
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          buildCounter: (context,
                                  {required currentLength,
                                  required isFocused,
                                  maxLength}) =>
                              Text('$currentLength/$maxLength'),
                          initialValue: _product?.title,
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ),
                          style: TextStyle(color: Colors.black),
                          onSaved: (title) => _editableProductInfo =
                              _editableProductInfo.copyWith(title: title),
                          validator: (value) {
                            value = value ?? '';
                            if (value.trim().isEmpty) {
                              return 'please enter a title!';
                            }
                          },
                        ),

                        // Price Text Form Field
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            initialValue: _product?.price.toString(),
                            decoration: InputDecoration(
                              labelText: 'Price',
                            ),
                            style: TextStyle(color: Colors.black),
                            onSaved: (price) => _editableProductInfo =
                                _editableProductInfo.copyWith(
                                    price: double.tryParse(price ?? '')),
                            validator: (value) {
                              value = value ?? '';
                              if (value.trim().isEmpty) {
                                return 'please enter a title!';
                              } else if (double.tryParse(value) == null) {
                                return 'Enter numeric value!';
                              }
                            },
                          ),
                        ),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          value: _withOffer,
                          onChanged: (value) {
                            setState(() {
                              _withOffer = value ?? false;
                              _isDataChanged = true;
                            });
                          },
                          title: Text(
                            'Product offer',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          subtitle: Text('Uncheck to remove the offer'),
                        ),
                        // offer Text Form Field
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            enabled: _withOffer,
                            keyboardType: TextInputType.number,
                            initialValue: _product?.sale.toString(),
                            decoration: InputDecoration(
                              labelText: 'Offer',
                            ),
                            style: TextStyle(
                              color: _withOffer ? Colors.black : Colors.grey,
                            ),
                            onSaved: (offer) => _editableProductInfo =
                                _editableProductInfo.copyWith(
                                    sale: _withOffer
                                        ? double.tryParse(offer ?? '')
                                        : null),
                            validator: (value) {
                              if (!_withOffer) return null;
                              value = value ?? '';
                              if (value.trim().isEmpty) {
                                return 'please enter a offer!';
                              } else if (double.tryParse(value) == null) {
                                return 'Enter numeric value!';
                              }
                            },
                          ),
                        ),

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
                            initialValue: _product?.description,
                            maxLength: 250,
                            decoration: InputDecoration(
                              labelText: 'Description',
                            ),
                            style: TextStyle(color: Colors.black),
                            onSaved: (description) => _editableProductInfo =
                                _editableProductInfo.copyWith(
                                    description: description),
                            validator: (value) {
                              value = value ?? '';
                              if (value.trim().isEmpty) {
                                return 'please enter a description!';
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
        floatingActionButton: AnimatedContainer(
          transform: Matrix4.identity()
            ..translate(0.0, _isScrolling ? 120.0 : 0.0),
          duration: Duration(milliseconds: 300),
          child: FloatingActionButton(
            backgroundColor: _isDataChanged
                ? Theme.of(context).floatingActionButtonTheme.backgroundColor
                : Colors.grey,
            child: Icon(Icons.save),
            onPressed: _isDataChanged || _product == null
                ? () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      context.read<ProductManageBloc>().add(_product == null
                          ? ProductManageProductAdded(_editableProductInfo)
                          : ProductManageProductEdited(
                              _product!,
                              _editableProductInfo,
                            ));
                    }
                  }
                : null,
          ),
        ),
      ),
    );
  }

  void dataChanged() {
    if (_product != null) {
      if (_formKey.currentState?.validate() ?? false) {
        _formKey.currentState?.save();

        setState(() {
          _isDataChanged =
              !_editableProductInfo.shareSameDataWithProduct(_product!);
        });
      }
    }
  }

  Widget _getImageWidget() {
    if (_image != null) {
      _editableProductInfo =
          _editableProductInfo.copyWith(imagePath: _image?.path);
      return Image.file(
        _image!.absolute,
        fit: BoxFit.cover,
      );
    } else if (_product != null) {
      return Image.network(
        _product!.imageUrl,
        fit: BoxFit.cover,
      );
    }
    return Image.asset('assets/images/productimg2.png');
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
