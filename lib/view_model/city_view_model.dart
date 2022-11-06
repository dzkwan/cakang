// import 'package:cakang/service/category_api.dart';
import 'package:cakang/service/city_api.dart';
import 'package:flutter/material.dart';

class CityViewModel extends ChangeNotifier {
  List cities = [];
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

  citiesRadioValue() async {
    cities = await CityApi().getCity();
    // for (var i = 0; i < cities.length; i++) {
    //   allCategory['value$i'] = false;
    // }
    // if (idCategory.isNotEmpty) {
    //   idCategory.clear();
    // }
    notifyListeners();
  }
}
