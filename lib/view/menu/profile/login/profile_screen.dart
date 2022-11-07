import 'package:cakang/utils/pallete.dart';
import 'package:cakang/view/menu/profile/login/edit_profile_screen.dart';
import 'package:cakang/view/menu/profile/login/widget/listtile.dart';
import 'package:cakang/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<UserViewModel>(context, listen: false).fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(
      context,
      listen: false,
    );

    dialogLogout() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text('Are you sure?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () => userViewModel.logout(context),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AllText.profile),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('edit'),
                onTap: () {
                  Future.delayed(
                    const Duration(seconds: 0),
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Consumer<UserViewModel>(
                          builder: (context, value, _) => EditProfileScreen(
                            id: userViewModel.userLogin['id'],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: const Text('delete'),
                onTap: () {
                  Future.delayed(
                    const Duration(seconds: 0),
                    () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: const Text('Are you sure?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: (() {
                              userViewModel.deleteUsers(
                                id: userViewModel.userLogin['id'],
                                context: context,
                              );
                              // categoryViewModel.deleteCategories(
                              //   id: category.id,
                              // );
                              // categoryViewModel.getCategories();
                              // Navigator.pop(context);
                              // Navigator.popUntil(context, (route) => route.isFirst);
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: ((context) => const CategoryScreen()),
                              //   ),
                              // );
                            }),
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: Consumer<UserViewModel>(
        builder: (context, value, _) => ListView(
          padding: const EdgeInsets.only(
            top: 10,
            right: 15,
            left: 15,
          ),
          children: [
            CircleAvatar(
              backgroundColor: AllColor.primaryColor,
              radius: kToolbarHeight,
              child: const Icon(Icons.person, size: 60),
            ),
            const SizedBox(height: 15),
            TileInfo(
              text: userViewModel.userLogin['fullname'],
              icon: Icon(Icons.person),
              bgTile: AllColor.primaryColor,
            ),
            const SizedBox(height: 15),
            TileInfo(
              text: userViewModel.userLogin['email'],
              icon: Icon(Icons.mail),
              bgTile: AllColor.primaryColor,
            ),
            const SizedBox(height: 15),
            TileInfo(
              text: userViewModel.userLogin['phone'],
              icon: Icon(Icons.phone),
              bgTile: AllColor.primaryColor,
            ),
            const SizedBox(height: 15),
            TileInfo(
              text: AllText.logout,
              icon: Icon(Icons.logout),
              bgTile: AllColor.errorColor,
              onTap: (() => dialogLogout()),
            ),
          ],
        ),
      ),
    );
  }
}
