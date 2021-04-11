import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String title;
  final bool vertical;

  const NoData({
    Key? key,
     this.title='',
    this.vertical = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _isVerticalChildren(vertical, context, title),
      ),
    );
  }
}

List<Widget> _isVerticalChildren(
    bool isVertical, BuildContext context, String title) {
  if (isVertical) {
    return [
      Flexible(child: Image.asset('assets/images/nothing_to_show_space.png')),
      Flexible(
        child: Text(
          'Nothing to show right know',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    ];
  } else {
    return [
      Text(
        '$title',
        style: Theme.of(context).textTheme.headline6,
      ),
      Row(
        children: [
          Flexible(child: Image.asset('assets/images/nothing_to_show.png')),
          Flexible(
            child: Text(
              'Nothing to show right know',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    ];
  }
}
