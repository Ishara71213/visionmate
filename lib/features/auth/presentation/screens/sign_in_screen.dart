import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/screens/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return Text("authenticated");
                    } else if (state is UnAuthenticated) {
                      return Text("un authenticated");
                    } else {
                      return Text("loading");
                    }
                  },
                ),
                Image.asset(
                  "assets/images/signin-page-image.png",
                  alignment: Alignment.center,
                  scale: 1,
                ),
                Form(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        onSubmitted: (String userName) {},
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                            hintText: "User Name",
                            hintStyle: kInputFieldHintText,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: kLightGreyColor))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TextField(
                        onSubmitted: (String userName) {},
                        textInputAction: TextInputAction.send,
                        decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: kInputFieldHintText,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                    color: kLightGreyColor))),
                      ),
                    ),
                    FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: kButtonPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0))),
                        child: Text("Sign In", style: kFilledButtonTextstyle))
                  ],
                )),
                const SizedBox(
                  height: 16.0,
                ),
                const SizedBox(
                  height: 44.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 80.0,
                      height: 1.0,
                      child: Container(
                        color: kLightGreyColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(" Or continue with",
                          style: kDarkGreySmalltextStyle),
                    ),
                    SizedBox(
                      width: 80.0,
                      height: 1.0,
                      child: Container(
                        color: kLightGreyColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 38.0,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/Google__G__Logo 2.svg'),
                      const SizedBox(
                        width: 26.0,
                      ),
                      Image.asset(
                        "assets/icons/facebookIcon.png",
                        alignment: Alignment.center,
                        scale: 1,
                      ),
                      const SizedBox(
                        width: 26.0,
                      ),
                      Image.asset(
                        'assets/icons/appleIcon.png',
                        alignment: Alignment.center,
                        scale: 1,
                      )
                    ]),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: kBlackSmalltextStyle),
                      const SizedBox(width: 4.0),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, "/signUpScreen", (route) => false);
                          },
                          child: Text(
                            "Sign Up",
                            style: kBlueSmalltextStyle,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
