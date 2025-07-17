import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class CustomImageSelector {
  static Future<File?> show(
      BuildContext context, {
        String? title,
        Color? primaryColor,
        Color? backgroundColor,
      }) async {
    return await showDialog<File?>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return _ImageSelectorDialog(
          title: title,
          primaryColor: primaryColor,
          backgroundColor: backgroundColor,
        );
      },
    );
  }
}

class _ImageSelectorDialog extends StatefulWidget {
  final String? title;
  final Color? primaryColor;
  final Color? backgroundColor;

  const _ImageSelectorDialog({
    Key? key,
    this.title,
    this.primaryColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<_ImageSelectorDialog> createState() => _ImageSelectorDialogState();
}

class _ImageSelectorDialogState extends State<_ImageSelectorDialog>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: (widget.primaryColor ?? Colors.blue[800])!.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (widget.primaryColor ?? Colors.blue[800])!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: widget.primaryColor ?? Colors.blue[800],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: widget.primaryColor ?? Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      // Check camera permission
      var cameraStatus = await Permission.camera.request();
      if (cameraStatus.isDenied) {
        _showPermissionDialog('Camera');
        return;
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        Navigator.of(context).pop(File(image.path));
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      _showErrorMessage('Error capturing image: $e');
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      // Check gallery permission
      var storageStatus = await Permission.storage.request();
      if (storageStatus.isDenied) {
        _showPermissionDialog('Storage');
        return;
      }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        Navigator.of(context).pop(File(image.path));
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      _showErrorMessage('Error selecting image: $e');
      Navigator.of(context).pop();
    }
  }

  void _showPermissionDialog(String permissionType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Permission Required'),
        content: Text('$permissionType permission is required to select images.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pop();
              openAppSettings();
            },
            child: Text('Settings'),
          ),
        ],
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        backgroundColor: widget.backgroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          widget.title ?? 'Select Image Source',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: widget.primaryColor ?? Colors.blue[800],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSourceOption(
              icon: Icons.camera_alt,
              title: 'Camera',
              subtitle: 'Take a new photo',
              onTap: _pickImageFromCamera,
            ),
            const SizedBox(height: 16),
            _buildSourceOption(
              icon: Icons.photo_library,
              title: 'Gallery',
              subtitle: 'Choose from gallery',
              onTap: _pickImageFromGallery,
            ),
          ],
        ),
      ),
    );
  }
}
