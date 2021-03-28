import 'package:flutter/material.dart';

class ProductsList extends StatelessWidget {
  final String title;


  const ProductsList({Key? key, required this.title})
      : super(key: key);

  // final List<Product> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                '$title',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            TextButton(onPressed: () {}, child: Text('MORE')),
          ],
        ),
       Container(
                height: 150,
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      Container(color: Colors.green, width: 20, height: 150),
                  itemCount: 30,
                  scrollDirection: Axis.horizontal,
                ),
              )
      ],
    );
  }
}
