import 'package:flutter/material.dart';
import 'enum/cherrry_toast_enum.dart';

class CherryToast {
  static void show({
    required BuildContext context,
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
    String? title,
    VoidCallback? onTap,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => CherryToastWidget(
        message: message,
        type: type,
        title: title,
        onTap: onTap,
        onDismiss: () {
          overlayEntry.remove();
        },
      ),
    );

    overlay.insert(overlayEntry);

    // Auto dismiss after duration
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  static void success(BuildContext context, String message, {String? title}) {
    show(context: context, message: message, type: ToastType.success, title: title);
  }

  static void error(BuildContext context, String message, {String? title}) {
    show(context: context, message: message, type: ToastType.error, title: title);
  }

  static void warning(BuildContext context, String message, {String? title}) {
    show(context: context, message: message, type: ToastType.warning, title: title);
  }

  static void info(BuildContext context, String message, {String? title}) {
    show(context: context, message: message, type: ToastType.info, title: title);
  }
}

class CherryToastWidget extends StatefulWidget {
  final Color? backgroundColor;
  final String message;
  final ToastType type;
  final String? title;
  final VoidCallback? onTap;
  final VoidCallback onDismiss;

    CherryToastWidget({
    Key? key,
    required this.message,
    required this.type,
    this.backgroundColor,
    this.title,
    this.onTap,
    required this.onDismiss,
  }) : super(key: key);

  @override
  State<CherryToastWidget> createState() => _CherryToastWidgetState();
}

class _CherryToastWidgetState extends State<CherryToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Material(
                color: Colors.transparent,
                child: GestureDetector(
                  onTap: widget.onTap,
                  onPanUpdate: (details) {
                    if (details.delta.dy < -10) {
                      _dismiss();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor ?? _getBackgroundColor(),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getBorderColor(),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 4),
                          blurRadius: 12,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _getAccentColor(),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          _getIcon(),
                          color: _getAccentColor(),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.title != null)
                                Text(
                                  widget.title!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: _getTextColor(),
                                  ),
                                ),
                              if (widget.title != null) const SizedBox(height: 4),
                              Text(
                                widget.message,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _getTextColor().withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _dismiss,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: _getAccentColor().withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: _getAccentColor(),
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
        },
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (widget.type) {
      case ToastType.success:
        return const Color(0xFFF0F9FF);
      case ToastType.error:
        return const Color(0xFFFEF2F2);
      case ToastType.warning:
        return const Color(0xFFFFFBEB);
      case ToastType.info:
        return const Color(0xFFF0F9FF);
    }
  }

  Color _getBorderColor() {
    switch (widget.type) {
      case ToastType.success:
        return const Color(0xFFDCFDF7);
      case ToastType.error:
        return const Color(0xFFFECACA);
      case ToastType.warning:
        return const Color(0xFFFEF3C7);
      case ToastType.info:
        return const Color(0xFFDBEAFE);
    }
  }

  Color _getAccentColor() {
    switch (widget.type) {
      case ToastType.success:
        return const Color(0xFF10B981);
      case ToastType.error:
        return const Color(0xFFEF4444);
      case ToastType.warning:
        return const Color(0xFFF59E0B);
      case ToastType.info:
        return const Color(0xFF3B82F6);
    }
  }

  Color _getTextColor() {
    switch (widget.type) {
      case ToastType.success:
        return const Color(0xFF065F46);
      case ToastType.error:
        return const Color(0xFF991B1B);
      case ToastType.warning:
        return const Color(0xFF92400E);
      case ToastType.info:
        return const Color(0xFF1E40AF);
    }
  }

  IconData _getIcon() {
    switch (widget.type) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }
}

// cherry_toast_service.dart
class CherryToastService {
  static BuildContext? _context;

  static void initialize(BuildContext context) {
    _context = context;
  }

  static void showSuccess(String message, {String? title}) {
    if (_context != null) {
      CherryToast.success(_context!, message, title: title);
    }
  }

  static void showError(String message, {String? title}) {
    if (_context != null) {
      CherryToast.error(_context!, message, title: title);
    }
  }

  static void showWarning(String message, {String? title}) {
    if (_context != null) {
      CherryToast.warning(_context!, message, title: title);
    }
  }

  static void showInfo(String message, {String? title}) {
    if (_context != null) {
      CherryToast.info(_context!, message, title: title);
    }
  }

  static void show({
    required String message,
    ToastType type = ToastType.info,
    String? title,
    VoidCallback? onTap,
  }) {
    if (_context != null) {
      CherryToast.show(
        context: _context!,
        message: message,
        type: type,
        title: title,
        onTap: onTap,
      );
    }
  }
}