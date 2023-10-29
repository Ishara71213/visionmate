import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class AppBarMenuAndProfile extends StatefulWidget {
  final String appBarTitle;

  const AppBarMenuAndProfile({super.key, this.appBarTitle = ""});

  @override
  State<AppBarMenuAndProfile> createState() => _AppBarMenuAndProfileState();
}

class _AppBarMenuAndProfileState extends State<AppBarMenuAndProfile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.appBarTitle != ""
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, top: 18, right: 12),
                    child: Text(
                      widget.appBarTitle,
                      style: kTitleOneText,
                    ),
                  )
                ],
              )
            : const SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: kPrimaryColor,
              ),
              iconSize: 30,
              splashRadius: 1,
              padding: const EdgeInsets.only(
                  left: 10, right: 6, bottom: 10, top: 14),
            ),
            GestureDetector(
                onTap: () {
                  navigationHandler(context, RouteConst.profileScreen);
                },
                child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        if (state is ProfileInitial ||
                            state is ProfileImageLoading &&
                                BlocProvider.of<UserCubit>(context).userData !=
                                    null &&
                                BlocProvider.of<UserCubit>(context)
                                        .userData!
                                        .imageUrl !=
                                    null) {
                          return CircleAvatar(
                            minRadius: 25,
                            maxRadius: 25,
                            backgroundColor: kLightGreyColor,
                            foregroundImage: NetworkImage(
                                BlocProvider.of<UserCubit>(context)
                                    .userData!
                                    .imageUrl
                                    .toString()),
                            child: Icon(
                              Icons.person,
                              color: kGrey,
                              size: 35,
                            ),
                          );
                        } else if (state is ProfileImageSuccess &&
                            BlocProvider.of<UserCubit>(context).userData !=
                                null &&
                            BlocProvider.of<UserCubit>(context)
                                    .userData!
                                    .imageUrl !=
                                null) {
                          return CircleAvatar(
                            minRadius: 25,
                            maxRadius: 25,
                            backgroundColor: kLightGreyColor,
                            foregroundImage: NetworkImage(
                                BlocProvider.of<UserCubit>(context)
                                    .userData!
                                    .imageUrl
                                    .toString()),
                            child: Icon(
                              Icons.person,
                              color: kGrey,
                              size: 35,
                            ),
                          );
                        } else {
                          return CircleAvatar(
                            minRadius: 25,
                            maxRadius: 25,
                            backgroundColor: kLightGreyColor,
                            child: Icon(
                              Icons.person,
                              color: kGrey,
                              size: 35,
                            ),
                          );
                        }
                      },
                    )))
          ],
        ),
      ],
    );
  }
}