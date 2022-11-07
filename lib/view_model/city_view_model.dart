// import 'package:cakang/service/category_api.dart';
import 'package:cakang/service/city_api.dart';
import 'package:flutter/material.dart';

class CityViewModel extends ChangeNotifier {
  List cities = [];
  List cityName = [];
  int? radioValue;
  // List idCategory = [];
  // Map allCategory = {};
  // List get categories => _categories;

  choseCity({required value})  {
    radioValue = value;
    // allCategory['value$index'] = value;
    // if (allCategory['value$index']) {
    //   idCategory.add(id);
    // } else if (!allCategory['value$index']) {
    //   idCategory.remove(id);
    // }
    // idCategory.sort();
    notifyListeners();
  }

  getcities() async {
    cities = await CityApi().getCity();
    // for (var i = 0; i < cities.length; i++) {
    //   allCategory['value$i'] = false;
    // }
    // if (idCategory.isNotEmpty) {
    //   idCategory.clear();
    // }
    notifyListeners();
  }

  searchCity() async {
    final List data = await CityApi().getCity();
    data.forEach((element) {
      // print(element['name']);
      cityName.add(element.name);
    });
    // print(cityName.toString());
    notifyListeners();
  }
}
