import 'package:cakang/view/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            // toolbarHeight: 45,
            title: Text('Cakang'),
            pinned: true,
            floating: true,
            bottom: PreferredSize(
              preferredSize: Size(double.infinity, 60),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                  bottom: 10,
                ),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchScreen()),
                      );
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Search',
                    ),
                    // style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
          ),
        ],
        body: ListView(),
      ),
    );
  }
}