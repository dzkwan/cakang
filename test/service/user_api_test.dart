import 'package:cakang/service/user_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User API: ', () {
    test('get all user', () async {
      var users = await UserApi().getUser();
      expect(users.isNotEmpty, true);
    });
    test('get user by id', () async {
      var userById = await UserApi().getUserById(id: 61);
      expect(userById.isNotEmpty, true);
    });
    test('login user', () async {
      var checkLogin =
          await UserApi().checkLogin(username: 'arhan', password: 'pratama');
      expect(checkLogin.isNotEmpty, true);
    });
    test('regis user', () async {
      var regisUser = await UserApi().postUser(
        fullname: 'a',
        username: 'a',
        email: 'a',
        password: 'a',
        phone: 'a',
        city: 1,
        category: '[2,3]',
      );
      expect(regisUser.isNotEmpty, true);
    });
    test('edit user', () async {
      var editUser = await UserApi().putUser(
        id: 67,
        fullname: 'b',
        username: 'b',
        email: 'b',
        password: 'b',
        phone: 'b',
        city: 7,
        category: '[1,2]',
      );
      expect(editUser.isNotEmpty, false);
    });
    test('delete user', () async {
      var deleteUser = await UserApi().deleteUser(id: 66);
      expect(deleteUser == null, true);
    });
  });
}
