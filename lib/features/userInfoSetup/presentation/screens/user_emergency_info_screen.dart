import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/core/entities/visually_impaired_user_entity.dart';
import 'package:visionmate/core/util/classes/cordinates.dart';
import 'package:visionmate/core/util/classes/visit_location.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';

class UserEmergencyInfoScreen extends StatefulWidget {
  const UserEmergencyInfoScreen({super.key});

  @override
  State<UserEmergencyInfoScreen> createState() =>
      _UserEmergencyInfoScreenState();
}

class _UserEmergencyInfoScreenState extends State<UserEmergencyInfoScreen> {
  final GlobalKey<FormState> formKeyEmergencyContact = GlobalKey<FormState>();
  final TextEditingController _emergencyContactNameController =
      TextEditingController();
  final TextEditingController _emergencyContactController =
      TextEditingController();

  @override
  void dispose() {
    _emergencyContactNameController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is UserSuccess) {
          await Future.delayed(const Duration(seconds: 1), () {
            // Navigator.pushNamedAndRemoveUntil(
            //     context, RouteConst.homeScreen, (route) => false);
            // BlocProvider.of<AuthCubit>(context).appStarted();
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
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0),
                      child: SvgPicture.asset(
                        "assets/images/Emergency-call.svg",
                        alignment: Alignment.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Text(
                          'Setup your Emergency  contact Details',
                          style: kOnboardScreenTitle,
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Form(
                        key: formKeyEmergencyContact,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: TextFormInput(
                                  fieldName: "Name",
                                  controller: _emergencyContactNameController,
                                  hintText: "Name",
                                  prefixIcon: const Icon(Icons.person),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: TextFormInput(
                                  fieldName: "Contact number",
                                  hintText: "Contact number",
                                  controller: _emergencyContactController,
                                  prefixIcon: const Icon(Icons.phone),
                                )),
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
                  onPressed: () {
                    navigationHandler(context, RouteConst.homeScreen);
                  },
                  child: Text(
                    "Skip",
                    style: kBluetextStyle,
                  )),
              OutlinedButton(
                onPressed: () {
                  saveDataState(context);
                  navigationHandler(
                      context, RouteConst.addfreqVisitingLocScreen);
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

  void saveDataState(BuildContext context) async {
    BlocProvider.of<UserInfoCubit>(context).emergencyContactName =
        _emergencyContactNameController.text;
    BlocProvider.of<UserInfoCubit>(context).emergencyContact =
        _emergencyContactController.text;
  }
}
