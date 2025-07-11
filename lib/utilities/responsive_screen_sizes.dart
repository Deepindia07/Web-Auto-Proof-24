import 'package:flutter/material.dart';

/// Responsive size manager for Flutter applications
/// Handles all screen types: mobile, tablet, desktop, and large screens
class ResponsiveSizes {
  static const double _mobileMaxWidth = 768;
  static const double _tabletMaxWidth = 1024;
  static const double _desktopMaxWidth = 1440;

  final BuildContext context;

  ResponsiveSizes(this.context);

  /// Get screen width
  double get screenWidth => MediaQuery.of(context).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(context).size.height;

  /// Check if current screen is mobile
  bool get isMobile => screenWidth < _mobileMaxWidth;

  /// Check if current screen is tablet
  bool get isTablet => screenWidth >= _mobileMaxWidth && screenWidth < _tabletMaxWidth;

  /// Check if current screen is desktop
  bool get isDesktop => screenWidth >= _tabletMaxWidth && screenWidth < _desktopMaxWidth;

  /// Check if current screen is large desktop
  bool get isLargeDesktop => screenWidth >= _desktopMaxWidth;

  /// Get device type as enum
  DeviceType get deviceType {
    if (isMobile) return DeviceType.mobile;
    if (isTablet) return DeviceType.tablet;
    if (isDesktop) return DeviceType.desktop;
    return DeviceType.largeDesktop;
  }

  /// Responsive width based on percentage
  double widthPercent(double percentage) {
    return screenWidth * (percentage / 100);
  }

  /// Responsive height based on percentage
  double heightPercent(double percentage) {
    return screenHeight * (percentage / 100);
  }

  /// Responsive font size
  double fontSize(double baseFontSize) {
    if (isMobile) return baseFontSize * 0.9;
    if (isTablet) return baseFontSize * 1.0;
    if (isDesktop) return baseFontSize * 1.1;
    return baseFontSize * 1.2; // Large desktop
  }

  /// Responsive padding
  EdgeInsets padding({
    double? mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    double value;
    if (isMobile) {
      value = mobile ?? 16.0;
    } else if (isTablet) {
      value = tablet ?? 24.0;
    } else if (isDesktop) {
      value = desktop ?? 32.0;
    } else {
      value = largeDesktop ?? 40.0;
    }
    return EdgeInsets.all(value);
  }

  /// Responsive margin
  EdgeInsets margin({
    double? mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    double value;
    if (isMobile) {
      value = mobile ?? 8.0;
    } else if (isTablet) {
      value = tablet ?? 16.0;
    } else if (isDesktop) {
      value = desktop ?? 24.0;
    } else {
      value = largeDesktop ?? 32.0;
    }
    return EdgeInsets.all(value);
  }

  /// Responsive spacing
  double spacing({
    double? mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    if (isMobile) return mobile ?? 8.0;
    if (isTablet) return tablet ?? 12.0;
    if (isDesktop) return desktop ?? 16.0;
    return largeDesktop ?? 20.0;
  }

  /// Responsive icon size
  double iconSize({
    double? mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    if (isMobile) return mobile ?? 24.0;
    if (isTablet) return tablet ?? 28.0;
    if (isDesktop) return desktop ?? 32.0;
    return largeDesktop ?? 36.0;
  }

  /// Responsive button height
  double buttonHeight({
    double? mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    if (isMobile) return mobile ?? 48.0;
    if (isTablet) return tablet ?? 52.0;
    if (isDesktop) return desktop ?? 56.0;
    return largeDesktop ?? 60.0;
  }

  /// Responsive grid columns
  int gridColumns({
    int? mobile,
    int? tablet,
    int? desktop,
    int? largeDesktop,
  }) {
    if (isMobile) return mobile ?? 1;
    if (isTablet) return tablet ?? 2;
    if (isDesktop) return desktop ?? 3;
    return largeDesktop ?? 4;
  }

  /// Responsive value selector
  T responsive<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    if (isMobile) return mobile;
    if (isTablet) return tablet ?? mobile;
    if (isDesktop) return desktop ?? tablet ?? mobile;
    return largeDesktop ?? desktop ?? tablet ?? mobile;
  }

  /// Get responsive container width
  double containerWidth({
    double? mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
  }) {
    if (isMobile) return mobile ?? screenWidth * 0.9;
    if (isTablet) return tablet ?? screenWidth * 0.85;
    if (isDesktop) return desktop ?? screenWidth * 0.8;
    return largeDesktop ?? screenWidth * 0.75;
  }

  /// Get responsive app bar height
  double appBarHeight() {
    if (isMobile) return 56.0;
    if (isTablet) return 64.0;
    return 72.0; // Desktop and large desktop
  }

  /// Get responsive navigation rail width
  double navigationRailWidth() {
    if (isMobile) return 56.0;
    if (isTablet) return 72.0;
    return 80.0; // Desktop and large desktop
  }

  /// Get responsive text scale factor
  double textScaleFactor() {
    if (isMobile) return 0.9;
    if (isTablet) return 1.0;
    if (isDesktop) return 1.1;
    return 1.2; // Large desktop
  }
}

/// Device type enumeration
enum DeviceType {
  mobile,
  tablet,
  desktop,
  largeDesktop,
}

/// Extension for easy access to ResponsiveSizes
extension ResponsiveExtension on BuildContext {
  ResponsiveSizes get responsive => ResponsiveSizes(this);
}

/// Responsive widget builder
class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveSizes responsive) builder;

  const ResponsiveBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context, ResponsiveSizes(context));
  }
}

