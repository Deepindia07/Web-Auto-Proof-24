import 'dart:io';
import 'package:camera/camera.dart';
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
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
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
                color: (widget.primaryColor ?? Colors.blue[800])!.withOpacity(
                  0.1,
                ),
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
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
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
        content: Text(
          '$permissionType permission is required to select images.',
        ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        backgroundColor: widget.backgroundColor ?? Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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

/// Image selection from inspection view
class CustomCameraView extends StatefulWidget {
  final String? carPart;

  const CustomCameraView({Key? key, this.carPart}) : super(key: key);

  @override
  State<CustomCameraView> createState() => _CustomCameraViewState();
}

class _CustomCameraViewState extends State<CustomCameraView> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        _controller = CameraController(
          cameras![_selectedCameraIndex],
          ResolutionPreset.high,
          enableAudio: false,
        );
        await _controller!.initialize();
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<void> _switchCamera() async {
    if (cameras == null || cameras!.length <= 1) return;

    setState(() {
      _isCameraInitialized = false;
    });

    await _controller?.dispose();
    _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras!.length;

    _controller = CameraController(
      cameras![_selectedCameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error switching camera: $e');
    }
  }

  // Method to take picture
  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final XFile image = await _controller!.takePicture();
      // Handle the captured image here
      // You can pass it back to the previous screen or save it

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Picture taken for ${widget.carPart ?? 'car part'}'),
            backgroundColor: Colors.green,
          ),
        );

        // Go back to the previous screen after taking picture
        Navigator.pop(context, image.path); // Return the image path
      }
    } catch (e) {
      print('Error taking picture: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error taking picture'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview
            if (_isCameraInitialized && _controller != null)
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CameraPreview(_controller!),
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),

            // Safe Area Rectangle Overlay
            if (_isCameraInitialized)
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),

            // Car Part Label - Show which part is being captured
            if (_isCameraInitialized && widget.carPart != null)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'CAPTURING: ${widget.carPart!.toUpperCase()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),

            // Safe Area Label
            if (_isCameraInitialized)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'SAFE AREA',
                      style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),

            // Back Button
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),

            // Camera Switch Button
            if (cameras != null && cameras!.length > 1)
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: _switchCamera,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.flip_camera_ios,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),

            // Camera Info
            Positioned(
              top: 80,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _isCameraInitialized ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isCameraInitialized ? 'LIVE' : 'CONNECTING',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Capture Button
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: _isCameraInitialized ? _takePicture : null,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: _isCameraInitialized ? Colors.white : Colors.grey,
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(color: Colors.black26, width: 3),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      color: _isCameraInitialized
                          ? Colors.black
                          : Colors.grey[600],
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
