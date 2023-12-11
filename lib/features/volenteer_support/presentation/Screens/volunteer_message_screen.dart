import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/constants/user_types.dart';
import 'package:visionmate/core/enum/states.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/app_features/presentation/bloc/community/community_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/app_bar_menu_and_profile.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';
import 'package:visionmate/features/userInfoSetup/presentation/bloc/user_info/cubit/user_info_cubit.dart';
import 'package:visionmate/features/volenteer_support/presentation/bloc/voluntee_support_cubit/volunteer_support_cubit.dart';

class VolunteerMessageScreen extends StatefulWidget {
  const VolunteerMessageScreen({super.key});

  @override
  State<VolunteerMessageScreen> createState() => _VolunteerMessageScreen();
}

class _VolunteerMessageScreen extends State<VolunteerMessageScreen> {
  final GlobalKey<FormState> formKeyVlounteerChat = GlobalKey<FormState>();
  final TextEditingController _messageSubjectController =
      TextEditingController();
  final TextEditingController _messageBodyController = TextEditingController();

  @override
  void dispose() {
    _messageSubjectController.dispose();
    _messageBodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    //UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    VolunteerSupportCubit supportRequestCubit =
        BlocProvider.of<VolunteerSupportCubit>(context);

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
                        const SizedBox(
                          height: 16,
                        ),
                        Form(
                            key: formKeyVlounteerChat,
                            child: Column(
                              children: [
                                Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormInput(
                                      fieldName: "Subject",
                                      controller: _messageSubjectController,
                                      hintText: "Subject",
                                    )),
                                Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12.0),
                                    child: TextFormInput(
                                      fieldName: "Message",
                                      hintText: "Message",
                                      controller: _messageBodyController,
                                      isTextArea: true,
                                    )),
                                BlocBuilder<VolunteerSupportCubit,
                                    VolunteerSupportState>(
                                  builder: (context, state) {
                                    return FilledButtonWithLoader(
                                        initText: 'Submit',
                                        loadingText: 'Uploading',
                                        successText: 'Done',
                                        onPressed: () {
                                          if (formKeyVlounteerChat.currentState!
                                              .validate()) {
                                            String user =
                                                BlocProvider.of<UserCubit>(
                                                        context)
                                                    .userType;
                                            if (user ==
                                                UserTypes
                                                    .visuallyImpairedUser) {
                                              supportRequestCubit
                                                  .emailSendtoVolunteer(
                                                      _messageSubjectController
                                                          .text,
                                                      _messageBodyController
                                                          .text);
                                            } else {
                                              supportRequestCubit
                                                  .emailSendtoViUser(
                                                      _messageSubjectController
                                                          .text,
                                                      _messageBodyController
                                                          .text);
                                            }
                                          }
                                          _messageSubjectController.text = "";
                                          _messageBodyController.text = "";
                                        },
                                        state: (state
                                                is VlounteerSupportRequestUploadLoading)
                                            ? States.loading
                                            : (state
                                                    is VlounteerSupportRequestUploadSuccess)
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
                  appBarTitle: "Chat",
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
