import 'package:flutter/material.dart';

final navigator = NavigationService.value;

class NavigationService {
  static NavigationService get value => NavigationService._();
  NavigationService._();

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
 
  BuildContext get context => navigatorKey.currentContext!;
}

extension NavigatorExtension on BuildContext? {
  BuildContext get context => this ?? navigator.context;
  pop({Object? arguments}) => Navigator.pop(context, arguments);
  popUntil(String route) =>
      Navigator.of(context).popUntil(ModalRoute.withName(route));
  popAndPush(String route, {Object? arguments}) =>
      Navigator.popAndPushNamed(context, route, arguments: arguments);
  push(String route, {Object? arguments}) =>
      Navigator.pushNamed(context, route, arguments: arguments);
  pushUntil(String route, {String? from, Object? arguments}) =>
      Navigator.pushNamedAndRemoveUntil(context, route,
          from == null ? (route) => false : ModalRoute.withName(route));
  pushReplacement(String route, {Object? arguments}) =>
      Navigator.pushReplacementNamed(context, route, arguments: arguments);
}