import 'package:cakang/service/city_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('get all city', () async {
    var cities = await CityApi().getCity();
    expect(cities.isNotEmpty, true);
  });
}
