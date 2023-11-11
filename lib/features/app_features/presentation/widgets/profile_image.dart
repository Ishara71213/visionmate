import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);
    return Stack(
      children: [
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileImageLoading &&
                userCubit.userData != null &&
                userCubit.userData!.imageUrl != null &&
                userCubit.userData!.imageUrl != "null") {
              return CircleAvatar(
                  minRadius: 25,
                  maxRadius: 55,
                  backgroundColor: kLightGreyColor,
                  backgroundImage: NetworkImage(
                      userCubit.userData!.imageUrl.toString(),
                      scale: 1.0),
                  child: Opacity(
                    opacity: 0.5,
                    child: Container(
                        decoration: BoxDecoration(
                            color: kLightGreyColor,
                            borderRadius: BorderRadius.circular(100))),
                  ));
            } else if (state is ProfileInitial &&
                userCubit.userData != null &&
                userCubit.userData!.imageUrl != null &&
                userCubit.userData!.imageUrl != "null") {
              return CircleAvatar(
                minRadius: 25,
                maxRadius: 55,
                backgroundColor: kLightGreyColor,
                foregroundImage: NetworkImage(
                    userCubit.userData!.imageUrl.toString(),
                    scale: 1.0),
                child: Icon(
                  Icons.person,
                  color: kGrey,
                  size: 70,
                ),
              );
            } else if (state is ProfileImageSuccess &&
                profileCubit.imageFile != null &&
                userCubit.userData != null &&
                userCubit.userData!.imageUrl != null &&
                userCubit.userData!.imageUrl != "null") {
              return CircleAvatar(
                  minRadius: 25,
                  maxRadius: 55,
                  backgroundColor: kLightGreyColor,
                  foregroundImage:
                      NetworkImage(userCubit.userData!.imageUrl.toString()),
                  child: Icon(
                    Icons.person,
                    color: kGrey,
                    size: 70,
                  ));
              // return CircleAvatar(
              //     minRadius: 25,
              //     maxRadius: 55,
              //     backgroundColor: kLightGreyColor,
              //     foregroundImage:
              //         FileImage(profileCubit.imageFile!));
            } else if (userCubit.userData != null &&
                userCubit.userData!.imageUrl != null &&
                userCubit.userData!.imageUrl != "null") {
              return CircleAvatar(
                minRadius: 25,
                maxRadius: 55,
                backgroundColor: kLightGreyColor,
                foregroundImage: NetworkImage(
                    userCubit.userData!.imageUrl.toString(),
                    scale: 1.0),
                child: Icon(
                  Icons.person,
                  color: kGrey,
                  size: 70,
                ),
              );
            } else {
              return CircleAvatar(
                minRadius: 25,
                maxRadius: 55,
                backgroundColor: kLightGreyColor,
                child: Icon(
                  Icons.person,
                  color: kGrey,
                  size: 70,
                ),
              );
            }
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 32,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
            child: PopupMenuButton(
                offset: const Offset(70, 0),
                shadowColor: kLightGreyColor,
                icon: Icon(
                  Icons.photo_camera,
                  color: kButtonTextWhiteColor,
                  size: 15,
                ),
                onSelected: (newValue) {
                  if (newValue == '1') {
                    profileCubit.getFromCamera(context);
                  } else if (newValue == '2') {
                    profileCubit.getFromGallery(context);
                  } else {
                    print('You need to do');
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem<String>(
                        value: '1',
                        child: Row(children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            size: 20,
                            color: kDarkGreyColor,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Take from Camera",
                            style: kBlackSmalltextStyle,
                          ),
                        ]),
                      ),
                      PopupMenuItem<String>(
                          value: '2',
                          child: Row(children: [
                            Icon(
                              Icons.image_rounded,
                              size: 20,
                              color: kDarkGreyColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Upload From Gallery",
                              style: kBlackSmalltextStyle,
                            )
                          ])),
                    ]),
          ),
        )
      ],
    );
  }
}
