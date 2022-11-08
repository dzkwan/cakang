import 'package:cakang/utils/pallete.dart';
import 'package:cakang/view/menu/profile/login/profile_screen.dart';
import 'package:cakang/view/menu/profile/not_login/widget/button_login.dart';
import 'package:cakang/view_model/category_view_model.dart';
import 'package:cakang/view_model/city_view_model.dart';
import 'package:cakang/view_model/user_view_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({
    super.key,
    required this.id,
  });
  int id;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final fullnameCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  @override
  void initState() {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    userViewModel.getUsersById(widget.id);
    fullnameCtrl.text = userViewModel.userLogin['fullname'];
    usernameCtrl.text = userViewModel.userLogin['username'];
    emailCtrl.text = userViewModel.userLogin['email'];
    passwordCtrl.text = userViewModel.userLogin['password'];
    phoneCtrl.text = userViewModel.userLogin['phone'];
    Provider.of<CategoryViewModel>(context, listen: false)
        .categoriesCheckboxValue();
    Provider.of<CityViewModel>(context, listen: false).getcities();
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
        title: Text('Edit User'),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.only(
            top: 15,
            right: 15,
            left: 15,
          ),
          children: [
            TextFormField(
              controller: fullnameCtrl,
              validator: (value) => value!.isEmpty ? AllText.validator : null,
              decoration: InputDecoration(
                label: Text(AllText.fullname),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: usernameCtrl,
              validator: (value) => value!.isEmpty ? AllText.validator : null,
              decoration: InputDecoration(
                label: Text(AllText.username),
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordCtrl,
              obscureText: true,
              validator: (value) => value!.isEmpty ? AllText.validator : null,
              decoration: InputDecoration(
                label: Text(AllText.password),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              validator: (value) => value!.isEmpty ? AllText.validator : null,
              decoration: InputDecoration(
                label: Text(AllText.phone),
              ),
            ),
            const SizedBox(height: 15),
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
            const SizedBox(height: 25),
            ButtonLogin(
              text: 'Send',
              onPressed: (() {
                if (formKey.currentState!.validate()) {
                  if (categoryViewModel.idCategory.isEmpty &&
                      cityViewModel.radioValue == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('category dan city required!'),
                      ),
                    );
                  } else {
                    userViewModel.editUsers(
                      id: userViewModel.userLogin['id'],
                      fullname: fullnameCtrl.text,
                      username: usernameCtrl.text,
                      email: emailCtrl.text,
                      password: passwordCtrl.text,
                      phone: phoneCtrl.text,
                      city: cityViewModel.radioValue,
                      category: categoryViewModel.idCategory.toString(),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                      (route) => false,
                    );
                  }
                }
              }),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
