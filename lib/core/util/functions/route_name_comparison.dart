import 'package:visionmate/config/routes/route_const.dart';

String compareRouteName(String routeCommand) {
  switch (routeCommand) {
    case "object detection":
      return RouteConst.setEmergencyContactScreen;
    case "color detection":
      return RouteConst.setGuardianScreen;
    case "text to speech":
      return RouteConst.setGuardianScreen;
    case "connect cane":
      return RouteConst.setGuardianScreen;
    default:
      return "not found";
  }
}
