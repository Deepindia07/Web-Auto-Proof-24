part of "car_im_inpection_screen_route_imple.dart";

class CarImInpectionScreen extends StatelessWidget {
  const CarImInpectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarImInpectionScreenBloc>(
      create: (context) => CarImInpectionScreenBloc(),
      child: const CarImageInpectionScreenView(),
    );
  }
}

class CarImageInpectionScreenView extends StatefulWidget {
  const CarImageInpectionScreenView({super.key});

  @override
  State<CarImageInpectionScreenView> createState() =>
      _CarImageInpectionScreenViewState();
}

class _CarImageInpectionScreenViewState
    extends State<CarImageInpectionScreenView> {

  // Method to open camera for specific car part
  void _openCameraForCarPart(String title, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomCameraView(
          carPart: title,
          referenceImagePath: imagePath,
        ),
      ),
    );
  }

  List<CarAddingModel> get items {
    final local = AppLocalizations.of(context)!;
    return [
      CarAddingModel(
        title: local.frontSide,
        image: frontSideView,
        onTap: () => _openCameraForCarPart(local.frontSide, front_view),
      ),
      CarAddingModel(
        title: local.frontLeftWheel,
        image: frontLeftWheelView,
        onTap: () => _openCameraForCarPart(local.frontLeftWheel, left_side_wheel),
      ),
      CarAddingModel(
        title: local.frontLeftSide,
        image: frontLeftSideView,
        onTap: () => _openCameraForCarPart(local.frontLeftSide, front_left_wheel),
      ),
      CarAddingModel(
        title: local.rearLeftSide,
        image: rearLeftSideView,
        onTap: () => _openCameraForCarPart(local.rearLeftSide, rear_left_side),
      ),
      CarAddingModel(
        title: local.rearLeftWheel,
        image: rearLeftWheelView,
        onTap: () => _openCameraForCarPart(local.rearLeftWheel, rear_left_wheel),
      ),
      CarAddingModel(
        title: local.rearSide,
        image: rearSideView,
        onTap: () => _openCameraForCarPart(local.rearSide, rear_side),
      ),
      CarAddingModel(
        title: local.backRightWheel,
        image: backRightWheelView,
        onTap: () => _openCameraForCarPart(local.backRightWheel, back_right_wheel),
      ),
      CarAddingModel(
        title: local.rearRightSide,
        image: rearRightSideView,
        onTap: () => _openCameraForCarPart(local.rearRightSide, rear_right_side),
      ),
      CarAddingModel(
        title: local.frontRightSide,
        image: frontRightSideView,
        onTap: () => _openCameraForCarPart(local.frontRightSide, front_right_side),
      ),
      CarAddingModel(
        title: local.frontRightWheel,
        image: frontRightWheelView,
        onTap: () => _openCameraForCarPart(local.frontRightWheel, front_right_wheel),
      ),
      CarAddingModel(
        title: local.frontSeats,
        image: frontSeatsView,
        onTap: () => _openCameraForCarPart(local.frontSeats, ""),
      ),
      CarAddingModel(
        title: local.rearSeats,
        image: rearSeatsView,
        onTap: () => _openCameraForCarPart(local.rearSeats, ""),
      ),
      CarAddingModel(
        title: local.odometer,
        image: oDoMeeterView,
        onTap: () => _openCameraForCarPart(local.odometer, ""),
      ),
      CarAddingModel(
        title: local.optionalImage1,
        image: addIconView,
        onTap: () => _openCameraForCarPart(local.optionalImage1, ""),
      ),
      CarAddingModel(
        title: local.optionalImage2,
        image: addIconView,
        onTap: () => _openCameraForCarPart(local.optionalImage2, ""),
      ),
      CarAddingModel(
        title: local.optionalImage3,
        image: addIconView,
        onTap: () => _openCameraForCarPart(local.optionalImage3, ""),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    local.mandatoryPicture,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    ' *',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final data = items[index];
                  return _buildContainerSideWiseView(
                    image: data.image,
                    title: data.title,
                    onTap: data.onTap,
                  );
                },
                itemCount: items.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainerSideWiseView({
    required String? image,
    required String? title,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomContainer(
            height: 75,
            width: 75,
            padding: const EdgeInsets.all(6),
            backgroundColor: AppColor().backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor().darkCharcoalBlueColor),
            child: Center(
              child: Image.asset(
                image!,
                height: 42,
                width: 42,
                color: AppColor().silverShadeGrayColor,
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    title!,
                    style: MontserratStyles.montserratMediumTextStyle(
                      size: 7,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Text(
                  "*",
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 10,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}