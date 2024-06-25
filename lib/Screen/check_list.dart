import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kg6_project/Bloc/cart_bloc.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:intl/intl.dart';
import '../Item/fish_category.dart';

class CheckList extends StatefulWidget {
  const CheckList({super.key});

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  String _currentDate = '';
  @override
  void initState() {
    _updateDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Offset distance = Offset(10, 10);
    double blur = 15.0;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "ကုန်ချိန်မှတ်တမ်း",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: BlocBuilder<CartBloc, CartState>(
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
            List<FishName> mergedList = mergedMap.entries
                .map((entry) => FishName(name: entry.key, data: entry.value))
                .toList();
            if (mergedList.isNotEmpty) {
              double index = mergedList.length.toDouble();
              return Center(
                child: Container(
                  padding: EdgeInsets.only(top: 40, right: 30, left: 30),
                  width: 300,
                  height: index<2 ? 200 : 100 * (index - (index<=3?0.0 :0.8)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: blur,
                          color: Colors.white.withOpacity(0.1),
                          inset: true,
                          offset: -distance,
                        ),
                        BoxShadow(
                          blurRadius: blur,
                          color: Color(0xFFA7A9AF),
                          offset: distance,
                          inset: true,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ငါးအမည်",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                          Text(
                            "တန်ချိန်",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                        thickness: 2,
                        color: Colors.black,
                      ),
                      Column(
                        children: mergedList.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.name),
                                Text(item.data.toString()),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      Text(
                        _currentDate,
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  'သင်ရဲ့မှတ်တမ်းမမှတ်ကသေးပါ',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black26),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  void _updateDate() {
    setState(() {
      _currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    });
  }
}
