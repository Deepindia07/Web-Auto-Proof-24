
import 'package:flutter/material.dart';

class AppAnimations {
  static const Duration fastDuration = Duration(milliseconds: 300);
  static const Duration normalDuration = Duration(milliseconds: 500);
  static const Duration slowDuration = Duration(milliseconds: 700);

  static const Curve defaultCurve = Curves.easeInOutCubic;
  static const Curve bouncyCurve = Curves.easeInOutQuart;
  static const Curve smoothCurve = Curves.easeInOutCirc;

  static Widget fadeIn(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: defaultCurve,
      ),
      child: child,
    );
  }

  static Widget slideFromRight(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;

    var slideTween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: defaultCurve),
    );

    return SlideTransition(
      position: animation.drive(slideTween),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: defaultCurve,
        ),
        child: child,
      ),
    );
  }

  static Widget slideFromBottom(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;

    var slideTween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: bouncyCurve),
    );

    var scaleTween = Tween(begin: 0.9, end: 1.0).chain(
      CurveTween(curve: bouncyCurve),
    );

    return SlideTransition(
      position: animation.drive(slideTween),
      child: ScaleTransition(
        scale: animation.drive(scaleTween),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: bouncyCurve,
          ),
          child: child,
        ),
      ),
    );
  }

  static Widget slideFromRightWithScale(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;

    var slideTween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: bouncyCurve),
    );

    var scaleTween = Tween(begin: 0.95, end: 1.0).chain(
      CurveTween(curve: bouncyCurve),
    );

    return SlideTransition(
      position: animation.drive(slideTween),
      child: ScaleTransition(
        scale: animation.drive(scaleTween),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: bouncyCurve,
          ),
          child: child,
        ),
      ),
    );
  }

  static Widget scaleWithFade(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    var scaleTween = Tween(begin: 0.9, end: 1.0).chain(
      CurveTween(curve: smoothCurve),
    );

    return ScaleTransition(
      scale: animation.drive(scaleTween),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: smoothCurve,
        ),
        child: child,
      ),
    );
  }

  static Widget slideFromLeft(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;

    var slideTween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: defaultCurve),
    );

    return SlideTransition(
      position: animation.drive(slideTween),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: defaultCurve,
        ),
        child: child,
      ),
    );
  }

  static Widget slideFromTop(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    const begin = Offset(0.0, -1.0);
    const end = Offset.zero;

    var slideTween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: bouncyCurve),
    );

    return SlideTransition(
      position: animation.drive(slideTween),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: bouncyCurve,
        ),
        child: child,
      ),
    );
  }

  static Widget rotationWithFade(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    var rotationTween = Tween(begin: 0.1, end: 0.0).chain(
      CurveTween(curve: defaultCurve),
    );

    var scaleTween = Tween(begin: 0.9, end: 1.0).chain(
      CurveTween(curve: defaultCurve),
    );

    return Transform.rotate(
      angle: animation.drive(rotationTween).value,
      child: ScaleTransition(
        scale: animation.drive(scaleTween),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: defaultCurve,
          ),
          child: child,
        ),
      ),
    );
  }

  static Widget carInventoryTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    const begin = Offset(1.5, 0.0);
    const end = Offset.zero;

    var slideTween = Tween(begin: begin, end: end).chain(
      CurveTween(curve: Curves.easeInOutBack),
    );

    var scaleTween = Tween(begin: 0.8, end: 1.0).chain(
      CurveTween(curve: Curves.elasticOut),
    );

    return SlideTransition(
      position: animation.drive(slideTween),
      child: ScaleTransition(
        scale: animation.drive(scaleTween),
        child: FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutQuart,
          ),
          child: child,
        ),
      ),
    );
  }
}