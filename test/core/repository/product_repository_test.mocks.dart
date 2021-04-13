// Mocks generated by Mockito 5.0.3 from annotations
// in mobox/test/core/repository/product_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:http/src/client.dart' as _i2;
import 'package:mobox/core/data/product_data_source/local/local_product_source.dart'
    as _i3;
import 'package:mobox/core/data/product_data_source/remote/remote_product_source.dart'
    as _i6;
import 'package:mobox/core/model/product_model.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeClient extends _i1.Fake implements _i2.Client {}

/// A class which mocks [LocalProductDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalProductDataSourceImpl extends _i1.Mock
    implements _i3.LocalProductDataSourceImpl {
  MockLocalProductDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Map<String, List<_i4.Product>> get cache =>
      (super.noSuchMethod(Invocation.getter(#cache),
              returnValue: <String, List<_i4.Product>>{})
          as Map<String, List<_i4.Product>>);
  @override
  void appendCache(_i5.Future<List<_i4.Product>>? productList, String? endPoint) =>
      super.noSuchMethod(Invocation.method(#appendCache, [productList, endPoint]),
          returnValueForMissingStub: null);
  @override
  _i5.Stream<_i4.Product> getProductsStreamFromLocalEndPoint(
          String? endPoint) =>
      (super.noSuchMethod(
          Invocation.method(#getProductsStreamFromLocalEndPoint, [endPoint]),
          returnValue: Stream<_i4.Product>.empty()) as _i5.Stream<_i4.Product>);
  @override
  int getNumberOfCachedProductsForEndPoint(String? endPoint) =>
      (super.noSuchMethod(
          Invocation.method(#getNumberOfCachedProductsForEndPoint, [endPoint]),
          returnValue: 0) as int);
}

/// A class which mocks [RemoteProductDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteProductDataSourceImpl extends _i1.Mock
    implements _i6.RemoteProductDataSourceImpl {
  MockRemoteProductDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get client => (super.noSuchMethod(Invocation.getter(#client),
      returnValue: _FakeClient()) as _i2.Client);
  @override
  set client(_i2.Client? _client) =>
      super.noSuchMethod(Invocation.setter(#client, _client),
          returnValueForMissingStub: null);
  @override
  String get token =>
      (super.noSuchMethod(Invocation.getter(#token), returnValue: '')
          as String);
  @override
  _i5.Stream<_i4.Product> getProductsStreamFromEndPoint(
          {String? endPoint, int? paginationCount}) =>
      (super.noSuchMethod(
          Invocation.method(#getProductsStreamFromEndPoint, [],
              {#endPoint: endPoint, #paginationCount: paginationCount}),
          returnValue: Stream<_i4.Product>.empty()) as _i5.Stream<_i4.Product>);
}