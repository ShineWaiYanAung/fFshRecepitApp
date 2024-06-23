import 'package:flutter/material.dart';
import 'package:kg6_project/Item/fish_category.dart';
import 'package:kg6_project/Theme/app_color.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    final  width =  MediaQuery.of(context).size.width ;
    final  height = MediaQuery.of(context).size.height;
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
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            //DrawerHeader
            Container(
              width: width,
              height: height *0.3,
              decoration: BoxDecoration(
                color: AppColor.secondColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50)
                )
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 50,child: Image.asset("assets/homeScreenImage/homeScreenIcon.png"),),
                    const SizedBox(height: 20,),
                    const Text("ShineWaiYanAung",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),),
                  ],
              ),
            ),
            //PlacesToGo
            const SizedBox(height: 30,),
            Card(
              color: AppColor.secondColor,
              child: const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                leading: Icon(Icons.history,color: Colors.white,),
                title: Text('စာရင်းများကြည့်ရန်',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),),),
            const SizedBox(height: 30,),
            Card(
              color: AppColor.secondColor,
              child: const ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 50),
                leading: Icon(Icons.shopping_bag,color: Colors.white,),
                title: Text('ထည့်ပီးသားပစ္စည်း',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),),),

          ],
        )
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          buildTitle(),
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
                final fishName = FishCategory.fishCateo[index];
                return buildItem(fishName);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: buildShoppingBag(),
    );
  }

  /// Shopping Bag
  Widget buildShoppingBag() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent, // No background color
            elevation: 0, // No shadow
            onPressed: () {},
            child: Container(
              width: 100, // Adjust the size as needed
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                // Add background color to container if needed
              ),
              child: Icon(
                Icons.shopping_bag,
                color: AppColor.secondColor,
                shadows: const [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(1, 1),
                    color: Colors.black26,
                  ),
                ],
                size: 100, // Adjust the size as needed
              ),
            ),
          ),
        ),
      ],
    );
  }
  ///FishCategory
  Widget buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColor.secondColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.black12,
            offset: Offset(1, 1),
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
    );
  }

  /// Fish Item
  Widget buildItem(FishName fishName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.secondColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: AppColor.secondColor,
              offset: Offset(2, 2),
            ),
            const BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            fishName.name.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
