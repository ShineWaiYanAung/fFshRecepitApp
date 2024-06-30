import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kg6_project/CubitBloc/usernameHander_cubit.dart';
import 'package:kg6_project/Screen/FishCategory.dart';
import 'package:kg6_project/Theme/app_color.dart';
import 'dart:ui';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final TextEditingController userName = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: width,
              height: height * 0.45,
              child: Image.asset("assets/homeScreenImage/homeScreenIcon.png"),
            ),
            Container(
              width: width,
              height: height * 0.55,
              decoration: BoxDecoration(
                color: AppColor.secondColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 80, right: 80, top: 80, bottom: 100),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: userName,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                        hintText: "Name",
                        hintStyle: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      onSubmitted: (value) {
                        _handleStartButton(context, userName.text);
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _handleStartButton(context, userName.text);
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                          color: AppColor.textColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleStartButton(BuildContext context, String userName) {
    if (userName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Name cannot be empty"),
        ),
      );
    } else {
      context.read<NamingCubit>().saveUsername(userName);
      Navigator.of(context).push(

        MaterialPageRoute(
          builder: (context) => const CategoryPage(),
        ),
      );
    }
  }
}
