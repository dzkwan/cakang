import 'package:cakang/service/category_api.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  List categories = [];
  List idCategory = [];
  Map allCategory = {};

  choseCategory({required index, required value, required id})  {
    allCategory['value$index'] = value;
    if (allCategory['value$index']) {
      idCategory.add(id);
    } else if (!allCategory['value$index']) {
      idCategory.remove(id);
    }
    idCategory.sort();
    notifyListeners();
  }

  categoriesCheckboxValue() async {
    categories = await CategoryApi().getCategory();
    for (var i = 0; i < categories.length; i++) {
      allCategory['value$i'] = false;
    }
    if (idCategory.isNotEmpty) {
      idCategory.clear();
    }
    notifyListeners();
  }
}
