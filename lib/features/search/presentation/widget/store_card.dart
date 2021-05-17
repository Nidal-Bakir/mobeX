import 'package:flutter/material.dart';
import 'package:mobox/core/model/store_model.dart';

class StoreCard extends StatelessWidget {
  final Store store;

  const StoreCard({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed('/store-screen', arguments: store),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 150,
          child: Card(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                            child: Hero(
                          tag: store.ownerUserName,
                          child: Image.asset(
                            store.profileImage,
                            fit: BoxFit.cover,
                          ),
                        )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: constraints.maxWidth,
                            color: Colors.black45,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                bottom: 8.0,
                                top: 8.0,
                              ),
                              child: Text(
                                '${store.storeName}',
                                style: Theme.of(context).textTheme.subtitle1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
