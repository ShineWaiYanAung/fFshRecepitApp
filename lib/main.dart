import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kg6_project/Bloc/cart_bloc.dart';
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
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: const MaterialApp(
        title: 'Money Recepit App',
        home: HomeScreen(),
      ),
    );
  }
}
