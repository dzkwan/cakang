import 'package:cakang/model/category_model.dart';
import 'package:dio/dio.dart';

class CategoryApi {
  final Dio dio = Dio();

  Future getCategory() async {
    try {
      final Response response = await dio.get(
        'http://192.168.0.10/app/category',
      );
      List category = (response.data)
          .map(
            (e) => Category(
              id: e['id'],
              name: e['name'],
              image: e['image'],
            ),
          )
          .toList();
      // print(category);
      return category;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
