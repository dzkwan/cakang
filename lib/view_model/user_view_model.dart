import 'package:cakang/service/user_api.dart';
import 'package:cakang/view/menu/main_screen.dart';
import 'package:cakang/view/menu/profile/login/profile_screen.dart';
import 'package:cakang/view/menu/profile/not_login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel extends ChangeNotifier {
  late SharedPreferences loginData;
  late bool newUser;
  List users = [];
  Map userLogin = {};
  late int id;
  String fullname = '';
  String username = '';
  String email = '';
  String password = '';
  String phone = '';
  String city = '';
  List category = [];
  // List get users => _users;

  getUsers() async {
    users = await UserApi().getUser();
    // _users = data;
    notifyListeners();
  }

  regisUsers({
    required fullname,
    required username,
    required email,
    required password,
    required phone,
    required city,
    required category,
    required context,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    userLogin = await UserApi().postUser(
      fullname: fullname,
      username: username,
      email: email,
      password: password,
      phone: phone,
      city: city,
      category: category,
    );
    loginData.setBool('isLogin', true);
    loginData.setInt('id', userLogin['id']);
    loginData.setString('fullname', userLogin['fullname']);
    loginData.setString('username', userLogin['username']);
    loginData.setString('email', userLogin['email']);
    loginData.setString('password', userLogin['password']);
    loginData.setString('phone', userLogin['phone']);
    loginData.setString('city', userLogin['city']);
    loginData.setStringList(
      'category',
      List<String>.from(userLogin['category']),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: ((context) => ProfileScreen())),
      (route) => false,
    );
    // users = await UserApi().getUser();
    // _users = data;
    notifyListeners();
  }

  editUsers({
    required id,
    required fullname,
    required username,
    required email,
    required password,
    required phone,
    required city,
    required category,
  }) async {
    await UserApi().putUser(
      id: id,
      fullname: fullname,
      username: username,
      email: email,
      password: password,
      phone: phone,
      city: city,
      category: category,
    );
    // users = await UserApi().getUser();
    // _users = data;
    notifyListeners();
  }

  deleteUsers({required id}) async {
    await UserApi().deleteUser(id: id);
    // users = await UserApi().getUser();
    // _users = data;
    notifyListeners();
  }

  loginUsers({required username, required password, required context}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    userLogin = await UserApi().checkLogin(
      username: username,
      password: password,
    );

    if (userLogin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('username atau password salah!'),
        ),
      );
    } else {
      loginData.setBool('isLogin', true);
      loginData.setInt('id', userLogin['id']);
      loginData.setString('fullname', userLogin['fullname']);
      loginData.setString('username', userLogin['username']);
      loginData.setString('email', userLogin['email']);
      loginData.setString('password', userLogin['password']);
      loginData.setString('phone', userLogin['phone']);
      loginData.setString('city', userLogin['city']);
      loginData.setStringList(
          'category', List<String>.from(userLogin['category']));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => ProfileScreen())),
        (route) => false,
      );
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     content: Text('$userLogin'),
      //   ),
      // );
    }
    notifyListeners();
  }

  checkLogin(context) async {
    loginData = await SharedPreferences.getInstance();
    newUser = loginData.getBool('isLogin') ?? false;
    if (newUser == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: ((context) => ProfileScreen()),
        ),
        (route) => false,
      );
    }
    notifyListeners();
  }

  fetchUsers() async {
    loginData = await SharedPreferences.getInstance();
    // final fullname = {'fullname': loginData.getStringl('fullname')};
    // Map<String,dynamic> fetch = {
    //   'fullname': loginData.getString('fullname').toString(),
    //   'username': loginData.getString('username').toString(),
    //   'email': loginData.getString('email').toString(),
    //   'password': loginData.getString('password').toString(),
    //   'phone': loginData.getString('phone').toString(),
    //   'city': loginData.getString('city').toString(),
    //   'categroy': loginData.getStringList('categroy')!.toList(),
    // };
    // userLogin.addAll(fetch);
    id = loginData.getInt('id')!;
    fullname = loginData.getString('fullname').toString();
    username = loginData.getString('username').toString();
    email = loginData.getString('email').toString();
    password = loginData.getString('password').toString();
    phone = loginData.getString('phone').toString();
    city = loginData.getString('city').toString();
    category = loginData.getStringList('category')!.toList();
    notifyListeners();
  }

  logout(context) {
    loginData.setBool('isLogin', false);
    loginData.remove('fullname');
    loginData.remove('username');
    loginData.remove('email');
    loginData.remove('password');
    loginData.remove('phone');
    loginData.remove('city');
    loginData.remove('category');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: ((context) => MainScreen()),
      ),
      (route) => false,
    );
    notifyListeners();
  }
}
