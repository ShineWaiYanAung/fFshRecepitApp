import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kg6_project/Bloc/cart_bloc.dart';
import 'package:kg6_project/CubitBloc/usernameHander_cubit.dart';
import 'package:kg6_project/HiveTransaction/transaction.dart';
import 'package:kg6_project/Screen/FishCategory.dart';
import 'Item/fish_category.dart';
import 'Screen/homeScreen.dart';

Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(FishNameAdapter());
  await Hive.openBox<Transaction>('invoice');
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NamingCubit(),),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Money Receipt App',
        home: BlocBuilder<NamingCubit,String>(
          builder: (context,username) {
            if(username.isEmpty){
              return HomeScreen();
            }
              return CategoryPage();
          }
        ),
      ),
    );
  }
}
