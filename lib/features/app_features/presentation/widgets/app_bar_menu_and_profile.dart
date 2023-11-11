import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class AppBarBackBtnProfile extends StatefulWidget {
  final String appBarTitle;

  const AppBarBackBtnProfile({super.key, this.appBarTitle = ""});

  @override
  State<AppBarBackBtnProfile> createState() => _AppBarBackBtnProfile();
}

class _AppBarBackBtnProfile extends State<AppBarBackBtnProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kAppBgColor,
      child: Stack(
        children: [
          widget.appBarTitle != ""
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: 10, top: 18, right: 0),
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
                    left: 10, right: 6, bottom: 10, top: 0),
              ),
              GestureDetector(
                  onTap: () {
                    navigationHandler(context, RouteConst.profileScreen);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                          child: BlocProvider.of<UserCubit>(context)
                                          .userData !=
                                      null &&
                                  BlocProvider.of<UserCubit>(context)
                                          .userData!
                                          .imageUrl !=
                                      null &&
                                  BlocProvider.of<UserCubit>(context)
                                          .userData!
                                          .imageUrl !=
                                      "null"
                              ? CircleAvatar(
                                  minRadius: 25,
                                  maxRadius: 25,
                                  backgroundColor: kLightGreyColor,
                                  foregroundImage: CachedNetworkImageProvider(
                                      BlocProvider.of<UserCubit>(context)
                                          .userData!
                                          .imageUrl
                                          .toString()),
                                  child: Icon(
                                    Icons.person,
                                    color: kGrey,
                                    size: 35,
                                  ),
                                )
                              : CircleAvatar(
                                  minRadius: 25,
                                  maxRadius: 25,
                                  backgroundColor: kLightGreyColor,
                                  child: Icon(
                                    Icons.person,
                                    color: kGrey,
                                    size: 35,
                                  ),
                                ),
                        );
                      })))
            ],
          ),
        ],
      ),
    );
  }
}
