import 'package:flutter/material.dart';

void navigationHandlerWithRemovePrevRoute(BuildContext context, String path) {
  String? previousRouteName = ModalRoute.of(context)?.settings.name.toString();
  if (previousRouteName != path) {
    Navigator.pushNamedAndRemoveUntil(context, path, (route) => false);
  }
}

void navigationHandler(BuildContext context, String path) {
  String? previousRouteName = ModalRoute.of(context)?.settings.name.toString();
  if (previousRouteName != path) {
    Navigator.pushNamed(context, path);
  }
}
