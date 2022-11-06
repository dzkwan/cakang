import 'package:cakang/utils/pallete.dart';
import 'package:cakang/view_model/user_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  void initState() {
    Provider.of<UserViewModel>(context,listen: false).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(
      context,
      listen: false,
    );

    Widget dataList() {
      return ListView.builder(
        padding: EdgeInsets.only(
          top: 15,
          right: 10,
          left: 10,
          bottom: 50,
        ),
        itemCount: userViewModel.users.length,
        itemBuilder: (context, index) {
          final user = userViewModel.users[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: Icon(Icons.account_circle, size: kToolbarHeight),
              title: Text(user.fullname),
              subtitle: Text(user.city),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownSearch(),
                ),
                // Expanded(
                //   child: Card(
                //     child: ExpansionTile(
                //       title: Text(AllText.city),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
      body: Consumer<UserViewModel>(
        builder: (context, value, _) => dataList(),
      ),
    );
  }
}
