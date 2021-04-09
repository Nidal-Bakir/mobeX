import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  final String title;

  const NoData({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        ],
      ),
    );
  }
}
