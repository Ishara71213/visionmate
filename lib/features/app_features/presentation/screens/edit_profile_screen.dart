import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:visionmate/core/common/presentation/bloc/cubit/speech_to_text_cubit.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/enum/states.dart';
import 'package:visionmate/core/widgets/bottom_nav_bar/bottom_navigation_bar.dart';
import 'package:visionmate/core/widgets/button_widgets/button_widgets_library.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/app_features/presentation/widgets/app_bar_with_back_button.dart';
import 'package:visionmate/features/app_features/presentation/widgets/profile_image.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> formEditProfile = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (BlocProvider.of<UserCubit>(context).userData != null) {
      _firstNameController.text =
          BlocProvider.of<UserCubit>(context).userData?.firstName.toString() ??
              "";
      _lastNameController.text =
          BlocProvider.of<UserCubit>(context).userData?.lastName.toString() ??
              "";
      _emailController.text =
          BlocProvider.of<UserCubit>(context).userData?.email.toString() ?? "";
      _dateOfBirthController.text =
          BlocProvider.of<UserCubit>(context).userData?.dob.toString() ?? "";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

    return GestureDetector(
      onLongPress: () {
        BlocProvider.of<SpeechToTextCubit>(context).listning(context);
      },
      child: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AppBarWithBackButton(
                  appBarTitle: "Edit Profile",
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const ProfileImage(),
                      const SizedBox(
                        height: 40.0,
                      ),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return Form(
                              key: formEditProfile,
                              child: Column(
                                children: [
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: TextFormInput(
                                        fieldName: "First Name",
                                        controller: _firstNameController,
                                        hintText: "First Name",
                                        prefixIcon:
                                            const Icon(Icons.verified_user),
                                      )),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: TextFormInput(
                                        fieldName: "Last Name",
                                        controller: _lastNameController,
                                        hintText: "Last Name",
                                        prefixIcon:
                                            const Icon(Icons.verified_user),
                                      )),
                                  Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: DateSelectorInput(
                                        fieldName: "Date of Birth",
                                        hintText: "Date of Birthday",
                                        controller: _dateOfBirthController,
                                        prefixIcon:
                                            const Icon(Icons.calendar_month),
                                      )),
                                ],
                              ));
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return FilledButtonWithLoader(
                            initText: 'Save',
                            loadingText: 'Updating',
                            successText: 'Done',
                            onPressed: () {
                              if (formEditProfile.currentState!.validate()) {
                                profileCubit.updateUserInfo(
                                    context: context,
                                    firstNameCtrl: _firstNameController.text,
                                    lastNameCtrl: _lastNameController.text,
                                    dobCtrl: _dateOfBirthController.text);
                              }
                            },
                            state: (state is ProfiledataUpdateLoading)
                                ? States.loading
                                : (state is ProfiledataUpdateSuccess)
                                    ? States.success
                                    : States.initial);
                      },
                    )),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        )),
        floatingActionButton: BlocBuilder<SpeechToTextCubit, SpeechToTextState>(
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
