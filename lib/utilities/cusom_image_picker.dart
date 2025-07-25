import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image/image.dart' as img;

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
      // For iOS, check if camera is available first
      if (!await _picker.supportsImageSource(ImageSource.camera)) {
        _showErrorMessage('Camera is not available on this device');
        Navigator.of(context).pop();
        return;
      }

      // Different permission handling for iOS vs Android
      if (Platform.isIOS) {
        // On iOS, image_picker handles permissions automatically
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
      } else {
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
      }
    } catch (e) {
      print('Camera error: $e');
      _showErrorMessage('Error capturing image: $e');
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      if (Platform.isIOS) {
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
      } else {
        // Android permission handling
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
      }
    } catch (e) {
      print('Gallery error: $e'); // Add logging
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
  final String? referenceImagePath;

  const CustomCameraView({
    Key? key,
    this.carPart,
    this.referenceImagePath,
  }) : super(key: key);

  @override
  State<CustomCameraView> createState() => _CustomCameraViewState();
}

class _CustomCameraViewState extends State<CustomCameraView> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _isCameraInitialized = false;
  bool _isTorchOn = false;
  int _selectedCameraIndex = 0;

  // Key to get the container's position and size
  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _setLandscapeOrientation();
    _initializeCamera();
  }

  Future<void> _setLandscapeOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
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

  Future<void> _toggleTorch() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      await _controller!.setFlashMode(
        _isTorchOn ? FlashMode.off : FlashMode.torch,
      );
      setState(() {
        _isTorchOn = !_isTorchOn;
      });
    } catch (e) {
      print('Error toggling torch: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error toggling flash'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Get the crop rectangle based on container position
  Rect _getCropRect() {
    final RenderBox? containerBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
    final RenderBox? cameraBox = context.findRenderObject() as RenderBox?;

    if (containerBox == null || cameraBox == null) {
      // Fallback to center crop if we can't get positions
      final screenSize = MediaQuery.of(context).size;
      final containerWidth = screenSize.width * 0.6;
      final containerHeight = screenSize.height * 0.9;
      final left = (screenSize.width - containerWidth) / 2;
      final top = (screenSize.height - containerHeight) / 2;

      return Rect.fromLTWH(left, top, containerWidth, containerHeight);
    }

    final containerPosition = containerBox.localToGlobal(Offset.zero, ancestor: cameraBox);
    final containerSize = containerBox.size;

    return Rect.fromLTWH(
      containerPosition.dx,
      containerPosition.dy,
      containerSize.width,
      containerSize.height,
    );
  }

  // Crop the image to the container area
  Future<File> _cropImage(String imagePath) async {
    try {
      // Read the original image
      final bytes = await File(imagePath).readAsBytes();
      final originalImage = img.decodeImage(bytes);

      if (originalImage == null) {
        throw Exception('Could not decode image');
      }

      // Get screen dimensions and camera preview dimensions
      final screenSize = MediaQuery.of(context).size;
      final cropRect = _getCropRect();

      // Calculate the scaling factors
      final scaleX = originalImage.width / screenSize.width;
      final scaleY = originalImage.height / screenSize.height;

      // Calculate crop coordinates in image space
      final cropX = (cropRect.left * scaleX).round();
      final cropY = (cropRect.top * scaleY).round();
      final cropWidth = (cropRect.width * scaleX).round();
      final cropHeight = (cropRect.height * scaleY).round();

      // Ensure crop coordinates are within image bounds
      final actualCropX = cropX.clamp(0, originalImage.width - 1);
      final actualCropY = cropY.clamp(0, originalImage.height - 1);
      final actualCropWidth = (cropWidth).clamp(1, originalImage.width - actualCropX);
      final actualCropHeight = (cropHeight).clamp(1, originalImage.height - actualCropY);

      // Crop the image
      final croppedImage = img.copyCrop(
        originalImage,
        x: actualCropX,
        y: actualCropY,
        width: actualCropWidth,
        height: actualCropHeight,
      );

      // Save the cropped image
      final croppedImagePath = imagePath.replaceAll('.jpg', '_cropped.jpg');
      final croppedFile = File(croppedImagePath);
      await croppedFile.writeAsBytes(img.encodeJpg(croppedImage));

      // Delete the original uncropped image
      await File(imagePath).delete();

      return croppedFile;
    } catch (e) {
      print('Error cropping image: $e');
      // Return original file if cropping fails
      return File(imagePath);
    }
  }

  // Modified take picture method with cropping
  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final XFile image = await _controller!.takePicture();

      // Crop the image to the container area
      final croppedFile = await _cropImage(image.path);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Picture taken and cropped for ${widget.carPart ?? 'car part'}'),
            backgroundColor: Colors.green,
          ),
        );

        // Return the cropped image path
        Navigator.pop(context, croppedFile.path);
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

  Widget _buildReferenceImage() {
    if (widget.referenceImagePath == null || widget.referenceImagePath!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(9),
        ),
      );
    }

    if (widget.referenceImagePath!.startsWith('assets/')) {
      return Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.0),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Image.asset(
            widget.referenceImagePath!,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              print('Error loading asset image: $error');
              return Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(
          child: Image.file(
            File(widget.referenceImagePath!),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              print('Error loading file image: $error');
              return Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
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

            // Container with GlobalKey for position tracking
            if (_isCameraInitialized)
              Center(
                child: Container(
                  key: _containerKey, // Add the key here
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent, width: 2), // Made border visible
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: widget.referenceImagePath != null
                        ? Stack(
                      children: [
                        _buildReferenceImage(),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.0),
                            borderRadius: BorderRadius.circular(9),
                          ),
                        ),
                      ],
                    )
                        : Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Center(
                        child: Text(
                          'ALIGN CAR PART\nWITHIN THIS FRAME',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // Car part label
            if (_isCameraInitialized && widget.carPart != null)
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                  ),
                  child: Text(
                    'CAPTURING: ${widget.carPart!.toUpperCase()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

            // Back button
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

            // Flash toggle
            Positioned(
              top: 20,
              right: 20,
              child: GestureDetector(
                onTap: _toggleTorch,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isTorchOn ? Colors.yellow.withOpacity(0.8) : Colors.black54,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    _isTorchOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),

            // Camera status indicator
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
                    if (_isTorchOn) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.flash_on,
                        color: Colors.yellow,
                        size: 12,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Capture button
            Positioned(
              right: 40,
              top: 0,
              bottom: 0,
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