import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';

class UserViUserInfoScreen extends StatefulWidget {
  final dynamic data;
  const UserViUserInfoScreen({super.key, this.data});

  @override
  State<UserViUserInfoScreen> createState() => _UserGuardianInfoScreenState();
}

class _UserGuardianInfoScreenState extends State<UserViUserInfoScreen> {
  final GlobalKey<FormState> formKeyEmergencyContact = GlobalKey<FormState>();
  final TextEditingController _viUserEmailController = TextEditingController();
  bool agree = false;

  @override
  void dispose() {
    _viUserEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAccessingFromSettings =
        widget.data?['isAccessingFromSettings'] ?? false;
    final String wardEmail = widget.data?['wardId'] ?? "";
    if (_viUserEmailController.text == "") {
      _viUserEmailController.text = widget.data?['wardId'] ?? "";
    }

    //Size size = MediaQuery.of(context).size;
    UserInfoCubit userInfoCubit = BlocProvider.of<UserInfoCubit>(context);
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is UserSuccess) {
          await Future.delayed(const Duration(seconds: 1), () {
            navigationHandlerWithRemovePrevRoute(
                context, RouteConst.splashDataLoadScreen);
          });
        }
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          onLongPress: () {
            !isAccessingFromSettings
                ? BlocProvider.of<SpeechToTextCubit>(context).listning(context)
                : null;
          },
          child: SafeArea(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, right: 8),
                            child: SvgPicture.asset(
                              "assets/images/add-user.svg",
                              alignment: Alignment.center,
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: BlocBuilder<UserInfoCubit, UserInfoState>(
                                builder: (context, state) {
                              return (state is UserInfoLinkUserSuccess)
                                  ? Column(children: [
                                      Row(
                                        children: [
                                          Flexible(
                                              child: Text(
                                            'Ward Saved Successfully',
                                            style: kOnboardScreenTitle,
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                              child: Text(
                                            "You can moniter your wards location and activities",
                                            style: kOnboardScreenText,
                                          )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListTile(
                                        contentPadding: const EdgeInsets.all(0),
                                        leading: const Icon(
                                          Icons.email,
                                          size: 28,
                                        ),
                                        horizontalTitleGap: 0,
                                        title: Text(
                                          userInfoCubit.assignerEmail
                                              .toString(),
                                          style: kSmallTitleText,
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            _viUserEmailController.clear();
                                            userInfoCubit.removeAssignUser();
                                          },
                                          icon: Icon(
                                            Icons.remove_circle,
                                            color: kErrorColor,
                                          ),
                                        ),
                                      ),
                                    ])
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                                child: Text(
                                              'Setup your ward',
                                              style: kOnboardScreenTitle,
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                                child: Text(
                                              "your ward must be a registered user of vison mate application",
                                              style: kOnboardScreenText,
                                            )),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Form(
                                            key: formKeyEmergencyContact,
                                            child: Column(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 0.0),
                                                    child: TextFormInput(
                                                      fieldName: "Email",
                                                      controller:
                                                          _viUserEmailController,
                                                      hintText:
                                                          "Visually impaired user email ",
                                                      prefixIcon: const Icon(
                                                          Icons.email),
                                                    )),
                                              ],
                                            )),
                                        Row(children: [
                                          Container(
                                            padding: EdgeInsets.zero,
                                            child: Checkbox(
                                              activeColor: kPrimaryColor,
                                              value: agree,
                                              onChanged: (value) {
                                                setState(() {
                                                  agree = value ?? false;
                                                });
                                              },
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () =>
                                                setState(() => agree = !agree),
                                            child: Text(
                                                'Always share your location',
                                                overflow: TextOverflow.ellipsis,
                                                style: kOnboardScreenText),
                                          )
                                        ]),
                                        !isAccessingFromSettings
                                            ? FilledButton(
                                                onPressed: () {
                                                  if (_viUserEmailController
                                                          .text !=
                                                      "") {
                                                    verifyGuardian(context);
                                                  }
                                                },
                                                style: FilledButton.styleFrom(
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            60),
                                                    backgroundColor:
                                                        kButtonPrimaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0))),
                                                child: Text("Save",
                                                    style:
                                                        kFilledButtonTextstyle))
                                            : const SizedBox.shrink(),
                                        const SizedBox(height: 8),
                                        SizedBox(
                                          height: 40.0,
                                          child: BlocBuilder<UserInfoCubit,
                                              UserInfoState>(
                                            builder: (context, state) {
                                              return (state
                                                      is UserInfoLinkUserFailrue)
                                                  ? Column(
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            BlocProvider.of<
                                                                        UserInfoCubit>(
                                                                    context)
                                                                .errorMsg,
                                                            style: kwarningText,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox.shrink();
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                            }),
                          ),
                        ],
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
              return Lottie.asset('assets/animations/assistant_circle.json',
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
                              onPressed: () {},
                              child: Text(
                                "Skip",
                                style: kBluetextStyle,
                              )),
                          OutlinedButton(
                            onPressed: () async {
                              if (_viUserEmailController.text != "") {
                                await verifyGuardian(context);
                              }
                              await userInfoCubit.submitGuardianUserInfo();
                              // ignore: use_build_context_synchronously
                              navigationHandlerWithRemovePrevRoute(
                                  context, RouteConst.splashDataLoadScreen);
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
                  : BlocBuilder<UserInfoCubit, UserInfoState>(
                      builder: (context, state) {
                        if (state is UserInfoLinkUserSuccess) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: FilledButton.styleFrom(
                                    minimumSize: const Size.fromHeight(60),
                                    backgroundColor: kButtonPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                child: Text("Back To Settings",
                                    style: kFilledButtonTextstyle)),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: FilledButton(
                                onPressed: () async {
                                  if (_viUserEmailController.text != "") {
                                    await verifyGuardian(context);
                                    await userInfoCubit
                                        .guardianDataUpdateByFieldName(
                                            "vissuallyImpairedUserId",
                                            userInfoCubit.assignerId);
                                  }
                                },
                                style: FilledButton.styleFrom(
                                    minimumSize: const Size.fromHeight(60),
                                    backgroundColor: kButtonPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(6.0))),
                                child: Text("Save",
                                    style: kFilledButtonTextstyle)),
                          );
                        }
                      },
                    );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<void> verifyGuardian(BuildContext context) async {
    BlocProvider.of<UserInfoCubit>(context).assignerEmail =
        _viUserEmailController.text;
    BlocProvider.of<UserInfoCubit>(context).isAllowedLivelocationShare = agree;
    await BlocProvider.of<UserInfoCubit>(context).verifyGuardian();
  }
}
