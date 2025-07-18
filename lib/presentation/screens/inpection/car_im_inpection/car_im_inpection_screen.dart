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
  List<CarAddingModel> items = [
    CarAddingModel(title: 'Front Side', image: frontSideView),
    CarAddingModel(title: 'Front Left Wheel', image: frontLeftWheelView),
    CarAddingModel(title: 'Front Left Side', image: frontLeftSideView),
    CarAddingModel(title: 'Rear Left Side', image: rearLeftSideView),
    CarAddingModel(title: 'Rear Left Wheel', image: rearLeftWheelView),
    CarAddingModel(title: 'Rear Side', image: rearSideView),
    CarAddingModel(title: 'Back Right Wheel', image: backRightWheelView),
    CarAddingModel(title: 'Rear Right Side', image: rearRightSideView),
    CarAddingModel(title: 'Front Right Side', image: frontRightSideView),
    CarAddingModel(title: 'Front Right Wheel', image: frontRightWheelView),
    CarAddingModel(title: 'Front Seats', image: frontSeatsView),
    CarAddingModel(title: 'Rear Seats', image: rearSeatsView),
    CarAddingModel(title: 'Odometer', image: oDoMeeterView),
    CarAddingModel(title: 'Optional Image 1', image: oDoMeeterView),
    CarAddingModel(title: 'Optional Image 2', image: oDoMeeterView),
    CarAddingModel(title: 'Optional Image 3', image: oDoMeeterView),
  ];

  @override
  Widget build(BuildContext context){
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
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index){
                  final data = items[index];
                  return _buildContainerSideWiseView(
                      image: data.image, title: data.title);
                },
                itemCount: 16),
          ],
        ),
      ),
    );
  }

  _buildContainerSideWiseView({
    required String? image,
    required String? title
  }){
    return Column(
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
          child: Center(child: Image.asset(image!, height: 50, width: 50, color: AppColor().silverShadeGrayColor,)),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title!,
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 12,
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
    );
  }
}

class CarAddingModel{
  final String image;
  final String title;

  const CarAddingModel({required this.title, required this.image});
}