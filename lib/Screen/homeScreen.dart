import 'package:flutter/material.dart';
import 'package:kg6_project/Theme/app_color.dart';
import 'dart:ui';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                boxShadow: const[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4)
                  )
                ]
              ),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 80, right: 80, top: 80, bottom: 380),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, // Adjust the shadow color
                        blurRadius: 10, // Adjust the blur radius
                        offset: Offset(0, 4), // Adjust the offset
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Apply same border radius to ClipRRect
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust the blur intensity
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          hintText: "Name",
                          hintStyle: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w500
                          ),
                          // Adjust the opacity for the blur effect
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
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
