import 'package:flutter/material.dart';
import 'package:kngtakehome/views/widgets/dialog/alert_dialog_route.dart';

enum NavigationType { replace, push }

Future<T?> showDialog<T>(
  BuildContext context,
  Widget dialog, {
  NavigationType navType = NavigationType.push,
  bool barrierClosable = false,
  String? routeName,
}) async {
  final route = AlertDialogueRoute<T>(
    child: dialog,
    closable: barrierClosable,
    routeName: routeName ?? 'CustomDialog',
  );

  switch (navType) {
    case NavigationType.replace:
      return await Navigator.of(context).pushReplacement(route);
    default:
      return await Navigator.of(context).push(route);
  }
}
