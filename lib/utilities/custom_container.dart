import 'package:auto_proof/constants/const_color.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final double? elevation;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final Clip clipBehavior;
  final VoidCallback? onTap;

  const CustomContainer({
    super.key,
    this.child,
    this.elevation,
    this.backgroundColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.border,
    this.clipBehavior = Clip.none,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        child: Material(
          elevation: elevation ?? 0.0,
          color: backgroundColor ?? AppColor().darkCharcoalBlueColor,
          shadowColor: shadowColor ?? AppColor().lightSilverGrayColor,
          surfaceTintColor: surfaceTintColor ?? AppColor().lightSilverGrayColor,
          borderRadius: borderRadius ?? BorderRadius.zero,
          clipBehavior: clipBehavior,
          child: Container(
            padding: padding,
            decoration: border != null
                ? BoxDecoration(
              border: border,
              borderRadius: borderRadius ?? BorderRadius.zero,
            )
                : null,
            child: child,
          ),
        ),
      ),
    );
  }
}
