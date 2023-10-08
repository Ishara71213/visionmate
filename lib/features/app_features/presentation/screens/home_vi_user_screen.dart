import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class HomeViUserScreen extends StatefulWidget {
  const HomeViUserScreen({super.key});

  @override
  State<HomeViUserScreen> createState() => _HomeViUserScreenState();
}

class _HomeViUserScreenState extends State<HomeViUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<UserCubit>(context).resetToInitialState();
                      BlocProvider.of<AuthCubit>(context).signOut();
                    },
                    icon: Icon(
                      Icons.menu_rounded,
                      size: 40,
                      color: kPrimaryColor,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/signInScreen", (route) => false);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: kLightGreyColor,
                        borderRadius: BorderRadius.circular(50)),
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    child: const Icon(
                      Icons.supervised_user_circle_outlined,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  FilledButtonCustom(
                    onPressed: () {},
                    initText: "Object Detection",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButtonCustom(
                    onPressed: () {},
                    initText: "Color Detection",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButtonCustom(
                    onPressed: () {},
                    initText: "Text to Speech",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButtonCustom(
                    onPressed: () {},
                    initText: "Connect Cane",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FilledButtonCustom(
                    onPressed: () {},
                    initText: "Navigation Assistance",
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: const BottomNavBar(
        selectedIndex: 5,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
