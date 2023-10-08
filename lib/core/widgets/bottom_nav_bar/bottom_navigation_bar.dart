import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visionmate/core/constants/constants.dart';
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
    'assets/icons/Contact.svg',
    'assets/icons/Find Clubs.svg',
    'assets/icons/User.svg'
    // 'assets/icons/navigation-Products.svg',
  ];
  // List<String> iconNames = ['home', 'scan', 'findClubs', 'payments'];
  List<String> iconNames = ['home', 'contactUs', 'findClubs', 'user'];

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
      color: Colors.white,
      width: double.infinity,
      height: 60, // Increased the height to accommodate the icon names
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomeViUserScreen();
                          },
                        ),
                      );
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

                    // else if (index == 3) {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) {
                    //         return const HyperpayTest(
                    //           title: 'Payments',
                    //         );
                    //       },
                    //     ),
                    //   );
                    // }
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Align the icon and text in the center
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: SvgPicture.asset(
                        data[index],
                        height: 25,
                        color: selectedIndex == index
                            ? kPrimaryColor
                            : Colors.black.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      iconName,
                      style: TextStyle(
                        color: selectedIndex == index
                            ? kPrimaryColor
                            : Colors.black.withOpacity(0.4),
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
