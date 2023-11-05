import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/core/widgets/input_widgets/input_widgets_library.dart';
import 'package:visionmate/features/app_features/presentation/bloc/guardian/cubit/guardian_cubit.dart';

class GuardianDefaultView extends StatelessWidget {
  const GuardianDefaultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 8),
          child: SvgPicture.asset(
            "assets/images/add-user.svg",
            alignment: Alignment.center,
          ),
        ),
        const SizedBox(
          height: 12.0,
        ),
        Row(
          children: [
            Flexible(
                child: Text(
              'Setup your ward',
              style: kOnboardScreenTitle,
            )),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Flexible(
                child: Text(
              "your ward must be a registered user of vison mate application",
              style: kOnboardScreenText,
            )),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        FilledButton(
            onPressed: () {
              navigationHandlerWithArgumnets(
                  context, RouteConst.setViUserScreen, {
                'isAccessingFromSettings': true,
                'wardId':
                    BlocProvider.of<GuardianCubit>(context).wardEmail ?? ""
              });
            },
            style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(60),
                backgroundColor: kButtonPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0))),
            child: Text("Set up Ward", style: kFilledButtonTextstyle)),
      ],
    );
    ;
  }
}
