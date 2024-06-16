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
          ),
        ),
      ),
      body: Expanded(
        child: GridView.builder(
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: FishCategory.fishCateo.length,
            itemBuilder: (context, index) {
              final fishName = FishCategory.fishCateo[index];
              return Chip(label: Text(fishName.name.toString(),),);
            },)
      ),
    );
  }
}
