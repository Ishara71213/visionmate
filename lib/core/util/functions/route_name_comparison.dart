import 'package:visionmate/config/routes/route_const.dart';

String compareRouteName(String routeCommand) {
  switch (routeCommand) {
    case "object detection" || "object detector":
      return RouteConst.objectDetectionScreen;
    case "color detection" || "colour detector" || "colour detection":
      return RouteConst.setGuardianScreen;
    case "text to speech" || "text two speech" || "test to speech":
      return RouteConst.textToSpeechScreen;
    case "connect cane" || "connect kane":
      return RouteConst.connectCaneScreen;
    case "setting" || "settings":
      return RouteConst.settingsScreen;
    case "navigation" ||
          "navigation assistance" ||
          "navigation asistanse" ||
          "navigation assistant":
      return RouteConst.locationScreen;
    case "profile" || "profile setting" || "profile settings":
      return RouteConst.profileScreen;
    case "guide" || "guid" || "gide":
      return RouteConst.guideScreen;
    case "community" || "comunity" || "communi":
      return RouteConst.communityPostsScreen;
    case "add post" || "add posts" || "community post" || "adpost" || "addpost":
      return RouteConst.communityUploadPostScreen;
    case "requests" || "request" || "support reuests" || "support reuest":
      return RouteConst.volunteerSupportScreen;
    case "requests post" ||
          "request post" ||
          "support reuests post" ||
          "support reuest post":
      return RouteConst.volunteerSuportSingleRequestScreen;
    case "set home location" || "seth location" || "set locat":
      return RouteConst.setResidenceLocScreen;
    case "set visit locations" ||
          "set visit location" ||
          "seth visit location" ||
          "st visit locations":
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
