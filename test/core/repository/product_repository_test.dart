import 'package:flutter_test/flutter_test.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/core/repository/product_repository.dart';
import 'package:mobox/core/data/product_data_source/local/local_product_source.dart';
import 'package:mobox/core/data/product_data_source/remote/remote_product_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';

import 'product_repository_test.mocks.dart';

@GenerateMocks([LocalProductDataSourceImpl, RemoteProductDataSourceImpl])
void main() {
  var productListRemote = [
    Product(
        id: 5,
        title: 'ad',
        storeName: '5',
        imageUrl: 'assets/images/productimg2.png',
        price: 11.0,
        sale: 110.0,
        description: 'test description',
        rate: 11.0),
    Product(
        id: 6,
        title: 'ad',
        storeName: '6',
        imageUrl: 'assets/images/productimg2.png',
        price: 12.0,
        description: 'test description',
        sale: 110.0,
        rate: 11.0),
    Product(
        id: 7,
        title: 'ad',
        storeName: '7',
        imageUrl: 'assets/images/productimg2.png',
        price: 13.0,
        description: 'test description',
        sale: 110.0,
        rate: 11.0),
    Product(
        id: 8,
        title: 'ad',
        storeName: '8',
        imageUrl: 'assets/images/productimg2.png',
        price: 14.0,
        description: 'test description',
        sale: 110.0,
        rate: 11.0),
  ];
  var productListLocal = [
    Product(
        id: 0,
        title: 'ad',
        description: 'test description',
        storeName: '1',
        imageUrl: 'assets/images/productimg2.png',
        price: 11.0,
        sale: 110.0,
        rate: 11.0),
    Product(
        id: 1,
        title: 'ad',
        storeName: '2',
        imageUrl: 'assets/images/productimg2.png',
        price: 12.0,
        description: 'test description',
        sale: 110.0,
        rate: 11.0),
    Product(
        id: 2,
        title: 'ad',
        storeName: '3',
        imageUrl: 'assets/images/productimg2.png',
        price: 13.0,
        sale: 110.0,
        description: 'test description',
        rate: 11.0),
    Product(
        id: 3,
        title: 'ad',
        storeName: '4',
        imageUrl: 'assets/images/productimg2.png',
        price: 14.0,
        description: 'test description',
        sale: 110.0,
        rate: 11.0),
  ];
  late MockRemoteProductDataSourceImpl remote;
  late MockLocalProductDataSourceImpl local;
  late ProductRepository repository;

  setUp(() {
    remote = MockRemoteProductDataSourceImpl();
    local = MockLocalProductDataSourceImpl();
    repository = ProductRepository(
        localProductDataSource: local, remoteProductDataSource: remote);

    when(local.getNumberOfCachedProductsForEndPoint(any)).thenReturn(0);
  });
  group('getProductsStreamFromEndPoint() function test', () {
    test(
        'getProductsStreamFromEndPoint() should emit the same stream provided from remote in case the cache is empty ',
        () async {
      when(local.getProductsStreamFromLocalEndPoint(any))
          .thenAnswer((realInvocation) => Stream.fromIterable([]));

      when(remote.getProductsStreamFromEndPoint(
              endPoint: anyNamed('endPoint'),
              paginationCount: anyNamed('paginationCount')))
          .thenAnswer(
              (realInvocation) => Stream.fromIterable(productListRemote));

      var stream = repository.getProductsStreamFromEndPoint('endPoint');
      await expectLater(stream, emitsInOrder(productListRemote));
    });

    test(
      'getProductsStreamFromEndPoint() should emit the same stream provided from local first then the remote ',
      () async {
        when(local.getProductsStreamFromLocalEndPoint(any)).thenAnswer(
            (realInvocation) => Stream.fromIterable(productListLocal));

        when(remote.getProductsStreamFromEndPoint(
                endPoint: anyNamed('endPoint'),
                paginationCount: anyNamed('paginationCount')))
            .thenAnswer((realInvocation) =>
                Stream.fromIterable(productListRemote)
                    .delay(Duration(seconds: 1))); //mock the internet delay

        var stream = repository.getProductsStreamFromEndPoint('endPoint');
        var expectedEmits = [...productListLocal, ...productListRemote];

        await expectLater(stream, emitsInOrder(expectedEmits));
      },
    );
  });
  group('getProductsStreamFromAPIForInfiniteScrolling() function test', () {
    test(
        'getProductsStreamFromAPIForInfiniteScrolling() should emit the same stream provided from remote',
        () async {
      when(remote.getProductsStreamFromEndPoint(
              endPoint: anyNamed('endPoint'),
              paginationCount: anyNamed('paginationCount')))
          .thenAnswer((realInvocation) => Stream.fromIterable(productListRemote)
              .delay(Duration(seconds: 1)));

      var stream =
          repository.getProductsStreamFromAPIForInfiniteScrolling('endPoint');

      await expectLater(stream, emitsInOrder(productListRemote));

      // verify(local.appendCache(Future.value(productListRemote), 'endPoint')).called(1);
    });
  });
}
