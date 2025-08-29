import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'custom_textstyle.dart';

class RadioDropdownOption {
  final String value;
  final String label;
  final Widget? icon;

  RadioDropdownOption({required this.value, required this.label, this.icon});
}

class RadioDropdownField extends StatefulWidget {
  final List<RadioDropdownOption> options;
  final String? label;
  final String? placeholder;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final bool required;
  final bool enabled;
  final String? errorText;
  final EdgeInsets? padding;
  final double? width;
  final double? maxHeight;
  final Color? backGroundColor;

  const RadioDropdownField({
    Key? key,
    required this.options,
    this.label,
    this.placeholder,
    this.value,
    this.onChanged,
    this.required = false,
    this.enabled = true,
    this.errorText,
    this.padding,
    this.width,
    this.maxHeight = 300,
    this.backGroundColor,
  }) : super(key: key);

  @override
  State<RadioDropdownField> createState() => _RadioDropdownFieldState();
}

class _RadioDropdownFieldState extends State<RadioDropdownField>
    with SingleTickerProviderStateMixin {
  final GlobalKey _dropdownKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _safeCloseDropdown(); // ✅ Safe version (calls reverse + removes overlay)
    _animationController
        .dispose(); // Only dispose after dropdown animation is complete
    super.dispose();
  }

  void _safeCloseDropdown() {
    if (_isOpen && _overlayEntry != null) {
      _animationController.reverse().then((_) {
        if (_overlayEntry?.mounted ?? false) {
          _overlayEntry?.remove();
          _overlayEntry = null;
        }

        if (mounted) {
          setState(() {
            _isOpen = false;
          });
        }
      });
    }
  }

  void _toggleDropdown() {
    if (!widget.enabled) return;

    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _animationController.forward();
    setState(() {
      _isOpen = true;
    });
  }

  void _closeDropdown() {
    if (_overlayEntry != null) {
      _animationController.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    }
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  void _selectOption(String value) {
    widget.onChanged?.call(value);
    _closeDropdown();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox =
        _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        width: widget.width ?? size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 4.0),
          child: Material(
            elevation: 2.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _animation.value,
                  alignment: Alignment.topCenter,
                  child: Opacity(
                    opacity: _animation.value,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: widget.maxHeight ?? 3000,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          shrinkWrap: true,
                          itemCount: widget.options.length,
                          itemBuilder: (context, index) {
                            final option = widget.options[index];
                            final isSelected = widget.value == option.value;

                            return InkWell(
                              onTap: () => _selectOption(option.value),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 2.0,
                                  vertical: 2.0,
                                ),
                                child: Row(
                                  children: [
                                    Radio<String>(
                                      value: option.value,
                                      groupValue: widget.value,
                                      onChanged: (value) {
                                        if (value != null) {
                                          _selectOption(value);
                                        }
                                      },
                                      activeColor: Theme.of(
                                        context,
                                      ).primaryColor,
                                    ),
                                    hGap(8),
                                    if (option.icon != null) ...[
                                      option.icon!,
                                      const SizedBox(width: 8.0),
                                    ],
                                    Expanded(
                                      child: Text(
                                        option.label,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Theme.of(context).primaryColor
                                              : Colors.black87,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (isSelected)
                                      Icon(
                                        Icons.check,
                                        color: Theme.of(context).primaryColor,
                                        size: 20.0,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedOption = widget.options.firstWhere(
      (option) => option.value == widget.value,
      orElse: () => RadioDropdownOption(value: '', label: ''),
    );

    return Container(
      width: widget.width,
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RichText(
                text: TextSpan(
                  text: widget.label!,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    if (widget.required)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),
          CompositedTransformTarget(
            link: _layerLink,
            child: GestureDetector(
              key: _dropdownKey,
              onTap: _toggleDropdown,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  color: widget.enabled ? widget.backGroundColor : Colors.white,
                  border: Border.all(
                    color: widget.errorText != null
                        ? Colors.red
                        : _isOpen
                        ? Theme.of(context).primaryColor
                        : AppColor().darkCharcoalBlueColor,
                    width: _isOpen ? 2.0 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          if (selectedOption.icon != null) ...[
                            selectedOption.icon!,
                            const SizedBox(width: 8.0),
                          ],
                          Expanded(
                            child: Text(
                              selectedOption.label.isNotEmpty
                                  ? selectedOption.label
                                  : widget.placeholder ?? 'options',
                              style: TextStyle(
                                color: selectedOption.label.isNotEmpty
                                    ? Colors.black87
                                    : Colors.grey.shade500,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedRotation(
                      turns: _isOpen ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: widget.enabled
                            ? Colors.grey.shade600
                            : Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                widget.errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 12.0),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomDropdownNew extends StatefulWidget {
  final List<String> items;
  final String title;
  final TextStyle? textStyle;
  final String hint;
  final Widget? preFix;
  final double? borderRadius;
  final String? value;
  bool? isRequired = false;
  final void Function(String? val) onChanged;

   CustomDropdownNew({
    super.key,
    required this.items,
    required this.title,
     this.isRequired,
    required this.hint,
    required this.value,
    required this.onChanged,
    this.borderRadius,
    this.preFix,  this.textStyle,
  });

  @override
  State<CustomDropdownNew> createState() => _CustomDropdownNewState();
}

class _CustomDropdownNewState extends State<CustomDropdownNew> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Text(
                widget.title,
                style: widget.textStyle ??   MontserratStyles.montserratSemiBoldTextStyle(size: 15,color: AppColor().darkCharcoalBlueColor),
              ), if (widget.isRequired == true) Text(' *', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),

        // Dropdown
        DropdownButtonFormField<String>(
          value: widget.value?.isEmpty ?? true ? null : widget.value,
          decoration: InputDecoration(
            prefixIcon: widget.preFix,
            hintText: widget.hint,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
              borderSide: BorderSide(
                color: AppColor().darkCharcoalBlueColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
              borderSide: BorderSide(
                color: AppColor().darkCharcoalBlueColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
              borderSide: BorderSide(
                color:AppColor().darkCharcoalBlueColor,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
              borderSide: BorderSide(
                color: Colors.red,
                width:1,
              ),
            ),
          ),
          selectedItemBuilder: (context) {
            return widget.items
                .map(
                  (e) => Align(alignment: Alignment.centerLeft, child: Text(e)),
                )
                .toList();
          },

          items: widget.items.map((e) {
            return DropdownMenuItem<String>(
              value: e,
              // 👇 reduce height here
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4.0,
                ), // reduce item height
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Radio<String>(
                      value: e,
                      groupValue: widget.value,
                      onChanged: (_) {
                        widget.onChanged(e);
                        Navigator.pop(context);
                      },
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),

          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}

class GenderDropdownExample extends StatefulWidget {
  const GenderDropdownExample({super.key});

  @override
  State<GenderDropdownExample> createState() => _GenderDropdownExampleState();
}

class _GenderDropdownExampleState extends State<GenderDropdownExample> {
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    String? apiGender = "MALE";
    if (apiGender != null) {
      if (apiGender.toLowerCase() == "male") {
        selectedGender = "Male";
      } else if (apiGender.toLowerCase() == "female") {
        selectedGender = "Female";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: CustomDropdownNew(
                items: const ['Male', 'Female'],
                title: 'Gender',
                hint: 'Select Gender',
                value: selectedGender,
                onChanged: (val) {
                  setState(() => selectedGender = val);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
