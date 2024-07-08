import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kg6_project/Bloc/cart_bloc.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:intl/intl.dart';

import '../CubitBloc/usernameHander_cubit.dart';
import '../Item/fish_category.dart';
import '../Theme/app_color.dart';


class CheckList extends StatefulWidget {
  const CheckList({super.key});

  @override
  State<CheckList> createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  String _currentDate = '';
  List<FishName> mergedList = [];
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
        backgroundColor: AppColor.secondColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 35,),
        ),
        title: const Text(
          "ကုန်ချိန်မှတ်တမ်း",
          style: TextStyle( color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onDoubleTap: () {
              if (mergedList.isNotEmpty) {
                FishCategory.handleErrorState(
                    context, 'သင့်စာရင်းမှတ်ပီးပီ', true);
             final cubitAddInvoice=   context.read<CartBloc>();
                    cubitAddInvoice.addTranscation(mergedList);
              }
              else if(mergedList.isEmpty){
                FishCategory.handleErrorState(
                    context, 'သင့်စာရင်းမရှိပါ', false);
              }
            },
            child:  Icon(Icons.add_box,color: Colors.white,size: 35,),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Container(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final cartItems = state.cartItems;
            Map<String, FishName> mergedMap = {};

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

            mergedList = mergedMap.values.toList();

            final String totalPrice = mergedList
                .fold<double>(
                    0,
                    (previousValue, newValue) =>
                        previousValue + (newValue.data! * newValue.price!))
                .toString();

            if (mergedList.isNotEmpty) {
              return Center(
                child: Container(
                  padding: EdgeInsets.only(top: 40, right: 20, left: 20),
                  width: 360,
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Row(
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
                                  fontWeight: FontWeight.w800, fontSize: 15),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 30,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                children:
                                    List.generate(mergedList.length, (index) {
                                  var item = mergedList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                              '${index + 1}.${item.name}'), // Display index + 1 for counting number
                                        ),
                                        Text("${item.data.toString()}kg"),
                                        Text("${item.price.toString()}ကျပ်"),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                              const Divider(
                                height: 30,
                                thickness: 2,
                                color: Colors.black,
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      "စုစုပေါင်းကျပ်ငွေ           ${totalPrice}ကျပ်")),
                              Text(
                                _currentDate,
                                style: const TextStyle(
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
              );
            } else {
              return const Center(
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
