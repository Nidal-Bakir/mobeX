
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  test('',()async{
    var res = await Future.value(http.Response(
        await rootBundle.loadString('assets/for_tests_temp/products.json',cache: false),
        200));
print(res.body);
  });
}