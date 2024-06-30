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
            Map<String, FishName> mergedMap = {};

            // Add the fishList to the map, updating the data if the name and price already exist
            for (var fish in cartItems) {
              String key = '${fish.name}-${fish.price}';
              if (mergedMap.containsKey(key)) {
                mergedMap[key] = FishName(
                  name: fish.name,
                  data: mergedMap[key]!.data! + fish.data!,
                  price: fish.price,
                );
              } else {
                mergedMap[key] = FishName(
                  name: fish.name,
                  data: fish.data!,
                  price: fish.price!,
                );
              }
            }

            List<FishName> mergedList = mergedMap.values.toList();

              final String totalPrice = mergedList.fold<double>(0, (previousValue,newValue)=>
              previousValue + (newValue.data!*newValue.price!)
              ).toString();

            if (mergedList.isNotEmpty) {

              return Center(
                child: Container(
                  padding: EdgeInsets.only(top: 40, right: 20,left: 20),
                  width: 360,
                 // height: index<2 ? 250 : 150 * (index - (index<=3? 0.0 :3)),
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
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ငါးအမည်",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 15),
                              ),
                              Text(
                                "တန်ချိန်",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 15),
                              ),
                              Text(
                                "တန်ဖိုး",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize:15),
                              ),
                            ],
                          ),
                          Divider(
                            height: 30,
                            thickness: 2,
                            color: Colors.black,
                          ),
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  children: List.generate(mergedList.length, (index) {
                                    var item = mergedList[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            child: Text('${index + 1}.${item.name}'), // Display index + 1 for counting number
                                          ),
                                          Text("${item.data.toString()}kg"),
                                          Text("${item.price.toString()}ကျပ်"),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                                Divider(
                                  height: 30,
                                  thickness: 2,
                                  color: Colors.black,
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("စုစုပေါင်းကျပ်ငွေ           ${totalPrice}ကျပ်")),
                                Text(
                                  _currentDate,
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
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
