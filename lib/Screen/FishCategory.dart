import 'package:flutter/material.dart';
import 'package:kg6_project/Item/fish_category.dart';
import 'package:kg6_project/Theme/app_color.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100), // Set the desired height
        child: AppBar(
          flexibleSpace: Container(
            color: AppColor.secondColor,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text("K G - 6",style: TextStyle(color: Colors.white,fontSize: 52,fontWeight: FontWeight.w800,),),
              ),
            ),

          ),
        ),

      ),
      drawer: Icon(Icons.menu),
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
          )),
        ],
      ),
      floatingActionButton: buildShoppingBag(),
    );
  }
  ///ShopingBag
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
                   offset: Offset(1,1),
                   color: Colors.black26
                 )
               ],
               size: 100, // Adjust the size as needed
             ),
           ),
         ),
       ),
     ],
    );
  }

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
                )
              ]),
          child: const Text(
            "ငါးအမျိုးအစားများ",
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 35,
                color: Colors.white),
          ),
        );
  }
  ///Fish Item
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
                      offset: Offset(2,2)
                    ),
                    const BoxShadow(
                        blurRadius: 10,
                        color:Colors.black12,
                        offset: Offset(2,2)
                    )
                  ]
                ),
                child: Center(
                  child: Text(
                    fishName.name.toString(),style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.white),
                  ),
                ),
              ),
            );
  }
}
