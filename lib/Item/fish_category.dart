import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:kg6_project/Bloc/cart_bloc.dart';
import '../Theme/app_color.dart';
import 'package:hive/hive.dart';
part 'fish_category.g.dart';

class FishCategory {
  static List<FishName> fishCateo = [
    FishName(name: 'ငါးကြင်း'),
    FishName(name: 'ငါးဖယ်'),
    FishName(name: 'ပါကူး'),
    FishName(name: 'ငါးဒန်'),
    FishName(name: "ငါးမြင့်ချင်း"),
    FishName(name: "ဇလားဗီးယား"),
  ];
  static void handleErrorState(
      BuildContext context, String message, bool errorState) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: errorState ? Colors.green : Colors.red,
        content: Text("$message"),
      ),
    );
  }
}

@HiveType(typeId: 1)
class FishName {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final double? data;

  @HiveField(2)
  final double? price;

  FishName({required this.name, this.data, this.price});

  @override
  String toString() {
    return '$name, data: $data';
  }
}


class FishListingItems extends StatefulWidget {
  final FishName items;
  const FishListingItems({
    super.key,
    required this.items,
  });

  @override
  State<FishListingItems> createState() => _FishListingItemsState();
}

class _FishListingItemsState extends State<FishListingItems> {
  final TextEditingController dataController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  bool isPressed = true;

  @override
  void dispose(){
    dataController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Offset distance = isPressed ? Offset(10, 10) : Offset(28, 28);
    double blur = isPressed ? 15.0 : 30.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isPressed = !isPressed;
            print(isPressed);
            showAddToCartDilog(widget.items);
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: AppColor.primaryColor,
            boxShadow: [
              BoxShadow(
                blurRadius: blur,
                color: Colors.white.withOpacity(0.1),
                inset: isPressed,
                offset: -distance,
              ),
              BoxShadow(
                blurRadius: blur,
                color: Color(0xFFA7A9AF),
                offset: distance,
                inset: isPressed,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.items.name,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: AppColor.textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showAddToCartDilog(FishName itemName) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(itemName.name),
          titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColor.textColor,
              fontSize: 30),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: dataController,
                  decoration: InputDecoration(
                    hintText: "ကုန်ချိန်",
                    prefix: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text('Kg'),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    hintText: "တန်ဖိုး",
                    prefixText: "MMK",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.black26,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    ///Data Adding
                    if (dataController.text.isNotEmpty &&
                        priceController.text.isNotEmpty &&
                        RegExp(r'^\d*\.?\d+$').hasMatch(dataController.text) &&
                        RegExp(r'^\d*\.?\d+$').hasMatch(priceController.text)) {
                      setState(() {
                        double data = double.parse(dataController.text);
                        double price= double.parse(priceController.text);
                        String name = itemName.name.toString();
                        List<FishName> itemCart = [
                          FishName(name: name, data: data,price: price)
                        ];
                        isPressed = !isPressed;
                        print(itemCart);
                        final cartBloc = context.read<CartBloc>();
                        cartBloc.add(CartIncrement(itemCart[0]));
                        dataController.text = '';
                        priceController.text= '';
                      });
                      Navigator.of(context).pop();
                      FishCategory.handleErrorState(
                          context, 'စာရင်းမှတ်လိုက်ပါပီ', true);
                    } else if (dataController.text.isEmpty||priceController.text.isEmpty) {
                      setState(() {
                        dataController.text = '';
                        priceController.text= '';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("သင်တန်ချိန်မထည့်ကသေးပါ"),
                        ),
                      );
                    } else if (!RegExp(r'^\d*\.?\d+$')
                            .hasMatch(dataController.text) ||
                        !RegExp(r'^\d*\.?\d+$')
                            .hasMatch(priceController.text)) {
                      setState(() {
                        dataController.text = '';
                        priceController.text = '';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text("ဂဏန်းပဲထည့်ပေးပါ"),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'မှတ်ရန်',
                    style: TextStyle(
                        color: AppColor.textColor, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      isPressed = !isPressed;
                    });
                  },
                  child: Text(
                    'ပြန်သွားရန်',
                    style: TextStyle(color: AppColor.textColor),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
