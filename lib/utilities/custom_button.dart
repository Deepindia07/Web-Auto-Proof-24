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
  final bool isLoading1;
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
    this.isLoading1 = false,
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
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColor().darkCharcoalBlueColor,
          foregroundColor: textColor ?? Colors.white,
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            side: side ?? BorderSide(color: Colors.white, width: 3),
          ),
          elevation: elevation,
        ),
        child: child != null
            ? const SizedBox(
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
                    style:
                        textStyle ??
                        const TextStyle(
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
    final defaultSelectedColor =
        selectedColor ?? AppColor().darkCharcoalBlueColor;
    final defaultUnselectedColor =
        unselectedColor ?? AppColor().darkCharcoalBlueColor;
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
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
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
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      style:
                          textStyle?.copyWith(color: defaultTextColor) ??
                          MontserratStyles.montserratSemiBoldTextStyle(
                            size: 15,
                            color: AppColor().darkYellowColor,
                          ),
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
                            color: isSelected
                                ? Colors.amber
                                : AppColor().darkYellowColor,
                            width: 2,
                            strokeAlign: BorderSide.strokeAlignInside,
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

class CustomButtonWeb extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double? textSize;
  final EdgeInsetsGeometry? padding;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final Color? containerColor;
  final bool? isLoading;

  const CustomButtonWeb({
    super.key,
    required this.text,
    required this.onPressed,
    this.padding,
    required this.color,
    required this.textColor,
    required this.borderRadius,
    this.containerColor,
    this.width,
    this.textSize,
    this.height,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: containerColor ?? Colors.white,
            boxShadow: containerColor != null
                ? []
                : [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 4), // Shadow position
                    ),
                  ],
          ),
          child: Container(
            width: width,
            padding:
                padding ??
                EdgeInsets.symmetric(vertical: height ?? 10, horizontal: 20),
            decoration: BoxDecoration(
              color: color, // Button color
              borderRadius: BorderRadius.circular(
                borderRadius,
              ), // Rounded corners
            ),
            child: isLoading == true
                ? Center(
                    child: SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColor().yellowWarmColor,
                      ),
                    ),
                  )
                : Text(
                    textAlign: TextAlign.center,
                    text,
                    style: MontserratStyles.montserratMediumTextStyle(
                      size: textSize ?? 14,
                      color: textColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

Widget buildCustomRadio(String text, bool isSelected) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    decoration: BoxDecoration(
      color: Color(0xFF232F4B), // dark navy background
      borderRadius: BorderRadius.circular(40),
      boxShadow: [
        BoxShadow(color: Colors.black12, offset: Offset(0, 4), blurRadius: 6),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.amber,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.amber, width: 2),
          ),
          child: isSelected
              ? Center(
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : null,
        ),
      ],
    ),
  );
}
