import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:kg6_project/Item/fish_category.dart';
import 'package:kg6_project/Screen/Cart_Page.dart';
import 'package:kg6_project/Screen/invoce_history.dart';
import 'package:kg6_project/Theme/app_color.dart';

import '../CubitBloc/usernameHander_cubit.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isPressed = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Set the desired height
        child: AppBar(
          automaticallyImplyLeading: false, // Disable default leading icon
          flexibleSpace: Container(
            color: AppColor.secondColor,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(Icons.menu, size: 50, color: Colors.white),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Text(
                    "K G - 6",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: buildDrawer(width, height),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: AppColor.secondColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 30,
                  color: Colors.black12,
                  offset: Offset(2, 2),
                ),
                BoxShadow(
                  blurRadius: 30,
                  color: Colors.black12,
                  offset: Offset(2, 2),
                ),
                BoxShadow(
                  blurRadius: 30,
                  color: Colors.black12,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: const Text(
              "ငါးအမျိုးအစားများ",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 35,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: FishCategory.fishCateo.length,
              itemBuilder: (context, index) {
                final fishItem = FishCategory.fishCateo[index];
                return FishListingItems(
                  items: fishItem,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: buildShoppingBag(),
    );
  }

  ///Drawer
  Drawer buildDrawer(double width, double height) {
    return Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            //DrawerHeader
            Container(
              width: width,
              height: height * 0.3,
              decoration: BoxDecoration(
                  color: AppColor.secondColor,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            onPressed: ()=>Navigator.of(context).pop(),
                            icon: Icon(Icons.arrow_back_ios,
                              color:  Theme.of(context).focusColor ,)),
                      ),
                      body: Center(
                        child: Hero(
                            tag: 'person',
                            child: Image.asset("assets/homeScreenImage/homeScreenIcon.png")),
                      ),
                    ),)),
                    child: Hero(
                      tag :'person',
                      child: CircleAvatar(
                        radius: 50,
                        child: Image.asset(
                            "assets/homeScreenImage/homeScreenIcon.png"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<NamingCubit, String>(
                      builder: (context, username) {
                    return Text(
                      username,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    );
                  }),
                ],
              ),
            ),
            //PlacesToGo
            const SizedBox(
              height: 30,
            ),
            Card(
              borderOnForeground: true,
              shadowColor: AppColor.secondColor,
              color: AppColor.secondColor,
              child: InkWell(
                onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => InvoiceHistory(),)),
                child: const ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 50),
                  leading: Icon(
                    Icons.history,
                    color: Colors.white,
                  ),
                  title: Text(
                    'စာရင်းများကြည့်ရန်',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Card(
              borderOnForeground: true,
              shadowColor: AppColor.secondColor,
              color: AppColor.secondColor,
              child: InkWell(
                onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartPage(),)),
                child: const ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 50),
                  leading: Icon(
                    Icons.shopping_bag,
                    color: Colors.white,
                  ),
                  title: Text(
                    'ထည့်ပီးသားပစ္စည်း',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  /// Shopping Bag
  Widget buildShoppingBag() {
    Offset distance = Offset(2, 1);
    double blur = 5.0;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(left: 20),
        child: IconButton(
          onPressed: () {
            final route = MaterialPageRoute(
              builder: (context) => CartPage(),
            );
            Navigator.of(context).push(route);
          },
          icon: Icon(
            Icons.shopping_bag,
            size: 100,
            color: AppColor.secondColor,
            shadows: [
              BoxShadow(
                blurRadius: blur,
                color: Colors.white.withOpacity(0.1),
                offset: -distance,
              ),
              BoxShadow(
                blurRadius: blur,
                color: Color(0xFFA7A9AF),
                offset: distance,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
