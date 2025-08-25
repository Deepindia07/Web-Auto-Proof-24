import 'package:auto_proof/constants/const_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_textstyle.dart';

/*
class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool filled;
  final bool showCursor;
  final Color? cursorColor;
  final TextAlign textAlign;
  final bool autovalidateMode;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.validator,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.filled = true,
    this.showCursor = true,
    this.cursorColor,
    this.textAlign = TextAlign.start,
    this.autovalidateMode = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText!,
              style: widget.labelStyle ??
                  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          onEditingComplete: widget.onEditingComplete,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autofocus,
          showCursor: widget.showCursor,
          cursorColor: widget.cursorColor ?? theme.primaryColor,
          textAlign: widget.textAlign,
          autovalidateMode: widget.autovalidateMode
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          style: widget.textStyle ?? TextStyle(
            fontSize: 16,
            color: theme.colorScheme.onSurface,
          ),
          decoration: InputDecoration(isDense: true,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ?? TextStyle(
              fontSize: 16,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            errorText: widget.errorText,
            helperText: widget.helperText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            filled: widget.filled,
            fillColor: widget.fillColor ??
                (widget.enabled
                    ? theme.colorScheme.surface
                    : theme.colorScheme.surface.withOpacity(0.5)),
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            border: _buildBorder(
              widget.borderColor ?? AppColor().darkCharcoalBlueColor,
            ),
            enabledBorder: _buildBorder(
              widget.borderColor ?? theme.colorScheme.outline,
            ),
            focusedBorder: _buildBorder(
              widget.focusedBorderColor ?? theme.primaryColor,
            ),
            errorBorder: _buildBorder(
              widget.errorBorderColor ?? theme.colorScheme.error,
            ),
            focusedErrorBorder: _buildBorder(
              widget.errorBorderColor ?? theme.colorScheme.error,
            ),
            disabledBorder: _buildBorder(
              AppColor().darkCharcoalBlueColor
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(
        color: color,
        width: widget.borderWidth,
      ),
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final String? hintText;
  final Widget? prefix;
  final Color? focusedBorderColor;
  final TextStyle? textStyle;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final double borderRadius;
  final Color? fillColor;
  final double borderWidth;

  const CustomPasswordField({
    Key? key,
    this.hintText = 'Enter password',
    this.prefix,
    this.textStyle,
    this.controller,
    this.focusedBorderColor,
    this.onChanged,
    this.fillColor,
    this.validator,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: widget.hintText,
      textStyle: widget.textStyle,
      controller: widget.controller,
      focusedBorderColor: widget.focusedBorderColor,
      obscureText: _obscureText,
      prefixIcon: widget.prefix,
      hintStyle: MontserratStyles.montserratSemiBoldTextStyle(size: 14,color: AppColor().silverShadeGrayColor),
      borderRadius: widget.borderRadius ,
      fillColor: widget.fillColor,
      borderWidth: widget.borderWidth,
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),

    );
  }

}

class CustomSearchField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final double borderRadius;

  const CustomSearchField({
    Key? key,
    this.hintText = 'Search...',
    this.controller,
    this.onChanged,
    this.onClear,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: hintText,
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: controller?.text.isNotEmpty == true
          ? IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          controller?.clear();
          onClear?.call();
        },
      )
          : null,
    );
  }
}

*/

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final String? helperText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final bool autofocus;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final Color? fillColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool filled;
  final bool showCursor;
  final Color? cursorColor;
  final TextAlign textAlign;
  final bool autovalidateMode;
  final String? obscuringCharacter;
  bool? isRequired = false;

  CustomTextField({
    Key? key,
    this.hintText,
    this.isRequired,
    this.labelText,
    this.errorText,
    this.helperText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onEditingComplete,
    this.validator,
    this.inputFormatters,
    this.focusNode,
    this.autofocus = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.fillColor,
    this.borderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.filled = true,
    this.showCursor = true,
    this.cursorColor,
    this.textAlign = TextAlign.start,
    this.autovalidateMode = false,
    this.obscuringCharacter,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Text(
                  widget.labelText!,
                  style:
                      widget.labelStyle ??
                      MontserratStyles.montserratSemiBoldTextStyle(
                        size: 15,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                ), if (widget.isRequired == true)
                  Text(' *', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),

        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          onEditingComplete: widget.onEditingComplete,
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          autofocus: widget.autofocus,
          showCursor: widget.showCursor,
          cursorColor: widget.cursorColor ?? theme.primaryColor,
          textAlign: widget.textAlign,
          autovalidateMode: widget.autovalidateMode
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          style:
              widget.textStyle ??
              TextStyle(fontSize: 16, color: theme.colorScheme.onSurface),
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
            errorText: widget.errorText,
            helperText: widget.helperText,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            prefixText: widget.prefixText,
            suffixText: widget.suffixText,
            filled: widget.filled,
            fillColor:
                widget.fillColor ??
                (widget.enabled
                    ? Colors.transparent
                    : Colors.transparent.withOpacity(0.5)),
            contentPadding:
                widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: _buildBorder(
              widget.borderColor ?? AppColor().darkCharcoalBlueColor,
            ),
            enabledBorder: _buildBorder(
              widget.borderColor ?? theme.colorScheme.outline,
            ),
            focusedBorder: _buildBorder(
              widget.focusedBorderColor ?? theme.primaryColor,
            ),
            errorBorder: _buildBorder(
              widget.errorBorderColor ?? theme.colorScheme.error,
            ),
            focusedErrorBorder: _buildBorder(
              widget.errorBorderColor ?? theme.colorScheme.error,
            ),
            disabledBorder: _buildBorder(AppColor().darkCharcoalBlueColor),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: BorderSide(color: color, width: widget.borderWidth),
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final String? hintText;
  final Widget? prefix;
  final Color? focusedBorderColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final double borderWidth;
  final String? obscuringCharacter;
  final ValueChanged<String>? onSubmitted;
  const CustomPasswordField({
    Key? key,
    this.hintText = 'Enter password',
    this.prefix,
    this.textStyle,
    this.controller,
    this.focusedBorderColor,
    this.onChanged,
    this.fillColor,
    this.validator,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.obscuringCharacter,
    this.hintStyle,
    this.onSubmitted,
    this.borderColor,
  }) : super(key: key);

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onSubmitted: widget.onSubmitted,
      hintText: widget.hintText,
      textStyle: widget.textStyle,
      controller: widget.controller,
      focusedBorderColor: widget.focusedBorderColor,
      obscureText: _obscureText,
      prefixIcon: widget.prefix,
      hintStyle: widget.hintStyle,
      borderRadius: widget.borderRadius,
      fillColor: widget.fillColor,
      borderColor: widget.borderColor,
      borderWidth: widget.borderWidth,
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
      obscuringCharacter: widget.obscuringCharacter ?? "",
    );
  }
}

class CustomSearchField extends StatelessWidget {
  final String? hintText;
  final String? obscuringCharacter;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final double borderRadius;

  const CustomSearchField({
    Key? key,
    this.hintText = 'Search...',
    this.controller,
    this.onChanged,
    this.onClear,
    this.borderRadius = 8.0,
    this.obscuringCharacter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: hintText,
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: controller?.text.isNotEmpty == true
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                controller?.clear();
                onClear?.call();
              },
            )
          : null,
      obscuringCharacter: obscuringCharacter ?? "",
    );
  }
}
