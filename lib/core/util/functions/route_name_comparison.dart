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
    case "home":
      return "home";
    default:
      return "not found";
  }
}
