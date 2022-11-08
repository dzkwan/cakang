import 'package:cakang/utils/theme.dart';
import 'package:cakang/view/menu/main_screen.dart';
import 'package:cakang/view_model/category_view_model.dart';
import 'package:cakang/view_model/city_view_model.dart';
import 'package:cakang/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => UserViewModel())),
        ChangeNotifierProvider(create: ((context) => CategoryViewModel())),
        ChangeNotifierProvider(create: ((context) => CityViewModel())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        home: const MainScreen(),
      ),
    );
  }
}