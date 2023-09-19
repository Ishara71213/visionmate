import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';

class UserFrequentlyVisitingLocationsInfoScreen extends StatefulWidget {
  const UserFrequentlyVisitingLocationsInfoScreen({super.key});

  @override
  State<UserFrequentlyVisitingLocationsInfoScreen> createState() =>
      _UserFrequentlyVisitingLocationsInfoScreenState();
}

class _UserFrequentlyVisitingLocationsInfoScreenState
    extends State<UserFrequentlyVisitingLocationsInfoScreen> {
  final GlobalKey<FormState> formKeyEmergencyContact = GlobalKey<FormState>();
  final TextEditingController _guardianEmailController =
      TextEditingController();
  bool agree = false;

  @override
  void dispose() {
    _guardianEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is UserSuccess) {
          await Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteConst.homeScreen, (route) => false);
            BlocProvider.of<AuthCubit>(context).appStarted();
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            iconSize: 30,
            splashRadius: 1,
            padding: const EdgeInsets.only(top: 20),
          ),
          leadingWidth: 80,
          elevation: 0,
          toolbarHeight: 50,
          backgroundColor: kAppBgColor,
          foregroundColor: kPrimaryColor,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/frequently-visiting-locations.svg",
                      alignment: Alignment.center,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Text(
                          'Setup frequently visiting locations',
                          style: kOnboardScreenTitle,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    FilledButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteConst.signInScreen, (route) => false);
                        },
                        style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(60),
                            backgroundColor: kButtonPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_circle),
                            const SizedBox(
                              width: 8,
                            ),
                            Text("Add More", style: kFilledButtonTextstyle),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Skip",
                    style: kBluetextStyle,
                  )),
              OutlinedButton(
                onPressed: () {
                  navigationHandler(
                      context, RouteConst.setVisualDisabilityScreen);
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: kPrimaryColor),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  primary: kPrimaryColor,
                ),
                child: Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      color: kPrimaryColor, shape: BoxShape.circle),
                  child: Icon(
                    Icons.navigate_next,
                    size: 40,
                    color: kLightGreyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
