import 'package:cakang/utils/pallete.dart';
import 'package:cakang/view/menu/profile/login/profile_screen.dart';
import 'package:cakang/view/menu/profile/not_login/register_screen.dart';
import 'package:cakang/view/menu/profile/not_login/widget/button_login.dart';
import 'package:cakang/view_model/category_view_model.dart';
import 'package:cakang/view_model/city_view_model.dart';
import 'package:cakang/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
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
    Provider.of<UserViewModel>(context,listen: false).checkLogin(context);
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
    // final categoryViewModel = Provider.of<CategoryViewModel>(
    //   context,
    //   listen: false,
    // );
    // final cityViewModel = Provider.of<CityViewModel>(
    //   context,
    //   listen: false,
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text(AllText.title),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: ListView(
          padding: EdgeInsets.only(
            top: 10,
            right: 15,
            left: 15,
          ),
          children: [
            Text(
              AllText.login,
              // overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600),
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
              controller: passwordCtrl,
              validator: (value) => value!.isEmpty ? AllText.validator : null,
              decoration: InputDecoration(
                label: Text(AllText.password),
              ),
            ),
            SizedBox(height: 30),
            ButtonLogin(
              text: AllText.login,
              onPressed: (() {
                if (formKey.currentState!.validate()) {
                  userViewModel.loginUsers(
                    username: usernameCtrl.text,
                    password: passwordCtrl.text,
                    context: context,
                  );
                  // ScaffoldMessenger.of(context).showSnackBar();
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ProfileScreen(),
                  //   ),
                  //   (route) => false,
                  // );
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => AlertDialog(
                  //     content: Consumer<UserViewModel>(
                  //       builder: (context, value, child) {
                  //         return Text('${userViewModel.userLogin}');
                  //       },
                  //       // child: Text(
                  //       //   data.toString(),
                  //       // ),
                  //     ),
                  //   ),
                  // );
                }
              }),
            ),
            // ElevatedButton(
            //   style: ButtonStyle(
            //     fixedSize: MaterialStatePropertyAll<Size>(
            //       Size(
            //         double.maxFinite,
            //         40,
            //       ),
            //     ),
            //   ),
            //   child: Text(AllText.login),
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
                    'Belum punya akun? ',
                    style: Theme.of(context).textTheme.overline,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => RegisterScreen()),
                        ((route) => false),
                      );
                    }),
                    child: Text(
                      'Daftar Sekarang',
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: AllColor.buttonColor,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
