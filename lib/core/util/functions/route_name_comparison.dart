import 'package:visionmate/config/routes/route_const.dart';

String compareRouteName(String routeCommand) {
  switch (routeCommand) {
    case "object detection" || "object detector":
      return RouteConst.setEmergencyContactScreen;
    case "color detection" || "colour detector" || "colour detection":
      return RouteConst.setGuardianScreen;
    case "text to speech":
      return RouteConst.setGuardianScreen;
    case "connect cane" || "connect kane":
      return RouteConst.setGuardianScreen;
    case "setting" || "settings":
      return RouteConst.settingsScreen;
    case "profile" || "profile setting" || "profile settings":
      return RouteConst.profileScreen;
    case "guide" || "guid" || "gide":
      return RouteConst.guideScreen;
    case "Community" || "comunity" || "communi":
      return RouteConst.communityPostsScreen;
    case "add post" || "add posts" || "community post" || "adpost" || "addpost":
      return RouteConst.communityUploadPostScreen;
    case "set home location" || "seth location" || "set locat":
      return RouteConst.setResidenceLocScreen;
    case "set visit locations" || "seth visit location" || "st visit locations":
      return RouteConst.setfreqVisitingLocScreen;
    case "set guardian" || "seth guardian":
      return RouteConst.setGuardianScreen;
    case "set emergency contact" || "seth emergency contac" || "set emergency":
      return RouteConst.setEmergencyContactScreen;
    case "home":
      return "home";
    default:
      return "not found";
  }
}
