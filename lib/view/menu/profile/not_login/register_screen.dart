import 'package:cakang/utils/pallete.dart';
import 'package:cakang/view/menu/profile/not_login/widget/button_login.dart';
import 'package:cakang/view/menu/profile/not_login/widget/text_button.dart';
import 'package:cakang/view_model/category_view_model.dart';
import 'package:cakang/view_model/city_view_model.dart';
import 'package:cakang/view_model/user_view_model.dart';
import 'package:email_validator/email_validator.dart';
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

  @override
  void initState() {
    Provider.of<CategoryViewModel>(context, listen: false)
        .categoriesCheckboxValue();
    Provider.of<CityViewModel>(context, listen: false).getcities();
    super.initState();
  }

  @override
  void dispose() {
    fullnameCtrl.dispose();
    usernameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
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
          padding: const EdgeInsets.only(
            top: 10,
            right: 15,
            left: 15,
          ),
          children: [
            Text(
              AllText.register,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
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
                            physics: NeverScrollableScrollPhysics(),
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
                            physics: NeverScrollableScrollPhysics(),
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
              text: AllText.register,
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
            const SizedBox(height: 30),
            TextBtnAccount(
              text: 'Sudah punya akun? ',
              textButton: 'Masuk',
              moveScreen: const LoginScreen(),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
