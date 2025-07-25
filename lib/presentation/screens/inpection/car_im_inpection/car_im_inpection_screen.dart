part of "car_im_inpection_screen_route_imple.dart";

class CarImInpectionScreen extends StatelessWidget {
  const CarImInpectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarImInpectionScreenBloc>(
      create: (context) => CarImInpectionScreenBloc(),
      child: CarImageInpectionScreenView(),
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
  void _openCameraForCarPart(String title, imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomCameraView(
          carPart: title,
          referenceImagePath:imagePath ,
        ),
      ),
    );
  }

  List<CarAddingModel> get items => [
    CarAddingModel(
        title: 'Front Side',
        image: frontSideView,
        onTap: () => _openCameraForCarPart('Front Side', front_view)
    ),
    CarAddingModel(
      title: 'Front Left Wheel',
      image: frontLeftWheelView,
      onTap: () => _openCameraForCarPart('Front Left Wheel',""),
    ),
    CarAddingModel(
      title: 'Front Left Side',
      image: frontLeftSideView,
      onTap: () => _openCameraForCarPart('Front Left Side',""),
    ),
    CarAddingModel(
      title: 'Rear Left Side',
      image: rearLeftSideView,
      onTap: () => _openCameraForCarPart('Rear Left Side',""),
    ),
    CarAddingModel(
      title: 'Rear Left Wheel',
      image: rearLeftWheelView,
      onTap: () => _openCameraForCarPart('Rear Left Wheel',""),
    ),
    CarAddingModel(
        title: 'Rear Side',
        image: rearSideView,
        onTap: () => _openCameraForCarPart('Rear Side',"")
    ),
    CarAddingModel(
      title: 'Back Right Wheel',
      image: backRightWheelView,
      onTap: () => _openCameraForCarPart('Back Right Wheel',""),
    ),
    CarAddingModel(
      title: 'Rear Right Side',
      image: rearRightSideView,
      onTap: () => _openCameraForCarPart('Rear Right Side',""),
    ),
    CarAddingModel(
      title: 'Front Right Side',
      image: frontRightSideView,
      onTap: () => _openCameraForCarPart('Front Right Side',""),
    ),
    CarAddingModel(
      title: 'Front Right Wheel',
      image: frontRightWheelView,
      onTap: () => _openCameraForCarPart('Front Right Wheel',""),
    ),
    CarAddingModel(
        title: 'Front Seats',
        image: frontSeatsView,
        onTap: () => _openCameraForCarPart('Front Seats',"")
    ),
    CarAddingModel(
        title: 'Rear Seats',
        image: rearSeatsView,
        onTap: () => _openCameraForCarPart('Rear Seats',"")
    ),
    CarAddingModel(
        title: 'Odometer',
        image: oDoMeeterView,
        onTap: () => _openCameraForCarPart('Odometer',"")
    ),
    CarAddingModel(
      title: 'Optional Image 1',
      image: oDoMeeterView,
      onTap: () => _openCameraForCarPart('Optional Image 1',""),
    ),
    CarAddingModel(
      title: 'Optional Image 2',
      image: oDoMeeterView,
      onTap: () => _openCameraForCarPart('Optional Image 2',""),
    ),
    CarAddingModel(
      title: 'Optional Image 3',
      image: oDoMeeterView,
      onTap: () => _openCameraForCarPart('Optional Image 3',""),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SingleChildScrollView(
        child: Column(
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
            Divider(),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 2,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
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
    );
  }

  _buildContainerSideWiseView({
    required String? image,
    required String? title,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomContainer(
            height: 88,
            width: 88,
            padding: EdgeInsets.all(8),
            backgroundColor: AppColor().backgroundColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColor().darkCharcoalBlueColor),
            child: Center(
              child: Image.asset(
                image!,
                height: 50,
                width: 50,
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
                      size: 8,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Flexible(
                  child: Text(
                    "*",
                    style: MontserratStyles.montserratMediumTextStyle(
                      size: 12,
                      color: Colors.red,
                    ),
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