import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as bar;
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/model/product_model.dart';

class RatingBar extends StatefulWidget {
  final bool immutable;
  final double? rate;
  final Product product;
  final bool isGuest;

  const RatingBar(
      {Key? key,
      required this.immutable,
      this.rate,
      required this.product,
      required this.isGuest})
      : super(key: key);

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  late double? userRate = widget.rate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (!widget.immutable)
          Padding(
            padding: EdgeInsets.only(bottom: 24.0),
            child: Text('Your rate:'),
          ),
        bar.RatingBar.builder(
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.yellow,
          ),
          allowHalfRating: true,
          itemSize: 25.0,
          itemCount: 5,
          maxRating: 5,
          glow: false,
          minRating: 1,
          ignoreGestures: widget.immutable,
          initialRating: widget.rate ?? 0,
          onRatingUpdate: (value) {
            if (widget.isGuest) {
              Navigator.of(context).pushNamed('/login');
              return;
            }
            setState(() {
              userRate = value;
            });
          },
        ),
        if (!widget.immutable)
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.rate != null)
                TextButton(
                  onPressed: () {
                    setState(() {
                      userRate = 0.0;
                    });
                    context.read<ProductBloc>().add(
                          ProductRateUpDated(
                            newRate: null,
                            oldRate: widget.product.rate,
                            product: widget.product,
                          ),
                        );
                  },
                  child: Text('DELETE'),
                  style: Theme.of(context).textButtonTheme.style?.copyWith(
                        foregroundColor:
                            MaterialStateProperty.all<Color?>(Colors.grey[600]),
                      ),
                ),
              if (widget.rate == null)
                TextButton(
                  child: Text('POST'),
                  onPressed: this.userRate == 0.0
                      ? null
                      : () {
                          context.read<ProductBloc>().add(
                                ProductRateUpDated(
                                  newRate: userRate,
                                  oldRate: widget.product.rate,
                                  product: widget.product,
                                ),
                              );
                        },
                ),
              if (widget.rate != userRate &&
                  widget.product.myRate != null &&
                  userRate != 0.0 &&
                  widget.rate != 0.0 &&
                  widget.rate != null)
                TextButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(
                            ProductRateUpDated(
                              newRate: userRate,
                              oldRate: widget.product.rate,
                              product: widget.product,
                            ),
                          );
                    },
                    child: Text('EDIT')),
            ],
          )
      ],
    );
  }
}
