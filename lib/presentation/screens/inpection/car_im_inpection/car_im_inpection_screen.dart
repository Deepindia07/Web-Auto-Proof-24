part of "car_im_inpection_screen_route_imple.dart";

class CarImInpectionScreen extends StatelessWidget {
  const CarImInpectionScreen({super.key, required this.carDetailsModel});

  final CarDetailsModel carDetailsModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarImInpectionScreenBloc>(
      create: (context) => CarImInpectionScreenBloc(),
      child: CarImageInpectionScreenView(carDetailsModel: carDetailsModel,),
    );
  }
}

class CarImageInpectionScreenView extends StatefulWidget {
  const CarImageInpectionScreenView({super.key, required this.carDetailsModel});

  final CarDetailsModel carDetailsModel;

  @override
  State<CarImageInpectionScreenView> createState() =>
      _CarImageInpectionScreenViewState();
}

class _CarImageInpectionScreenViewState
    extends State<CarImageInpectionScreenView> {
  final Map<String, String?> beforeImages = {};
  final Map<String, String?> afterImages = {};
  bool _isLoading = false;

  @override
  void initState(){
    super.initState();
    _loadExistingImages();
  }

  Future<void> _loadExistingImages() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final existingData = await fetchCarImagesDataFromAnySource();
      print("existingData: =========>>>>>>>> $existingData");

      setState(() {
        existingData.forEach((inspectionId, images) {
          if (images is Map<String, dynamic>) {
            beforeImages[inspectionId] = images['before'];
            afterImages[inspectionId] = images['after'];
          }
        });
        print("existingData1: =========>>>>>>>> $existingData");
      });
    } catch (e) {
      print('Error loading existing images: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveCurrentImages() async {
    try {
      await fetchCarImagesDataFromAnySource(
        beforeImages: beforeImages,
        afterImages: afterImages,
      );
      print("Images saved successfully");
    } catch (e) {
      print('Error saving images: $e');
    }
  }

  void _openCameraForCarPart(
      String title, String imagePath, String inspectionId, bool isBeforeImage) {
    final bool isOptional = inspectionId.startsWith("optional");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomCameraView(
          carPart: isBeforeImage ? "$title (Before)" : "$title (After)",
          referenceImagePath: isOptional ? null : imagePath,
        ),
      ),
    ).then((capturedImagePath) {
      if (capturedImagePath != null && mounted) {
        setState(() {
          if (isBeforeImage) {
            beforeImages[inspectionId] = capturedImagePath;
          } else {
            afterImages[inspectionId] = capturedImagePath;
          }
        });
        _saveCurrentImages();
      }
    });
  }


  List<CarAddingModel> get items {
    final local = AppLocalizations.of(context)!;
    return [
      CarAddingModel(title: local.frontSide, image: front_view, inspectionId: 'front_side', onTap: () {  }),
      CarAddingModel(title: local.frontLeftWheel, image: left_front_wheel, inspectionId: 'front_left_wheel', onTap: () {  }),
      CarAddingModel(title: local.frontLeftSide, image: front_left_side, inspectionId: 'front_left_side', onTap: () {  }),
      CarAddingModel(title: local.rearLeftSide, image: half_front_left_side, inspectionId: 'rear_left_side', onTap: () {  }),
      CarAddingModel(title: local.rearLeftWheel, image: left_back_wheel, inspectionId: 'rear_left_wheel', onTap: () {  }),
      CarAddingModel(title: local.rearSide, image: back_view, inspectionId: 'rear_side', onTap: () {  }),
      CarAddingModel(title: local.backRightWheel, image: right_back_wheel, inspectionId: 'back_right_wheel', onTap: () {  }),
      CarAddingModel(title: local.rearRightSide, image: half_back_right_side, inspectionId: 'rear_right_side', onTap: () {  }),
      CarAddingModel(title: local.frontRightSide, image: half_fron_right_side, inspectionId: 'front_right_side', onTap: () {  }),
      CarAddingModel(title: local.frontRightWheel, image: right_front_wheel, inspectionId: 'front_right_wheel', onTap: () {  }),
      CarAddingModel(title: local.frontSeats, image: front_seat, inspectionId: 'front_seats', onTap: () {  }),
      CarAddingModel(title: local.rearSeats, image: back_seat, inspectionId: 'rear_seats', onTap: () {  }),
      CarAddingModel(title: local.odometer, image: odometer, inspectionId: 'odometer', onTap: () {  }),
      CarAddingModel(title: local.optionalImage1, image: addIconView, inspectionId: 'optional_1', onTap: () {  }),
      CarAddingModel(title: local.optionalImage2, image: addIconView, inspectionId: 'optional_2', onTap: () {  }),
      CarAddingModel(title: local.optionalImage3, image: addIconView, inspectionId: 'optional_3', onTap: () {  }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  local.mandatoryPicture,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Text(' *', style: TextStyle(color: Colors.red, fontSize: 16)),
              ],
            ),
            Divider(color: Colors.grey.withOpacity(0.3), thickness: 1),
            // Text(widget.carDetailsModel.carDetails == null ? "Car details not available":"${widget.carDetailsModel.carDetails?.numberPlate}"),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                childAspectRatio: 0.6,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final data = items[index];
                return _buildSingleColumnInspectionView(
                  referenceImage: data.image,
                  beforeImage: beforeImages[data.inspectionId],
                  afterImage: afterImages[data.inspectionId],
                  title: data.title,
                  inspectionId: data.inspectionId,
                );
              },
            ),
          ],
        ),
      )
    );
  }

  Widget _buildSingleColumnInspectionView({
    required String referenceImage,
    required String? beforeImage,
    required String? afterImage,
    required String title,
    required String inspectionId,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          child: Row(
            children: [
              Expanded(child: _buildImageTile('',beforeImage, referenceImage, title, inspectionId, true)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
                style: MontserratStyles.montserratMediumTextStyle(
                  size: 12,
                  color: AppColor().darkCharcoalBlueColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              "*",
              style: MontserratStyles.montserratMediumTextStyle(size: 12, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTwoColumnInspectionView({
    required String referenceImage,
    required String? beforeImage,
    required String? afterImage,
    required String title,
    required String inspectionId,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
          child: Row(
            children: [
              Expanded(child: _buildImageTile('Before', beforeImage, referenceImage, title, inspectionId, true)),
              const SizedBox(width: 6),
              Expanded(child: _buildImageTile('After', afterImage, referenceImage, title, inspectionId, false)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
                style: MontserratStyles.montserratMediumTextStyle(
                  size: 12,
                  color: AppColor().darkCharcoalBlueColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              "*",
              style: MontserratStyles.montserratMediumTextStyle(size: 12, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageTile(String label, String? imagePath, String referenceImage,
      String title, String inspectionId, bool isBefore) {
    return GestureDetector(
      onTap: () => _openCameraForCarPart(title, referenceImage, inspectionId, isBefore),
      child: Column(
        children: [
          Text(
            label,
            style: MontserratStyles.montserratMediumTextStyle(
              size: 8,
              color: AppColor().darkCharcoalBlueColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: CustomContainer(
              padding: const EdgeInsets.all(4),
              backgroundColor: AppColor().backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: imagePath != null
                    ? Colors.green.withOpacity(0.7)
                    : AppColor().darkCharcoalBlueColor.withOpacity(0.5),
              ),
              child: Center(
                child: imagePath != null
                    ? Image.file(File(imagePath), fit: BoxFit.cover)
                    : Image.asset(referenceImage, fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      ),
    );
  }
}