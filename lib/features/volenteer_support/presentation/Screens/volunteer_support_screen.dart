import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/features/app_features/presentation/bloc/community/community_cubit.dart';
import 'package:visionmate/features/app_features/presentation/screens/community_single_post_screen.dart';
import 'package:visionmate/features/app_features/presentation/widgets/common_app_bar.dart';
import 'package:visionmate/features/app_features/presentation/widgets/image_box.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class VolunteerSupportScreen extends StatefulWidget {
  const VolunteerSupportScreen({super.key});

  @override
  State<VolunteerSupportScreen> createState() => _VolunteerSupportScreen();
}

class _VolunteerSupportScreen extends State<VolunteerSupportScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    ScrollController scrollController = ScrollController();
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
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 75, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add New",
                                style: kTitleOneText,
                              ),
                              IconButton(
                                  onPressed: () {
                                    navigationHandler(context,
                                        RouteConst.communityUploadPostScreen);
                                  },
                                  icon: Icon(
                                    Icons.add_circle_rounded,
                                    size: 32,
                                    color: kPrimaryColor,
                                  ))
                            ],
                          ),
                        ),
                        BlocBuilder<CommunityCubit, CommunityState>(
                          builder: (context, state) {
                            return FutureBuilder(
                                future: BlocProvider.of<CommunityCubit>(context)
                                    .loadPosts(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      controller: scrollController,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            2, // number of items in each row
                                        mainAxisSpacing:
                                            16.0, // spacing between rows
                                        crossAxisSpacing:
                                            16.0, // spacing between columns
                                      ),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CommunitySinglePostScreen(
                                                            post:
                                                                snapshot.data![
                                                                    index])));
                                          },
                                          child: ImageBox(
                                              post: snapshot.data![index],
                                              size: size),
                                        );
                                      },
                                    );
                                  } else {
                                    return SizedBox(
                                      height: size.height - 250,
                                      child: Center(
                                          child: CircularProgressIndicator(
                                        color: kPrimaryColor,
                                      )),
                                    );
                                  }
                                });
                          },
                        ),
                        // Row(
                        //   children: [
                        //     GestureDetector(
                        //       onTap: () {},
                        //       child: ImageBox(post: post, size: size),
                        //     ),
                        //     const SizedBox(
                        //       width: 16,
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {},
                        //       child: GuideBox(
                        //           title: "Emergency call guide",
                        //           icon: Icons.emergency_rounded,
                        //           size: size),
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ),
                Container(
                    decoration: BoxDecoration(color: kAppBgColor),
                    child: const CommonAppBar(
                      appBarTitle: "Community",
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
                selectedIndex: 2,
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
