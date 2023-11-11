import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/enum/guide_screen_types.dart';
import 'package:visionmate/core/enum/states.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/app_features/domain/entities/post_entity.dart';
import 'package:visionmate/features/app_features/presentation/bloc/community/community_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/app_bar_menu_and_profile.dart';

class CommunitySinglePostScreen extends StatelessWidget {
  final PostEntity post;
  const CommunitySinglePostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

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
                    padding: const EdgeInsets.fromLTRB(8, 90, 8, 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            BlocBuilder<CommunityCubit, CommunityState>(
                              builder: (context, state) {
                                return Stack(
                                  alignment: AlignmentDirectional.bottomStart,
                                  children: [
                                    Container(
                                      child: post.imageUrl != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  width: size.width - 32,
                                                  height:
                                                      (size.width - 32) / 1.5,
                                                  imageUrl: post.imageUrl!,
                                                  placeholder: (context, url) =>
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.image_rounded,
                                                            size: 60,
                                                            color:
                                                                kGuideBoxIconColor,
                                                          ),
                                                        ],
                                                      ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.image_rounded,
                                                            size: 60,
                                                            color:
                                                                kGuideBoxIconColor,
                                                          ),
                                                        ],
                                                      )),
                                            )
                                          : Container(
                                              width: size.width - 32,
                                              height: (size.width - 32) / 1.5,
                                              decoration: BoxDecoration(
                                                  color: kGuideBoxBgColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          14)),
                                              child: Icon(
                                                Icons.image,
                                                size: 80,
                                                color: kGuideBoxIconColor,
                                              ),
                                            ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    post.title?.toString() ?? "",
                                    style: kTitleOneText,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    post.content?.toString() ?? "",
                                    style: kGuideDetailsBody,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const AppBarBackBtnProfile(
                  appBarTitle: "Community",
                )
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
                selectedIndex: 3,
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
