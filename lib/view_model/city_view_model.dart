import 'package:cakang/service/city_api.dart';
import 'package:flutter/material.dart';

class CityViewModel extends ChangeNotifier {
  List cities = [];
  List cityName = [];
  int? radioValue;

  choseCity({required value})  {
    radioValue = value;
    notifyListeners();
  }

  getcities() async {
    cities = await CityApi().getCity();
    notifyListeners();
  }

  searchCity() async {
    final List data = await CityApi().getCity();
    data.forEach((element) {
      cityName.add(element.name);
    });
    notifyListeners();
  }
}
