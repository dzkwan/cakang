import 'package:cakang/utils/pallete.dart';
import 'package:cakang/view/menu/profile/not_login/widget/button_login.dart';
import 'package:cakang/view_model/category_view_model.dart';
import 'package:cakang/view_model/city_view_model.dart';
import 'package:cakang/view_model/user_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final fullnameCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  // late int radioValue;
  // final categoryCtrl = TextEditingController();
  // final cityCtrl = TextEditingController();

  @override
  void initState() {
    Provider.of<CategoryViewModel>(context, listen: false)
        .categoriesCheckboxValue();
    Provider.of<CityViewModel>(context, listen: false).citiesRadioValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(
      context,
      listen: false,
    );
    final categoryViewModel = Provider.of<CategoryViewModel>(
      context,
      listen: false,
    );
    final cityViewModel = Provider.of<CityViewModel>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AllText.title),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(
            top: 10,
            right: 15,
            left: 15,
          ),
          children: [
            Text(
              AllText.register,
              // overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: fullnameCtrl,
              validator: (value) => value!.isEmpty ? AllText.validator : null,
              decoration: InputDecoration(
                label: Text(AllText.fullname),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: usernameCtrl,
              validator: (value) => value!.isEmpty ? AllText.validator : null,
              decoration: InputDecoration(
                label: Text(AllText.username),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: emailCtrl,
              validator: (value) =>
                  (value != null && !EmailValidator.validate(value))
                      ? "${AllText.validator} and include an '@'"
                      : null,
              decoration: InputDecoration(
                label: Text(AllText.email),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordCtrl,
              obscureText: true,
              validator: (value) => value!.isEmpty ? AllText.validator : null,
              decoration: InputDecoration(
                label: Text(AllText.password),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: phoneCtrl,
              validator: (value) => value!.isEmpty ? AllText.validator : null,
              decoration: InputDecoration(
                label: Text(AllText.phone),
              ),
            ),
            SizedBox(height: 20),
            // TextFormField(
            //   controller: phoneCtrl,
            //   validator: (value) => value!.isEmpty ? AllText.validator : null,
            //   decoration: InputDecoration(
            //     label: Text(AllText.phone),
            //   ),
            // ),
            // Consumer<CategoryViewModel>(
            //   builder: (context, value, _) {
            //     return SizedBox(
            //       child: Text('${categoryViewModel.idCategory}'),
            //     );
            //   },
            // ),
            // Consumer<CityViewModel>(
            //   builder: (context, value, _) {
            //     return SizedBox(
            //       child: Text('${cityViewModel.radioValue}'),
            //     );
            //   },
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Card(
                    child: ExpansionTile(
                      title: Text(AllText.category),
                      children: [
                        Consumer<CategoryViewModel>(
                          builder: (context, value, _) => ListView.builder(
                            // clipBehavior: Clip.antiAlias,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: categoryViewModel.categories.length,
                            itemBuilder: (context, index) {
                              final category =
                                  categoryViewModel.categories[index];
                              return CheckboxListTile(
                                title: Text(
                                  '${category.name}',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                                value: categoryViewModel
                                    .allCategory['value$index'],
                                // value: false,
                                onChanged: (value) {
                                  categoryViewModel.choseCategory(
                                    index: index,
                                    value: value,
                                    id: category.id,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: ExpansionTile(
                      title: Text(AllText.city),
                      children: [
                        Consumer<CityViewModel>(
                          builder: (context, value, _) => ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: cityViewModel.cities.length,
                            itemBuilder: (context, index) {
                              final city = cityViewModel.cities[index];
                              return RadioListTile(
                                value: city.id,
                                title: Text(
                                  city.name,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                groupValue: cityViewModel.radioValue,
                                contentPadding: EdgeInsets.zero,
                                onChanged: (value) {
                                  cityViewModel.choseCity(value: value);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Card(
            //   child: ExpansionTile(
            //     title: Text(AllText.category),
            //     children: [
            //       Consumer<CategoryViewModel>(
            //         builder: (context, value, _) => ListView.builder(
            //           // clipBehavior: Clip.antiAlias,
            //           shrinkWrap: true,
            //           padding: EdgeInsets.zero,
            //           itemCount: categoryViewModel.categories.length,
            //           itemBuilder: (context, index) {
            //             final category = categoryViewModel.categories[index];
            //             return CheckboxListTile(
            //               title: Text('${category.name}'),
            //               value: categoryViewModel.allCategory['value$index'],
            //               // value: false,
            //               onChanged: (value) {
            //                 categoryViewModel.choseCategory(
            //                   index: index,
            //                   value: value,
            //                   id: category.id,
            //                 );
            //               },
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 20),
            // Consumer<CityViewModel>(
            //   builder: (context, value, _) {
            //     return SizedBox(
            //       child: Text('${cityViewModel.radioValue}'),
            //     );
            //   },
            // ),
            // Card(
            //   child: ExpansionTile(
            //     title: Text(AllText.city),
            //     children: [
            //       Consumer<CityViewModel>(
            //         builder: (context, value, _) => ListView.builder(
            //           shrinkWrap: true,
            //           padding: EdgeInsets.zero,
            //           itemCount: cityViewModel.cities.length,
            //           itemBuilder: (context, index) {
            //             final city = cityViewModel.cities[index];
            //             return RadioListTile(
            //               value: city.id,
            //               title: Text(city.name),
            //               groupValue: cityViewModel.radioValue,
            //               onChanged: (value) {
            //                 cityViewModel.choseCity(value: value);
            //               },
            //             );
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 25),
            ButtonLogin(
              text: AllText.register,
              onPressed: (() {
                if (formKey.currentState!.validate()) {
                  if (categoryViewModel.idCategory.isEmpty &&
                      cityViewModel.radioValue == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('category dan city required!'),
                      ),
                    );
                  } else {
                    userViewModel.regisUsers(
                      fullname: fullnameCtrl.text,
                      username: usernameCtrl.text,
                      email: emailCtrl.text,
                      password: passwordCtrl.text,
                      phone: phoneCtrl.text,
                      city: cityViewModel.radioValue,
                      category: categoryViewModel.idCategory.toString(),
                      context: context,
                    );
                  }
                }
              }),
            ),
            // ElevatedButton(
            //   child: Text(AllText.register),
            //   onPressed: (() {
            //     if (formKey.currentState!.validate()) {}
            //   }),
            // ),
            SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'sudah punya akun? ',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(builder: (context) => LoginScreen()),
                        ((route) => false),
                      );
                    }),
                    child: Text(
                      'Masuk',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: AllColor.buttonColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
