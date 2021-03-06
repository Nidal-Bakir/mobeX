import 'package:flutter/material.dart';
import 'package:mobox/core/model/product_model.dart';

class AnimatedAddToCartFAB extends StatefulWidget {
  final Product product;

  const AnimatedAddToCartFAB({Key? key, required this.product})
      : super(key: key);

  @override
  _AnimatedAddToCartFABState createState() => _AnimatedAddToCartFABState();
}

class _AnimatedAddToCartFABState extends State<AnimatedAddToCartFAB>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _controller.forward(from: 0);
      },
      child: AnimatedIcon(
        icon: AnimatedIcons.add_event,
        progress: _controller,
      ),
    );
  }
}
