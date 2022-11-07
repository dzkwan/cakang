import 'package:cakang/utils/pallete.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: Text(AllText.profile),
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
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AllColor.primaryColor,
                radius: kRadialReactionRadius,
                child: const Icon(Icons.person),
              ),
              title: Text(userViewModel.userLogin['fullname']),
              // Text(userViewModel.userLogin['fullname']),
            ),
            const SizedBox(height: 15),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AllColor.primaryColor,
                radius: kRadialReactionRadius,
                child: const Icon(Icons.mail),
              ),
              title: Text(userViewModel.userLogin['email']),
              // title: Text(userViewModel.userLogin['email']),
            ),
            const SizedBox(height: 15),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AllColor.primaryColor,
                radius: kRadialReactionRadius,
                child: const Icon(Icons.phone),
              ),
              title: Text(userViewModel.userLogin['phone']),
              // title: Text(userViewModel.userLogin['phone']),
            ),
            const SizedBox(height: 15),
            ListTile(
              title: const Text('Logout'),
              // tileColor: AllColor.bgErrorColor,
              leading: CircleAvatar(
                backgroundColor: AllColor.errorColor,
                radius: kRadialReactionRadius,
                child: Icon(
                  Icons.logout,
                  color: AllColor.bgErrorColor,
                ),
              ),
              onTap: () {
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
