import 'package:cakang/view/menu/home/home_screen.dart';
import 'package:cakang/view/menu/profile/not_login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: ((context, index) {
        return CupertinoTabView(
          builder: (context) {
            return Column(
              children: [
                if (index == 0) ...[
                  const Expanded(
                    child: HomeScreen(),
                  ),
                ] else if (index == 1) ...[
                  const Expanded(
                    child: LoginScreen(),
                  ),
                ]
              ],
            );
          },
        );
      }),
    );
  }
}
