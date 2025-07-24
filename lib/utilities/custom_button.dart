import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final TextStyle? textStyle;
  final bool isLoading;
  final IconData? icon;
  final double? elevation;
  final BorderSide? side;
  final Widget? child;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = 8.0,
    this.textStyle,
    this.isLoading = false,
    this.elevation,
    this.side,
    this.icon,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48.0,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColor().darkCharcoalBlueColor,
          foregroundColor: textColor ?? Colors.white,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            side: side ?? BorderSide(color: Colors.white,width: 3 )
          ),
          elevation: elevation,
        ),
        child: child!=null ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: textStyle ?? const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomRoleSelectionButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? textColor;
  final Color? selectedTextColor;
  final double? height;
  final double? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  const CustomRoleSelectionButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.selectedColor,
    this.unselectedColor,
    this.textColor,
    this.selectedTextColor,
    this.height = 60.0,
    this.borderRadius = 30.0,
    this.padding,
    this.textStyle,
    this.leadingIcon,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultSelectedColor = selectedColor ?? AppColor().darkCharcoalBlueColor;
    final defaultUnselectedColor = unselectedColor ?? AppColor().darkCharcoalBlueColor;
    final defaultTextColor = isSelected
        ? (selectedTextColor ?? Colors.amber)
        : (textColor ?? Colors.grey);

    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(30.0),
      shadowColor: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: height,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: isSelected ? defaultSelectedColor : defaultUnselectedColor,
              borderRadius: BorderRadius.circular(borderRadius!),
              border: isSelected
                  ? Border.all(color: Colors.amber.withOpacity(0.3), width: 1)
                  : null,
              boxShadow: isSelected
                  ? [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
                  : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      style: textStyle?.copyWith(color: defaultTextColor) ??
                          MontserratStyles.montserratSemiBoldTextStyle(size: 20,color: AppColor().darkYellowColor)
                    ),
                  ),

                  trailingIcon ??
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? Colors.amber : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? Colors.amber : AppColor().darkYellowColor,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignInside
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
