import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/enum/guide_screen_types.dart';
import 'package:visionmate/core/enum/states.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/app_features/presentation/bloc/community/community_cubit.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/app_bar_menu_and_profile.dart';
import 'package:visionmate/features/app_features/presentation/widgets/app_bar_with_back_button.dart';
import 'package:visionmate/features/app_features/presentation/widgets/common_app_bar.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_box.dart';
import 'package:visionmate/features/app_features/presentation/widgets/guide_descriptions/guide_description_common%20copy.dart';
import 'package:visionmate/features/app_features/presentation/widgets/image_box.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class CommunityUploadPostsScreen extends StatefulWidget {
  const CommunityUploadPostsScreen({super.key});

  @override
  State<CommunityUploadPostsScreen> createState() =>
      _CommunityUploadPostsScreen();
}

class _CommunityUploadPostsScreen extends State<CommunityUploadPostsScreen> {
  final GlobalKey<FormState> formKeyCommunityPost = GlobalKey<FormState>();
  final TextEditingController _postTitleController = TextEditingController();
  final TextEditingController _postContentController = TextEditingController();

  @override
  void dispose() {
    _postTitleController.dispose();
    _postContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    //UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    CommunityCubit communityCubit = BlocProvider.of<CommunityCubit>(context);

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
                    padding: const EdgeInsets.symmetric(
                        vertical: 100, horizontal: 8),
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
                                      // onTap: () {
                                      //   communityCubit.getFromCamera(context);
                                      // },
                                      child: communityCubit.imageFile != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              child: SizedBox(
                                                width: size.width - 32,
                                                height: (size.width - 32) / 1.5,
                                                child: Image.memory(
                                                  communityCubit.imageFile!
                                                      .readAsBytesSync(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
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
                                    Opacity(
                                      opacity: 0.9,
                                      child: Container(
                                        constraints: BoxConstraints(
                                            // minHeight: 46,
                                            // maxHeight: 46,
                                            minWidth: size.width - 32),
                                        decoration: BoxDecoration(
                                            color: kButtonPrimaryColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(14),
                                                    bottomRight:
                                                        Radius.circular(14))),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    communityCubit
                                                        .getFromGallery(
                                                            context);
                                                  },
                                                  child: SizedBox(
                                                    height: 46,
                                                    child: Center(
                                                      child: Text(
                                                        "Upload Image",
                                                        style:
                                                            kFilledButtonSmallTextstyleLight,
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width / 6,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    communityCubit
                                                        .getFromCamera(context);
                                                  },
                                                  child: SizedBox(
                                                    height: 46,
                                                    child: Center(
                                                      child: Text(
                                                        "Camera Image",
                                                        style:
                                                            kFilledButtonSmallTextstyleLight,
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
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
                        Form(
                            key: formKeyCommunityPost,
                            child: Column(
                              children: [
                                Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormInput(
                                      fieldName: "Title",
                                      controller: _postTitleController,
                                      hintText: "Title",
                                    )),
                                Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormInput(
                                      fieldName: "Content",
                                      hintText: "Type here",
                                      controller: _postContentController,
                                      isTextArea: true,
                                    )),
                                BlocBuilder<CommunityCubit, CommunityState>(
                                  builder: (context, state) {
                                    return FilledButtonWithLoader(
                                        initText: 'Submit',
                                        loadingText: 'Uploading',
                                        successText: 'Done',
                                        onPressed: () {
                                          if (formKeyCommunityPost.currentState!
                                              .validate()) {
                                            communityCubit.postTitle =
                                                _postTitleController.text;
                                            communityCubit.postContent =
                                                _postContentController.text;
                                            communityCubit.submitPost(context);
                                          }
                                        },
                                        state: (state
                                                is CommunityPostUploadLoading)
                                            ? States.loading
                                            : (state
                                                    is CommunityPostUploadSuccess)
                                                ? States.success
                                                : States.initial);
                                  },
                                )
                              ],
                            )),
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
