import 'package:cakang/utils/theme.dart';
import 'package:cakang/view/menu/main_screen.dart';
import 'package:cakang/view_model/category_view_model.dart';
import 'package:cakang/view_model/city_view_model.dart';
import 'package:cakang/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => UserViewModel())),
        ChangeNotifierProvider(create: ((context) => CategoryViewModel())),
        ChangeNotifierProvider(create: ((context) => CityViewModel())),
      ],
      child: MaterialApp(
        // title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: myTheme,
        home: const MainScreen(),
      ),
    );
  }
}

// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   //inisialize countryname
//   String? countryName;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Dropdown Search"),
//         ),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 DropdownSearch(
//                   items: ["Brazil", "France", "Tunisia", "Canada"],
//                   // dropdownSearchDecoration: InputDecoration(labelText: "Name"),
//                   onChanged: ((value) {
//                     setState(() {
//                       countryName = value;
//                     });
//                   }),
//                   selectedItem: "Tunisia",
//                   validator: (String? item) {
//                     if (item == null)
//                       return "Required field";
//                     else if (item == "Brazil")
//                       return "Invalid item";
//                     else
//                       return null;
//                   },
//                 ),
//                 // DropdownSearch<String>(
//                 //   mode: Mode.MENU,
//                 //   showSelectedItems: true,
//                 //   //country data as item
//                 //   items: ["Brazil", "Itali", "Tunisia", 'Canada'],

//                 //   //you can design input decroration here as you want
//                 //   dropdownSearchDecoration: InputDecoration(
//                 //     labelText: "Country Dropdown",
//                 //     hintText: "Select Country",
//                 //   ),

//                 //   //what you can after clicked item
//                 //   onChanged: (text) {
//                 //     setState(() {
//                 //       countryName = text;
//                 //     });
//                 //   },
//                 //   showSearchBox: true,
//                 // ),
//                 SizedBox(
//                   height: 10,
//                 ),

//                 //show item clicked in text
//                 Text(
//                   "You choose ${countryName}",
//                   style: TextStyle(fontSize: 20),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
