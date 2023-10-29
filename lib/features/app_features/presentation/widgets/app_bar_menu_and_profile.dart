import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class AppBarMenuAndProfile extends StatefulWidget {
  const AppBarMenuAndProfile({super.key});

  @override
  State<AppBarMenuAndProfile> createState() => _AppBarMenuAndProfileState();
}

class _AppBarMenuAndProfileState extends State<AppBarMenuAndProfile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              navigationHandlerWithRemovePrevRoute(
                  context, RouteConst.settingsScreen);
            },
            icon: Icon(
              Icons.menu_rounded,
              size: 40,
              color: kPrimaryColor,
            )),
        GestureDetector(
            onTap: () {
              navigationHandlerWithRemovePrevRoute(
                  context, RouteConst.homeViUserScreen);
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
                        BlocProvider.of<UserCubit>(context).userData != null &&
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
    );
  }
}
