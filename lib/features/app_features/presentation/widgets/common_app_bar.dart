import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/features/app_features/presentation/bloc/profile/profile_cubit.dart';
import 'package:visionmate/features/auth/presentation/bloc/user/cubit/user_cubit.dart';

class CommonAppBar extends StatefulWidget {
  final String appBarTitle;

  const CommonAppBar({super.key, this.appBarTitle = ""});

  @override
  State<CommonAppBar> createState() => _CommonAppBarState();
}

class _CommonAppBarState extends State<CommonAppBar> {
  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    return Stack(
      children: [
        widget.appBarTitle != ""
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 10, top: 28, right: 12),
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
                  navigationHandler(context, RouteConst.settingsScreen);
                },
                icon: Icon(
                  Icons.menu_rounded,
                  size: 40,
                  color: kPrimaryColor,
                )),
            GestureDetector(onTap: () {
              navigationHandler(context, RouteConst.profileScreen);
            }, child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.all(10.0),
                  child: userCubit.userData != null &&
                          userCubit.userData!.imageUrl != null &&
                          userCubit.userData!.imageUrl != "null"
                      ? CircleAvatar(
                          minRadius: 25,
                          maxRadius: 25,
                          backgroundColor: kLightGreyColor,
                          foregroundImage: NetworkImage(
                              userCubit.userData!.imageUrl.toString()),
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
              },
            ))
          ],
        ),
      ],
    );
  }
}
