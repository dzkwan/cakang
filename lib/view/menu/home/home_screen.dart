import 'package:cakang/utils/pallete.dart';
import 'package:cakang/view/search/search_screen.dart';
import 'package:cakang/view_model/city_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<CityViewModel>(context, listen: false).getcities();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cityViewModel = Provider.of<CityViewModel>(
      context,
      listen: false,
    );

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            title: Text(AllText.title),
            pinned: true,
            floating: true,
            bottom: PreferredSize(
              preferredSize: const Size(double.infinity, 60),
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
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ),
                      );
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'Search',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        body: ListView(
          padding: EdgeInsets.only(
            top: 15,
            right: 10,
            left: 10,
            bottom: 10,
          ),
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 123, 198, 255),
                      Color.fromARGB(255, 116, 181, 255),
                    ],
                  ),
                ),
                child: Text(
                  'Cara Baru Temukan Teknisi',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            Consumer<CityViewModel>(
              builder: (context, value, _) => GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: cityViewModel.cities.length,
                itemBuilder: (context, index) {
                  final city = cityViewModel.cities[index];
                  return GestureDetector(
                    child: Card(
                      child: GridTile(
                        child: Image.asset(
                          'assets/city/${city.image}',
                          fit: BoxFit.cover,
                        ),
                        footer: GridTileBar(
                          title: Text(
                            city.name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          backgroundColor: AllColor.outlineBorder,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
