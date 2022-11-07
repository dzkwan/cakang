import 'package:cakang/utils/pallete.dart';
import 'package:cakang/view_model/city_view_model.dart';
import 'package:cakang/view_model/user_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key,});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    Provider.of<UserViewModel>(context, listen: false).getUsers();
    Provider.of<CityViewModel>(context, listen: false).searchCity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(
      context,
      listen: false,
    );
    final cityViewModel = Provider.of<CityViewModel>(
      context,
      listen: false,
    );

    bottomSheetUser(user) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.account_circle, size: kToolbarHeight),
                title: Text(user.fullname),
                subtitle: Text(user.email),
              ),
              SizedBox(
                height: kToolbarHeight,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: user.category.length,
                  itemBuilder: (context, index) {
                    final category = user.category[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(label: Text(category)),
                    );
                  },
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AllColor.green),
                ),
                onPressed: () {
                  userViewModel.openWhatsapp(phone: user.phone);
                },
                child: Text('Whatsapp'),
              ),
              SizedBox(height: 120),
            ],
          );
        },
      );
    }

    Widget dataList() {
      return userViewModel.selectedItem == null
          ? SizedBox()
          : ListView.builder(
              padding: const EdgeInsets.only(
                top: 15,
                right: 10,
                left: 10,
                bottom: 50,
              ),
              itemCount: userViewModel.filterUser.length,
              itemBuilder: (context, index) {
                // print('${userViewModel.filterUser}');
                final user = userViewModel.filterUser[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    leading:
                        const Icon(Icons.account_circle, size: kToolbarHeight),
                    title: Text(user.fullname),
                    subtitle: Text(user.city),
                    onTap: () => bottomSheetUser(user),
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
                  child: SizedBox(
                    height: 40,
                    child: Consumer<CityViewModel>(
                      builder: (context, value, _) {
                        // print('${userViewModel.filterUsers("Jakarta")}');
                        return DropdownSearch(
                          items: cityViewModel.cityName,
                          onChanged: (value) {
                            // print(value);
                            userViewModel.filterUsers(value);
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              // label: Text(AllText.city),
                              hintText: 'pilih kota',
                            ),
                          ),
                          dropdownButtonProps: DropdownButtonProps(
                            // splashRadius: 0,
                            color: AllColor.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
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
