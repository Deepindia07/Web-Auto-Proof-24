import 'package:flutter/widgets.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? mobileLarge;
  final Widget? tab;
  final Widget? largeTablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.mobileLarge,
    this.tab,
    this.largeTablet,
    required this.desktop,
  }) : super(key: key);

  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static bool isMobile(BuildContext context) => width(context) <= 700;
  static bool isMobileLarge(BuildContext context) =>
      width(context) > 700 && width(context) < 900;
  static bool isTablet(BuildContext context) =>
      width(context) >= 700 && width(context) <= 1024;
  static bool isLargeTablet(BuildContext context) =>
      width(context) > 1024 && width(context) <= 1366;
  static bool isDesktop(BuildContext context) => width(context) >= 1024;

  @override
  Widget build(BuildContext context) {
    final w = width(context);

    if (isMobile(context)) return mobile;
    // prefer mobileLarge (phones in larger sizes) if provided
    if (isMobileLarge(context) && mobileLarge != null) return mobileLarge!;
    if (isTablet(context) && tab != null) return tab!;
    if (isLargeTablet(context) && largeTablet != null) return largeTablet!;
    return desktop;
  }
}
