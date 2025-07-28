import 'dart:io';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
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

  // Responsive dimensions calculator
  Map<String, double> _getResponsiveDimensions(Size screenSize) {
    final isSmallScreen = screenSize.width < 600;
    final isMediumScreen = screenSize.width >= 600 && screenSize.width < 900;
    final isLargeScreen = screenSize.width >= 900;

    // Responsive capture area percentage
    double captureWidthPercentage;
    double captureHeightPercentage;

    if (isSmallScreen) {
      captureWidthPercentage = 0.6; // 60% for small screens
      captureHeightPercentage = 0.75;
    } else if (isMediumScreen) {
      captureWidthPercentage = 0.55; // 55% for medium screens
      captureHeightPercentage = 0.8;
    } else {
      captureWidthPercentage = 0.5; // 50% for large screens
      captureHeightPercentage = 0.85;
    }

    final captureWidth = screenSize.width * captureWidthPercentage;
    final captureHeight = screenSize.height * captureHeightPercentage;
    final sideWidth = (screenSize.width - captureWidth) / 2;

    // Responsive button sizes
    double buttonSize;
    double smallButtonSize;
    double fontSize;
    double smallFontSize;

    if (isSmallScreen) {
      buttonSize = 60;
      smallButtonSize = 40;
      fontSize = 10;
      smallFontSize = 8;
    } else if (isMediumScreen) {
      buttonSize = 70;
      smallButtonSize = 50;
      fontSize = 12;
      smallFontSize = 10;
    } else {
      buttonSize = 80;
      smallButtonSize = 55;
      fontSize = 14;
      smallFontSize = 12;
    }

    return {
      'captureWidth': captureWidth,
      'captureHeight': captureHeight,
      'sideWidth': sideWidth,
      'buttonSize': buttonSize,
      'smallButtonSize': smallButtonSize,
      'fontSize': fontSize,
      'smallFontSize': smallFontSize,
      'padding': isSmallScreen ? 8.0 : (isMediumScreen ? 12.0 : 16.0),
      'borderRadius': isSmallScreen ? 8.0 : (isMediumScreen ? 10.0 : 12.0),
    };
  }

  // Get the crop rectangle based on container position (center area only)
  Rect _getCropRect() {
    final screenSize = MediaQuery.of(context).size;
    final dimensions = _getResponsiveDimensions(screenSize);

    final captureWidth = dimensions['captureWidth']!;
    final captureHeight = dimensions['captureHeight']!;
    final left = (screenSize.width - captureWidth) / 2;
    final top = (screenSize.height - captureHeight) / 2;

    return Rect.fromLTWH(left, top, captureWidth, captureHeight);
  }

  // Crop the image to the center area only
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

      // Calculate crop coordinates in image space (center area only)
      final cropX = (cropRect.left * scaleX).round();
      final cropY = (cropRect.top * scaleY).round();
      final cropWidth = (cropRect.width * scaleX).round();
      final cropHeight = (cropRect.height * scaleY).round();

      // Ensure crop coordinates are within image bounds
      final actualCropX = cropX.clamp(0, originalImage.width - 1);
      final actualCropY = cropY.clamp(0, originalImage.height - 1);
      final actualCropWidth = (cropWidth).clamp(1, originalImage.width - actualCropX);
      final actualCropHeight = (cropHeight).clamp(1, originalImage.height - actualCropY);

      // Crop the image to center area only
      final croppedImage = img.copyCrop(
        originalImage,
        x: actualCropX,
        y: actualCropY,
        width: actualCropWidth,
        height: actualCropHeight,
      );

      // Save the cropped image
      final croppedImagePath = imagePath.replaceAll('.jpg', '_center_cropped.jpg');
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

  // Modified take picture method with center cropping
  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final XFile image = await _controller!.takePicture();

      final croppedFile = await _cropImage(image.path);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Vehicle image captured from center area for ${widget.carPart ?? 'car part'}'),
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

  Widget _buildReferenceImage(double borderRadius) {
    if (widget.referenceImagePath == null || widget.referenceImagePath!.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      );
    }

    if (widget.referenceImagePath!.startsWith('assets/')) {
      return Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.0),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Image.asset(
            widget.referenceImagePath!,
            fit: BoxFit.contain,
            color: AppColor().darkCharcoalBlueColor,
            errorBuilder: (context, error, stackTrace) {
              print('Error loading asset image: $error');
              return Container(
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(borderRadius),
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
          borderRadius: BorderRadius.circular(borderRadius),
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
                  borderRadius: BorderRadius.circular(borderRadius),
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
    final screenSize = MediaQuery.of(context).size;
    final dimensions = _getResponsiveDimensions(screenSize);

    final captureWidth = dimensions['captureWidth']!;
    final captureHeight = dimensions['captureHeight']!;
    final sideWidth = dimensions['sideWidth']!;
    final buttonSize = dimensions['buttonSize']!;
    final smallButtonSize = dimensions['smallButtonSize']!;
    final fontSize = dimensions['fontSize']!;
    final smallFontSize = dimensions['smallFontSize']!;
    final padding = dimensions['padding']!;
    final borderRadius = dimensions['borderRadius']!;

    // Responsive spacing
    final verticalSpacing = screenSize.height * 0.02;
    final horizontalSpacing = sideWidth * 0.1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Full Camera Preview (background)
            if (_isCameraInitialized && _controller != null)
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: CameraPreview(_controller!),
              )
            else
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),

            // Black overlay for left and right sides
            if (_isCameraInitialized)
              Row(
                children: [
                  Expanded(
                    flex: (sideWidth / screenSize.width * 100).round(),
                    child: Container(
                      height: double.infinity,
                      color: Colors.black,
                      constraints: BoxConstraints(
                        minWidth: buttonSize + padding * 2, // Ensure minimum width for buttons
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0,right: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back button
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                width: (buttonSize * 0.8).clamp(40.0, double.infinity),
                                height: (buttonSize * 0.8).clamp(40.0, double.infinity),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular((buttonSize * 0.4).clamp(20.0, double.infinity)),
                                  border: Border.all(color: Colors.white24, width: 2),
                                ),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: (buttonSize * 0.4).clamp(16.0, 32.0),
                                ),
                              ),
                            ),
                            // Flash toggle
                            GestureDetector(
                              onTap: _toggleTorch,
                              child: Container(
                                width: smallButtonSize.clamp(30.0, double.infinity),
                                height: smallButtonSize.clamp(30.0, double.infinity),
                                decoration: BoxDecoration(
                                  color: _isTorchOn ? Colors.yellow.withOpacity(0.3) : Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular((smallButtonSize / 2).clamp(15.0, double.infinity)),
                                  border: Border.all(
                                      color: _isTorchOn ? Colors.yellow : Colors.white24,
                                      width: 2
                                  ),
                                ),
                                child: Icon(
                                  _isTorchOn ? Icons.flash_on : Icons.flash_off,
                                  color: _isTorchOn ? Colors.yellow : Colors.white70,
                                  size: (smallButtonSize * 0.5).clamp(12.0, 24.0),
                                ),
                              ),
                            ),

                            // vGap(10)
                          ],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    flex: (captureWidth / screenSize.width * 200).round(),
                    child: Container(
                      height: double.infinity,
                      // Transparent to show camera preview
                    ),
                  ),

                  Expanded(
                    flex: (sideWidth / screenSize.width * 100).round(),
                    child: Container(
                      height: double.infinity,
                      color: Colors.black,
                      constraints: BoxConstraints(
                        minWidth: buttonSize + padding * 2, // Ensure minimum width for buttons
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Camera capture button
                          GestureDetector(
                            onTap: _isCameraInitialized ? _takePicture : null,
                            child: Container(
                              width: buttonSize.clamp(50.0, double.infinity),
                              height: buttonSize.clamp(50.0, double.infinity),
                              decoration: BoxDecoration(
                                color: _isCameraInitialized ? Colors.white : Colors.grey,
                                borderRadius: BorderRadius.circular((buttonSize / 2).clamp(25.0, double.infinity)),
                                border: Border.all(
                                    color: Colors.black26,
                                    width: screenSize.width < 600 ? 3 : 4
                                ),
                                boxShadow: [
                                  if (_isCameraInitialized)
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.3),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: _isCameraInitialized
                                    ? Colors.black
                                    : Colors.grey[600],
                                size: (buttonSize * 0.45).clamp(20.0, 36.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

            // Center capture frame with reference image
            if (_isCameraInitialized)
              Center(
                child: Container(
                  key: _containerKey,
                  width: captureWidth,
                  height: captureHeight,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.greenAccent, width: 3),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius - 3),
                    child: widget.referenceImagePath != null
                        ? Stack(
                      children: [
                        _buildReferenceImage(borderRadius - 3),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.0),
                            borderRadius: BorderRadius.circular(borderRadius - 3),
                          ),
                        ),
                      ],
                    )
                        : Container(
                      decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(borderRadius - 3),
                      ),
                      child: Center(
                        child: Text(
                          'ALIGN VEHICLE\nIN CENTER FRAME\n\nONLY THIS AREA\nWILL BE CAPTURED',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
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
                bottom:0 ,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding+20,
                      vertical: padding * 0.6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                    ),
                    child: Text(
                      '${widget.carPart!.toUpperCase()}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: smallFontSize,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),

            // Camera status indicator
            Positioned(
              top: padding * 1,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding * 0.8,
                    vertical: padding * 0.5,
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
                      SizedBox(width: padding * 0.5),
                      Text(
                        _isCameraInitialized ? 'LIVE' : 'CONNECTING',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: smallFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_isTorchOn) ...[
                        SizedBox(width: padding * 0.5),
                        Icon(
                          Icons.flash_on,
                          color: Colors.yellow,
                          size: smallFontSize,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            // Center capture indicator
            // Positioned(
            //   bottom: padding,
            //   left: padding,
            //   right: padding,
            //   child: Center(
            //     child: Container(
            //       constraints: BoxConstraints(
            //         maxWidth: screenSize.width - (padding * 2),
            //       ),
            //       padding: EdgeInsets.symmetric(
            //         horizontal: padding * 1.2,
            //         vertical: padding * 0.6,
            //       ),
            //       decoration: BoxDecoration(
            //         color: Colors.green.withOpacity(0.8),
            //         borderRadius: BorderRadius.circular(25),
            //       ),
            //       child: Text(
            //         'CENTER AREA ONLY - ${(captureWidth/screenSize.width*100).toInt()}% WIDTH CAPTURED',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: smallFontSize.clamp(8.0, 12.0),
            //           fontWeight: FontWeight.bold,
            //         ),
            //         textAlign: TextAlign.center,
            //         overflow: TextOverflow.ellipsis,
            //         maxLines: 1,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}