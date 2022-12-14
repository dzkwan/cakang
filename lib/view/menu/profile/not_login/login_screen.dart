import 'package:cakang/utils/pallete.dart';
import 'package:cakang/view/menu/profile/not_login/register_screen.dart';
import 'package:cakang/view/menu/profile/not_login/widget/button_login.dart';
import 'package:cakang/view/menu/profile/not_login/widget/text_button.dart';
import 'package:cakang/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  @override
  void initState() {
    Provider.of<UserViewModel>(context, listen: false).checkLogin(context);
    super.initState();
  }

  @override
  void dispose() {
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(AllText.title),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.only(
            top: 10,
            right: 15,
            left: 15,
          ),
          children: [
            Text(
              AllText.login,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600),
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
              controller: passwordCtrl,
              obscureText: true,
              validator: (value) => value!.isEmpty ? AllText.validator : null,
              decoration: InputDecoration(
                label: Text(AllText.password),
              ),
            ),
            const SizedBox(height: 30),
            ButtonLogin(
              text: AllText.login,
              onPressed: (() {
                if (formKey.currentState!.validate()) {
                  userViewModel.loginUsers(
                    username: usernameCtrl.text,
                    password: passwordCtrl.text,
                    context: context,
                  );
                }
              }),
            ),
            const SizedBox(height: 30),
            TextBtnAccount(
              text: 'Belum punya akun? ',
              textButton: 'Daftar Sekarang',
              moveScreen: const RegisterScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
