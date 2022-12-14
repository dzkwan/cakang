import 'dart:convert';
import 'package:cakang/service/user_api.dart';
import 'package:cakang/view/menu/main_screen.dart';
import 'package:cakang/view/menu/profile/login/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UserViewModel extends ChangeNotifier {
  late SharedPreferences loginData;
  late bool newUser;
  List users = [];
  List filterUser = [];
  Map userLogin = {};
  String? selectedItem;

  Future openWhatsapp({required phone}) async {
    final _phone = phone.substring(1);
    final url = Uri.parse('https://api.whatsapp.com/send?phone=62$_phone');
    await launchUrl(url, mode: LaunchMode.externalApplication);
    notifyListeners();
  }

  Future getUsers() async {
    if (selectedItem != null) {
      selectedItem = null;
    }
    users = filterUser = await UserApi().getUser();
    notifyListeners();
  }

  Future getUsersById(id) async {
    userLogin = await UserApi().getUserById(id: id);
    notifyListeners();
  }

  Future regisUsers({
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
      MaterialPageRoute(builder: ((context) => const ProfileScreen())),
      (route) => false,
    );
    notifyListeners();
  }

  Future editUsers({
    required id,
    required fullname,
    required username,
    required email,
    required password,
    required phone,
    required city,
    required category,
  }) async {
    userLogin = await UserApi().putUser(
      id: id,
      fullname: fullname,
      username: username,
      email: email,
      password: password,
      phone: phone,
      city: city,
      category: category,
    );
    notifyListeners();
  }

  Future deleteUsers({required id, required context}) async {
    await UserApi().deleteUser(id: id);
    userLogin.clear();
    loginData.setBool('isLogin', false);
    loginData.remove('id');
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
        builder: ((context) => const MainScreen()),
      ),
      (route) => false,
    );
    notifyListeners();
  }

  void filterUsers(value) {
    filterUser = users.where((element) => element.city == value).toList();
    selectedItem = value;
    notifyListeners();
  }

  Future loginUsers({required username, required password, required context}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    userLogin = await UserApi().checkLogin(
      username: username,
      password: password,
    );

    if (userLogin.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
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
      loginData.setStringList('category', List<String>.from(userLogin['category']));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => const ProfileScreen())),
        (route) => false,
      );
    }
    notifyListeners();
  }

  Future checkLogin(context) async {
    loginData = await SharedPreferences.getInstance();
    newUser = loginData.getBool('isLogin') ?? false;
    if (newUser == true) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: ((context) => const ProfileScreen()),
        ),
        (route) => false,
      );
    }
    notifyListeners();
  }

  Future fetchUsers() async {
    loginData = await SharedPreferences.getInstance();
    // final _category = jsonDecode(loginData.getString('category').toString());
    Map<String, dynamic> fetch = {
      'id': loginData.getInt('id'),
      'fullname': loginData.getString('fullname').toString(),
      'username': loginData.getString('username').toString(),
      'email': loginData.getString('email').toString(),
      'password': loginData.getString('password').toString(),
      'phone': loginData.getString('phone').toString(),
      'city': loginData.getString('city').toString(),
      'categroy': loginData.getStringList('category'),
    };
    userLogin.addAll(fetch);
    notifyListeners();
  }

  void logout(context) {
    loginData.setBool('isLogin', false);
    loginData.remove('id');
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
        builder: ((context) => const MainScreen()),
      ),
      (route) => false,
    );
    notifyListeners();
  }
}
