import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/enum/guide_screen_types.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/common_app_bar.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_box.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/guide_description_common%20copy.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/connect_smart_cane/presentation/bloc/cubit/connect_cane_cubit.dart';
import 'package:visionmate/features/connect_smart_cane/presentation/widgets/BleDeviceContainer.dart';

class ConnectCaneScreen extends StatefulWidget {
  const ConnectCaneScreen({super.key});

  @override
  State<ConnectCaneScreen> createState() => _ConnectCaneScreenState();
}

class _ConnectCaneScreenState extends State<ConnectCaneScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    ScrollController scrollController = ScrollController();
    ConnectCaneCubit connectCaneCubit =
        BlocProvider.of<ConnectCaneCubit>(context);
    return GestureDetector(
      onLongPress: () {
        BlocProvider.of<SpeechToTextCubit>(context).listning(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: BlocBuilder<ConnectCaneCubit, ConnectCaneState>(
                    builder: (context, state) {
                      if (state is! CaneConnected) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 75, 8, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(8.0, 0, 0, 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Available Devices",
                                      style: kTitleOneText,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              BlocBuilder<ConnectCaneCubit, ConnectCaneState>(
                                builder: (context, state) {
                                  return StreamBuilder(
                                      stream: connectCaneCubit.scanResult,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            controller: scrollController,
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {},
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: (index ==
                                                              snapshot.data!
                                                                      .length -
                                                                  1)
                                                          ? 80
                                                          : 12),
                                                  child: BleDeviceContainer(
                                                    index: index,
                                                    scanResult:
                                                        snapshot.data![index],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          return SizedBox(
                                            height: size.height - 250,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: kPrimaryColor,
                                            )),
                                          );
                                        }
                                      });
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.only(left: 8),
                            height: size.height / 1.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                    'assets/animations/search-radar.json',
                                    width: size.width - 32,
                                    height: size.width - 32),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                BlocBuilder<ConnectCaneCubit, ConnectCaneState>(
                  builder: (context, state) {
                    if (state is! CaneConnected) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FilledButtonCustom(
                              onPressed: () async {
                                await connectCaneCubit.scanDevices();
                              },
                              initText: "Scan",
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FilledButtonCustom(
                              onPressed: () async {},
                              initText: "Find Device",
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                Container(
                    decoration: BoxDecoration(color: kAppBgColor),
                    child: const CommonAppBar(
                      appBarTitle: "Smart Cane",
                    )),
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
              return const BottomNavBar(
                selectedIndex: 5,
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
