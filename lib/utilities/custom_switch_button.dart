import 'package:flutter/material.dart';

class CustomRectangularSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Duration animationDuration;
  final double borderRadius;
  final TextStyle? textStyle;

  const CustomRectangularSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.width = 110,
    this.height = 35,
    this.activeColor = const Color(0xFF28A745),
    this.inactiveColor = const Color(0xFFDC3545),
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 200),
    this.borderRadius = 6.0,
    this.textStyle,
  }) : super(key: key);

  @override
  _CustomRectangularSwitchState createState() => _CustomRectangularSwitchState();
}

class _CustomRectangularSwitchState extends State<CustomRectangularSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomRectangularSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Yes Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!widget.value) {
                        widget.onChanged(true);
                      }
                    },
                    child: AnimatedContainer(
                      duration: widget.animationDuration,
                      decoration: BoxDecoration(
                        color: widget.value ? widget.activeColor : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(widget.borderRadius - 1),
                          bottomLeft: Radius.circular(widget.borderRadius - 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Yes',
                          style: widget.textStyle?.copyWith(
                            color: widget.value
                                ? widget.activeTextColor
                                : Colors.grey.shade600,
                            fontWeight: widget.value ? FontWeight.w600 : FontWeight.w500,
                          ) ?? TextStyle(
                            color: widget.value
                                ? widget.activeTextColor
                                : Colors.grey.shade600,
                            fontWeight: widget.value ? FontWeight.w600 : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // No Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.value) {
                        widget.onChanged(false);
                      }
                    },
                    child: AnimatedContainer(
                      duration: widget.animationDuration,
                      decoration: BoxDecoration(
                        color: !widget.value ? widget.inactiveColor : Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(widget.borderRadius - 1),
                          bottomRight: Radius.circular(widget.borderRadius - 1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'No',
                          style: widget.textStyle?.copyWith(
                            color: !widget.value
                                ? widget.inactiveTextColor
                                : Colors.grey.shade600,
                            fontWeight: !widget.value ? FontWeight.w600 : FontWeight.w500,
                          ) ?? TextStyle(
                            color: !widget.value
                                ? widget.inactiveTextColor
                                : Colors.grey.shade600,
                            fontWeight: !widget.value ? FontWeight.w600 : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
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
