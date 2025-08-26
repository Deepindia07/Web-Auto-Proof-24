import 'package:auto_proof/constants/const_color.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ToggleButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.83),
          decoration: BoxDecoration(
            color: isSelected ?AppColor().yellowWarmColor : AppColor().darkCharcoalBlueColor, // yellow & dark blue
            borderRadius: BorderRadius.circular(11.22),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.09,
              color: isSelected ? AppColor().darkCharcoalBlueColor: AppColor().yellowWarmColor,
            ),
          ),
        ),
      ),
    );
  }
}