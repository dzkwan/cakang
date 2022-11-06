import 'package:cakang/model/user_model.dart';
import 'package:dio/dio.dart';

class UserApi {
  final Dio dio = Dio();

  Future getUser() async {
    try {
      final Response response = await dio.get('http://192.168.0.10/app/users');
      List user = (response.data)
          .map(
            (e) => User(
              id: e['id'],
              fullname: e['fullname'],
              username: e['username'],
              email: e['email'],
              password: e['password'],
              phone: e['phone'],
              city: e['city'],
              category: e['category'],
            ),
          )
          .toList();
      // print(user);
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future postUser({
    required String fullname,
    required String username,
    required String email,
    required String password,
    required String phone,
    required int city,
    required String category,
  }) async {
    try {
      final Response response = await dio.post(
        'http://192.168.0.10/app/users',
        data: FormData.fromMap({
          'fullname': fullname,
          'username': username,
          'email': email,
          'password': password,
          'phone': phone,
          'city_id': city,
          'category_id': category,
        }),
      );
      final user = response.data;
      // print(user);
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future putUser({
    required int id,
    required String fullname,
    required String username,
    required String email,
    required String password,
    required String phone,
    required int city,
    required String category,
  }) async {
    try {
      await dio.put(
        'http://192.168.0.10/app/users/$id',
        data: {
          'id': id,
          'fullname': fullname,
          'username': username,
          'email': email,
          'password': password,
          'phone': phone,
          'city_id': city,
          'category_id': category,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future deleteUser({
    required int id,
  }) async {
    try {
      await dio.delete(
        'http://192.168.0.10/app/users/$id',
        data: FormData.fromMap({
          'id': id,
        }),
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future checkLogin({
    required String username,
    required String password,
  }) async {
    try {
      final Response response = await dio.post(
        'http://192.168.0.10/app/users',
        data: FormData.fromMap({
          'username': username,
          'password': password,
        }),
      );
      final user = response.data;
      // print(user);
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
