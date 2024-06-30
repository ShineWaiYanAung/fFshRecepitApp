import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kg6_project/Bloc/cart_bloc.dart';
import 'package:kg6_project/CubitBloc/usernameHander_cubit.dart';
import 'package:kg6_project/Screen/FishCategory.dart';
import 'Screen/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
