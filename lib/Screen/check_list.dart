import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kg6_project/Bloc/cart_bloc.dart';
import 'package:kg6_project/Bloc/cart_bloc.dart';

import '../Item/fish_category.dart';

class CheckList extends StatelessWidget {
  const CheckList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>Navigator.of(context).pop(),
          icon: Icon(Icons.ios_share),),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final cartItems = state.cartItems;
          Map<String, int> mergedMap = {};
      
          // Add the fishList to the map, updating the data if the name already exists
          for (var fish in cartItems) {
            if (mergedMap.containsKey(fish.name)) {
              mergedMap[fish.name] = mergedMap[fish.name]! + fish.data!;
            } else {
              mergedMap[fish.name] = fish.data!;
            }
          }
          List<FishName> mergedList = mergedMap.entries.map((entry) => FishName(name :entry.key,data:  entry.value)).toList();
      
      
          return ListView.builder(
            itemCount: mergedList.length,
            itemBuilder: (context, index) {
              final filteredItems = mergedList[index];
              return ListTile(
                  title: Text(filteredItems.name),
                  subtitle: Text(filteredItems.data.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
