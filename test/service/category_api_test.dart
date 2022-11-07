import 'package:cakang/service/category_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('get all category', () async {
    var categories = await CategoryApi().getCategory();
    expect(categories.isNotEmpty, true);
  });
}
