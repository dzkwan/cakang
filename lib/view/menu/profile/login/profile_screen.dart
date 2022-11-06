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
          padding: EdgeInsets.only(
            top: 10,
            right: 15,
            left: 15,
          ),
          children: [
            CircleAvatar(
              backgroundColor: AllColor.primaryColor,
              child: Icon(Icons.person, size: 60),
              radius: kToolbarHeight,
            ),
            SizedBox(height: 15),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AllColor.primaryColor,
                child: Icon(Icons.person),
                radius: kRadialReactionRadius,
              ),
              title: Text(userViewModel.userLogin['fullname']),
              // Text(userViewModel.userLogin['fullname']),
            ),
            SizedBox(height: 15),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AllColor.primaryColor,
                child: Icon(Icons.mail),
                radius: kRadialReactionRadius,
              ),
              title: Text(userViewModel.userLogin['email']),
              // title: Text(userViewModel.userLogin['email']),
            ),
            SizedBox(height: 15),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AllColor.primaryColor,
                child: Icon(Icons.phone),
                radius: kRadialReactionRadius,
              ),
              title: Text(userViewModel.userLogin['phone']),
              // title: Text(userViewModel.userLogin['phone']),
            ),
            SizedBox(height: 15),
            ListTile(
              title: Text('Logout'),
              tileColor: AllColor.bgErrorColor,
              leading: CircleAvatar(
                backgroundColor: AllColor.errorColor,
                child: Icon(
                  Icons.logout,
                  color: AllColor.bgErrorColor,
                ),
                radius: kRadialReactionRadius,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text('Are you sure?'),
                    actions: [
                      TextButton(
                        child: Text('No'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      TextButton(
                        child: Text('Yes'),
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
