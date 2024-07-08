import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import '../Item/fish_category.dart';

class FishDetailScreen extends StatelessWidget {
  final List<FishName> items;

  FishDetailScreen({required this.items});

  @override
  Widget build(BuildContext context) {
    Offset distance = Offset(10, 10);
    double blur = 15.0;
    Map<String, FishName> mergedMap = {};

    // Add the fishList to the map, updating the data if the name and price already exist
    for (var fish in items) {
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

    var mergedList = mergedMap.values.toList();

    final String totalPrice = mergedList
        .fold<double>(
            0,
            (previousValue, newValue) =>
                previousValue + (newValue.data! * newValue.price!))
        .toString();

    return Scaffold(
        appBar: AppBar(),
        body: Center(
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
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  Text(
                    "တန်ချိန်",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                  Text(
                    "တန်ဖိုး",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
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
                      children: List.generate(mergedList.length, (index) {
                        var item = mergedList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child:
                          Text("စုစုပေါင်းကျပ်ငွေ           ${totalPrice}ကျပ်"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
