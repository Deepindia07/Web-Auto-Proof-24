import 'package:auto_proof/utilities/extensions/routing_animation.dart';
import 'package:flutter/material.dart';

extension AppAnimationExtension on AppAnimations {
  static RouteTransitionsBuilder get defaultTransition => AppAnimations.slideFromRight;
  static RouteTransitionsBuilder get authTransition => AppAnimations.slideFromBottom;
  static RouteTransitionsBuilder get modalTransition => AppAnimations.scaleWithFade;
  static RouteTransitionsBuilder get splashTransition => AppAnimations.fadeIn;
}