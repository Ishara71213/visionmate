import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/features/app_features/presentation/bloc/viuser/cubit/viuser_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';
import 'package:lottie/lottie.dart' as li;

class UserFrequentlyVisitingLocationsInfoScreen extends StatefulWidget {
  final dynamic data;
  const UserFrequentlyVisitingLocationsInfoScreen(
      {super.key, required this.data});

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
    UserInfoCubit userInfoCubit = BlocProvider.of<UserInfoCubit>(context);
    final bool isAccessingFromSettings =
        widget.data?['isAccessingFromSettings'] ?? false;

    if (isAccessingFromSettings) {
      userInfoCubit.freqVisitingLocations =
          widget.data?['locationCordinates'] ?? [];
    }

    return BlocListener<UserCubit, UserState>(
      listener: (context, state) async {
        if (state is UserSuccess) {
          await Future.delayed(const Duration(seconds: 1), () {
            navigationHandlerByUserType(
                context,
                RouteConst.homeViUserScreen,
                RouteConst.homeGuardianUserScreen,
                RouteConst.homeVolunteerUserScreen);
            BlocProvider.of<AuthCubit>(context).appStarted();
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
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
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
                            SizedBox(
                              height: isAccessingFromSettings
                                  ? 240
                                  : userInfoCubit.freqVisitingLocations.isEmpty
                                      ? 14
                                      : userInfoCubit.freqVisitingLocations
                                                  .length ==
                                              1
                                          ? 70
                                          : 140,
                              child: BlocBuilder<UserInfoCubit, UserInfoState>(
                                builder: (context, state) {
                                  return ListView.builder(
                                      itemCount: userInfoCubit
                                          .freqVisitingLocations.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ListTile(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          leading: const Icon(
                                            Icons.location_on,
                                            size: 28,
                                          ),
                                          horizontalTitleGap: 0,
                                          title: Text(
                                            userInfoCubit
                                                .freqVisitingLocations[index]
                                                .locationName
                                                .toString(),
                                            style: kSmallTitleText,
                                          ),
                                          subtitle: Text(
                                            userInfoCubit
                                                .freqVisitingLocations[index]
                                                .locationPurpose
                                                .toString(),
                                            style: kSmallSubTitleText,
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                userInfoCubit
                                                    .freqVisitingLocations
                                                    .removeAt(index);
                                              });
                                              if (isAccessingFromSettings) {
                                                userInfoCubit
                                                    .submitFreqVisitingPlacesField();
                                                BlocProvider.of<ViuserCubit>(
                                                        context)
                                                    .getCurrrentUserdata();
                                              }
                                            },
                                            icon: Icon(
                                              Icons.remove_circle,
                                              color: kErrorColor,
                                            ),
                                          ),
                                        );
                                      });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            !isAccessingFromSettings
                                ? FilledButton(
                                    onPressed: () {
                                      navigationHandler(context,
                                          RouteConst.setfreqVisitingLocScreen);
                                    },
                                    style: FilledButton.styleFrom(
                                        minimumSize: const Size.fromHeight(60),
                                        backgroundColor: kButtonPrimaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6.0))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add_circle),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text("Add More",
                                            style: kFilledButtonTextstyle),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ))
                                : const SizedBox.shrink(),
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
                )
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
                              onPressed: () {},
                              child: Text(
                                "Skip",
                                style: kBluetextStyle,
                              )),
                          OutlinedButton(
                            onPressed: () {
                              navigationHandler(context,
                                  RouteConst.setVisualDisabilityScreen);
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
                          onPressed: () {
                            navigationHandlerWithArgumnets(
                                context,
                                RouteConst.setfreqVisitingLocScreen,
                                {'isAccessingFromSettings': true});
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
                    );
            }
          },
        ),
      ),
    );
  }
}
