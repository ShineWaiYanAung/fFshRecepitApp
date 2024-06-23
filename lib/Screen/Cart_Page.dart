import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kg6_project/Bloc/cart_bloc.dart';

import '../Theme/app_color.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable default leading icon
        flexibleSpace: Container(
          color: AppColor.secondColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios,
                      size: 30, color: Colors.white),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.2),
              const Padding(
                padding: EdgeInsets.only(top: 50.0, bottom: 0),
                child: Text(
                  "တန်ချိန်များ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state.cartItems.isNotEmpty) {
          return ListView.builder(
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              final items = state.cartItems[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shadowColor: Colors.black,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black26,
                      child: Text('${index+1}'),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          items.name,
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        Text(
                          items.data.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ],
                    ),
                    trailing: IconButton(onPressed: (){},
                    icon: Icon(Icons.delete,color: Colors.red,),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text("တန်ချိန်များမ မှတ်ကသေးပါ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w200),),
          );
        }
      }),
    );
  }
}