/// Responsive layout widget
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  final Widget? largeDesktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSizes(context);

    return responsive.responsive<Widget>(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }
}

/// Responsive text widget
class ResponsiveText extends StatelessWidget {
  final String text;
  final double baseFontSize;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const ResponsiveText(
      this.text, {
        Key? key,
        this.baseFontSize = 14.0,
        this.style,
        this.textAlign,
        this.maxLines,
        this.overflow,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSizes(context);

    return Text(
      text,
      style: (style ?? const TextStyle()).copyWith(
        fontSize: responsive.fontSize(baseFontSize),
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Responsive container widget
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? mobileWidth;
  final double? tabletWidth;
  final double? desktopWidth;
  final double? largeDesktopWidth;
  final Color? color;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Decoration? decoration;

  const ResponsiveContainer({
    Key? key,
    required this.child,
    this.mobileWidth,
    this.tabletWidth,
    this.desktopWidth,
    this.largeDesktopWidth,
    this.color,
    this.padding,
    this.margin,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveSizes(context);

    return Container(
      width: responsive.containerWidth(
        mobile: mobileWidth,
        tablet: tabletWidth,
        desktop: desktopWidth,
        largeDesktop: largeDesktopWidth,
      ),
      padding: padding ?? responsive.padding(),
      margin: margin ?? responsive.margin(),
      decoration: decoration,
      color: color,
      child: child,
    );
  }
}

/// Usage example
class ExampleUsage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Responsive Sizes Example'),
        toolbarHeight: context.responsive.appBarHeight(),
      ),
      body: ResponsiveBuilder(
        builder: (context, responsive) {
          return SingleChildScrollView(
            padding: responsive.padding(),
            child: Column(
              children: [
                // Responsive text
                ResponsiveText(
                  'This is responsive text!',
                  baseFontSize: 24.0,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                SizedBox(height: responsive.spacing()),

                // Responsive container
                ResponsiveContainer(
                  color: Colors.blue.shade100,
                  child: ResponsiveText(
                    'This container adapts to screen size',
                    baseFontSize: 16.0,
                  ),
                ),

                SizedBox(height: responsive.spacing()),

                // Responsive grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: responsive.gridColumns(),
                    crossAxisSpacing: responsive.spacing(),
                    mainAxisSpacing: responsive.spacing(),
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      color: Colors.green.shade200,
                      child: Center(
                        child: ResponsiveText(
                          'Item $index',
                          baseFontSize: 16.0,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: responsive.spacing()),

                // Responsive button
                SizedBox(
                  width: responsive.widthPercent(responsive.isMobile ? 100 : 50),
                  height: responsive.buttonHeight(),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: ResponsiveText(
                      'Responsive Button',
                      baseFontSize: 16.0,
                    ),
                  ),
                ),

                SizedBox(height: responsive.spacing()),

                // Device type indicator
                Container(
                  padding: responsive.padding(),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ResponsiveText(
                    'Current device: ${responsive.deviceType.toString().split('.').last}',
                    baseFontSize: 14.0,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}