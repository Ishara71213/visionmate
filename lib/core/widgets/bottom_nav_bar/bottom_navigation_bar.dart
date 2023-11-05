import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visionmate/config/routes/route_const.dart';
import 'package:visionmate/core/constants/constants.dart';
import 'package:visionmate/core/util/functions/navigator_handler.dart';
import 'package:visionmate/features/app_features/presentation/screens/home_vi_user_screen.dart';

class BottomNavBar extends StatefulWidget {
  final int selectedIndex;
  const BottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  List<String> data = [
    'assets/icons/Home.svg',
    'assets/icons/Guide.svg',
    'assets/icons/Community.svg',
    'assets/icons/Settings.svg'
    // 'assets/icons/navigation-Products.svg',
  ];

  List<String> iconNames = ['Home', 'Guide', 'Community', 'Settings'];

  @override
  void initState() {
    setState(() {
      selectedIndex = widget.selectedIndex;
      print(selectedIndex);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16.0),

      width: double.infinity,
      height: 60, // Increased the height to accommodate the icon names
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(data.length, (index) {
              String iconName = iconNames[index];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (index == 0) {
                      navigationHandlerByUserType(
                          context,
                          RouteConst.homeViUserScreen,
                          RouteConst.homeGuardianUserScreen,
                          RouteConst.homeVolunteerUserScreen);
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomeViUserScreen();
                          },
                        ),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomeViUserScreen();
                          },
                        ),
                      );
                    } else if (index == 3) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeViUserScreen()));
                    }
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Align the icon and text in the center
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: SvgPicture.asset(
                        data[index],
                        height: 25,
                        color: selectedIndex == index
                            ? Colors.white.withOpacity(0.9)
                            : Colors.white.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      iconName,
                      style: TextStyle(
                        color: selectedIndex == index
                            ? Colors.white.withOpacity(0.9)
                            : Colors.white.withOpacity(0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
