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
        image: front_view,
        onTap: () => _openCameraForCarPart(local.frontSide, front_view),
      ),
      CarAddingModel(
        title: local.frontLeftWheel,
        image: left_front_wheel,
        onTap: () => _openCameraForCarPart(local.frontLeftWheel, left_front_wheel),
      ),
      CarAddingModel(
        title: local.frontLeftSide,
        image: front_left_side,
        onTap: () => _openCameraForCarPart(local.frontLeftSide, front_left_side),
      ),
      CarAddingModel(
        title: local.rearLeftSide,
        image: half_front_left_side,
        onTap: () => _openCameraForCarPart(local.rearLeftSide, half_front_left_side),
      ),
      CarAddingModel(
        title: local.rearLeftWheel,
        image: left_back_wheel,
        onTap: () => _openCameraForCarPart(local.rearLeftWheel, left_back_wheel),
      ),
      CarAddingModel(
        title: local.rearSide,
        image: back_view,
        onTap: () => _openCameraForCarPart(local.rearSide, back_view),
      ),
      CarAddingModel(
        title: local.backRightWheel,
        image: right_back_wheel,
        onTap: () => _openCameraForCarPart(local.backRightWheel, right_back_wheel),
      ),
      CarAddingModel(
        title: local.rearRightSide,
        image: half_back_right_side,
        onTap: () => _openCameraForCarPart(local.rearRightSide, half_back_right_side),
      ),
      CarAddingModel(
        title: local.frontRightSide,
        image: half_fron_right_side,
        onTap: () => _openCameraForCarPart(local.frontRightSide, half_fron_right_side),
      ),
      CarAddingModel(
        title: local.frontRightWheel,
        image: right_front_wheel,
        onTap: () => _openCameraForCarPart(local.frontRightWheel, right_front_wheel),
      ),
      CarAddingModel(
        title: local.frontSeats,
        image: front_seat,
        onTap: () => _openCameraForCarPart(local.frontSeats, front_seat),
      ),
      CarAddingModel(
        title: local.rearSeats,
        image: back_seat,
        onTap: () => _openCameraForCarPart(local.rearSeats, back_seat),
      ),
      CarAddingModel(
        title: local.odometer,
        image: odometer,
        onTap: () => _openCameraForCarPart(local.odometer, odometer),
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
                // color: AppColor().silverShadeGrayColor,
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