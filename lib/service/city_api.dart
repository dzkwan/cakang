import 'package:cakang/model/city_model.dart';
import 'package:dio/dio.dart';

class CityApi {
  final Dio dio = Dio();

  Future getCity() async {
    try {
      final Response response = await dio.get(
        'http://192.168.0.10/app/city',
      );
      List city = (response.data)
          .map(
            (e) => City(
              id: e['id'],
              name: e['name'],
              image: e['image'],
            ),
          )
          .toList();
      // print(category);
      return city;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
