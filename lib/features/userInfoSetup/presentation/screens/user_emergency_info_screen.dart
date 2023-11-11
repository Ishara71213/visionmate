import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';
import 'package:lottie/lottie.dart' as li;

class UserEmergencyInfoScreen extends StatefulWidget {
  final dynamic data;
  const UserEmergencyInfoScreen({super.key, required this.data});

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
    final bool isAccessingFromSettings =
        widget.data?['isAccessingFromSettings'] ?? false;
    if (_emergencyContactNameController.text == "" &&
        _emergencyContactController.text == "") {
      _emergencyContactNameController.text =
          widget.data?['emergencyContactName'] ?? "";
      _emergencyContactController.text = widget.data?['emergencyContact'] ?? "";
    }
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          onLongPress: () {
            isAccessingFromSettings
                ? BlocProvider.of<SpeechToTextCubit>(context).listning(context)
                : null;
          },
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 14.0, left: 18.0, right: 4.0),
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
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: TextFormInput(
                                          fieldName: "Name",
                                          controller:
                                              _emergencyContactNameController,
                                          hintText: "Name",
                                          prefixIcon: const Icon(Icons.person),
                                        )),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12.0),
                                        child: TextFormInput(
                                          fieldName: "Contact number",
                                          hintText: "Contact number",
                                          controller:
                                              _emergencyContactController,
                                          prefixIcon: const Icon(Icons.phone),
                                        )),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: kPrimaryColor,
                    ),
                    iconSize: 30,
                    splashRadius: 1,
                    padding:
                        const EdgeInsets.only(left: 22, right: 6, bottom: 10),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
          builder: (context, state) {
            if (state is Listning) {
              return li.Lottie.asset('assets/animations/assistant_circle.json',
                  width: 106, height: 106);
            } else {
              return !isAccessingFromSettings
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                navigationHandler(
                                    context, RouteConst.homeViUserScreen);
                              },
                              child: Text(
                                "Skip",
                                style: kBluetextStyle,
                              )),
                          OutlinedButton(
                            onPressed: () {
                              saveDataState(context);
                              navigationHandler(
                                  context, RouteConst.setResidenceLocScreen);
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
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FilledButton(
                          onPressed: () async {
                            if (_emergencyContactNameController.text != "" &&
                                _emergencyContactController.text != "") {
                              await BlocProvider.of<UserInfoCubit>(context)
                                  .submitSpecificField("emergencyContactName",
                                      _emergencyContactNameController.text);
                              await BlocProvider.of<UserInfoCubit>(context)
                                  .submitSpecificField("emergencyContact",
                                      _emergencyContactController.text);
                              BlocProvider.of<ViuserCubit>(context)
                                  .getCurrrentUserdata();
                            }
                          },
                          style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(60),
                              backgroundColor: kButtonPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0))),
                          child: Text("Save", style: kFilledButtonTextstyle)),
                    );
            }
          },
        ),
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
