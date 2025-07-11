part of "car_im_inpection_screen_route_imple.dart";

class CarImInpectionScreen extends StatelessWidget {
  const CarImInpectionScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider<CarImInpectionScreenBloc>(
        create: (context) => CarImInpectionScreenBloc(),
        child: CarImageInpectionScreenView());
  }
}

class CarImageInpectionScreenView extends StatefulWidget {
  const CarImageInpectionScreenView({super.key});

  @override
  State<CarImageInpectionScreenView> createState() => _CarImageInpectionScreenViewState();
}

class _CarImageInpectionScreenViewState extends State<CarImageInpectionScreenView>{
  Map<String, String?> capturedImages = {};
  bool agreementAccepted = false;

  final List<Map<String, dynamic>> mandatoryPictures = [
    {'key': 'front_side', 'label': 'Front Side', 'icon': Icons.directions_car, 'required': true},
    {'key': 'front_left_wheel', 'label': 'Front Left\nWheel', 'icon': Icons.camera_alt, 'required': true},
    {'key': 'front_left_side', 'label': 'Front Left\nSide', 'icon': Icons.directions_car, 'required': true},
    {'key': 'rear_left_side', 'label': 'Rear Left\nSide', 'icon': Icons.local_shipping, 'required': true},
    {'key': 'rear_left_wheel', 'label': 'Rear Left\nWheel', 'icon': Icons.tire_repair, 'required': true},
    {'key': 'rear_side', 'label': 'Rear Side', 'icon': Icons.directions_car, 'required': true},
    {'key': 'back_right_wheel', 'label': 'Back Right\nWheel', 'icon': Icons.tire_repair, 'required': true},
    {'key': 'rear_right_side', 'label': 'Rear Right\nSide', 'icon': Icons.directions_car, 'required': true},
    {'key': 'front_right_side', 'label': 'Front Right\nSide', 'icon': Icons.directions_car, 'required': true},
    {'key': 'front_right_wheel', 'label': 'Front Right\nWheel', 'icon': Icons.tire_repair, 'required': true},
    {'key': 'front_seats', 'label': 'Front Seats', 'icon': Icons.airline_seat_recline_normal, 'required': true},
    {'key': 'rear_seats', 'label': 'Rear\nSeats', 'icon': Icons.airline_seat_recline_normal, 'required': true},
    {'key': 'odometer', 'label': 'Odometer', 'icon': Icons.speed, 'required': true},
    {'key': 'option_1', 'label': 'Option\nPhotos', 'icon': Icons.add_circle_outline, 'required': false},
    {'key': 'option_2', 'label': 'Option\nPhotos', 'icon': Icons.add_circle_outline, 'required': false},
    {'key': 'option_3', 'label': 'Option\nPhotos', 'icon': Icons.add_circle_outline, 'required': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor().backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMandatoryPicturesSection(),
            const SizedBox(height: 24),
            _buildConditionsSection(),
            const SizedBox(height: 24),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMandatoryPicturesSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Mandatory Picture',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                ' *',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ],
          ),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemCount: mandatoryPictures.length,
            itemBuilder: (context, index) {
              final picture = mandatoryPictures[index];
              return _buildPictureCard(picture);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPictureCard(Map<String, dynamic> picture) {
    final bool hasImage = capturedImages.containsKey(picture['key']);

    return GestureDetector(
      onTap: () => _openCamera(picture['key'], picture['label']),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
          color: hasImage ? Colors.green[50] : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: hasImage
                    ? ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                  child: Image.file(
                    File(capturedImages[picture['key']]!),
                    fit: BoxFit.cover,
                  ),
                )
                    : Icon(
                  picture['icon'],
                  size: 30,
                  color: Colors.grey[600],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Text(
                    picture['label'],
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  if (picture['required'])
                    const Text(
                      ' *',
                      style: TextStyle(color: Colors.red, fontSize: 10),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Conditions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  ' *',
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildConditionItem('I agree to take care of the vehicle during the rental. I will return it in the same condition as I received it.'),
            _buildConditionItem('I allow the rental company to charge my credit card if any costs apply under the rental terms.'),
            _buildConditionItem('I understand that the insurance excess is between €1,000 and €4,000.'),
            _buildConditionItem('If I do not follow the insurance rules, I will pay for any damage or repairs myself.'),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('I agree to all conditions'),
              value: agreementAccepted,
              onChanged: (bool? value) {
                setState(() {
                  agreementAccepted = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConditionItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    final requiredPictures = mandatoryPictures.where((p) => p['required']).toList();
    final capturedRequiredPictures = requiredPictures.where((p) => capturedImages.containsKey(p['key'])).length;
    final allRequiredCaptured = capturedRequiredPictures == requiredPictures.length;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (allRequiredCaptured && agreementAccepted) ? _submitInspection : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Submit Inspection ($capturedRequiredPictures/${requiredPictures.length} required photos)',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Future<void> _openCamera(String key, String label) async {
    final cameras = await availableCameras();
    final permission = await Permission.camera.request();
    if (permission.isGranted)  {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraScreen(
            cameras:  cameras,
            title: label,
            onImageCaptured: (imagePath) {
              setState(() {
                capturedImages[key] = imagePath;
              });
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission is required')),
      );
    }
  }

  void _submitInspection() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Inspection Submitted'),
        content: const Text('Your vehicle inspection has been submitted successfully.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final String title;
  final Function(String) onImageCaptured;

  const CameraScreen({
    Key? key,
    required this.cameras,
    required this.title,
    required this.onImageCaptured,
  }) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    if (widget.cameras.isNotEmpty) {
      _controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.medium,
      );

      try {
        await _controller!.initialize();
        setState(() {
          _isInitialized = true;
        });
      } catch (e) {
        print('Error initializing camera: $e');
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
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: _isInitialized
          ? Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CameraPreview(_controller!),
                _buildCameraOverlay(),
              ],
            ),
          ),
          _buildCameraControls(),
        ],
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildCameraOverlay() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: CameraOverlayPainter(),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Position vehicle for ${widget.title}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.black54,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCameraControls() {
    return Container(
      height: 120,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.white, size: 30),
          ),
          GestureDetector(
            onTap: _captureImage,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 3),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
          IconButton(
            onPressed: _switchCamera,
            icon: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }

  Future<void> _captureImage() async {
    try {
      final image = await _controller!.takePicture();
      widget.onImageCaptured(image.path);
      Navigator.pop(context);
    } catch (e) {
      print('Error capturing image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to capture image')),
      );
    }
  }

  void _switchCamera() {
    if (widget.cameras.length > 1) {
      final currentIndex = widget.cameras.indexOf(_controller!.description);
      final nextIndex = (currentIndex + 1) % widget.cameras.length;

      _controller?.dispose();
      _controller = CameraController(
        widget.cameras[nextIndex],
        ResolutionPreset.medium,
      );

      _controller!.initialize().then((_) {
        setState(() {});
      });
    }
  }
}

class CameraOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.fill;

    final holePaint = Paint()
      ..color = Colors.transparent
      ..blendMode = BlendMode.clear;

    // Draw dark overlay
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Create a transparent rectangle in the center
    final centerRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.8,
      height: size.height * 0.6,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(centerRect, const Radius.circular(12)),
      holePaint,
    );

    // Draw border around the hole
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(centerRect, const Radius.circular(12)),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}