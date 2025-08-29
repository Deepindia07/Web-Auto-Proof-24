part of "vehicles_screen_route_imple.dart";

class MyVehicleDetailsScreen extends StatefulWidget {
  final String vehicleId;

  final void Function(ScreenType type, {String? vehicleId}) onScreenChange;
  const MyVehicleDetailsScreen({
    super.key,
    required this.onScreenChange,
    required this.vehicleId,
  });

  @override
  State<MyVehicleDetailsScreen> createState() => _MyVehicleDetailsScreenState();
}

class _MyVehicleDetailsScreenState extends State<MyVehicleDetailsScreen> {
  GetSingleVehicleModel? getSingleVehicleModel;
  SingleVehicleModel? singleVehicleModel;

  @override
  void initState() {
    super.initState();
    debugPrint("selectedVehicleId → ${widget.vehicleId}");

    if (widget.vehicleId.isNotEmpty) {
      context.read<VehiclesScreenBloc>().add(
        SingleVehiclesEvent(vehicleId: widget.vehicleId),
      );
    } else {
      debugPrint("⚠️ No vehicleId received!");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.05;
    double labelFontSize = screenWidth * 0.014;
    double valueFontSize = screenWidth * 0.014;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Center(
        child: Container(
          width: screenWidth > 900 ? 600 : screenWidth * 0.9,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding / 2,
            vertical: 20,
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: SingleChildScrollView(
            child: BlocConsumer<VehiclesScreenBloc, VehiclesScreenState>(
              listener: (context, state) {
                if (state is SingleVehiclesScreenLoaded) {
                  getSingleVehicleModel = state.getSingleVehicleModel;
                  singleVehicleModel = getSingleVehicleModel?.vehicle;
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "My Vehicle",
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 30,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                    ),
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(carIconImage),
                    ),

                    SizedBox(height: 20),
                    buildRow(
                      "Number Plate",
                      singleVehicleModel?.numberPlate ?? "",
                      labelFontSize,
                      valueFontSize,
                    ),
                    Divider(color: AppColor().silverShadeGrayColor),
                    buildRow(
                      "Brand",
                      singleVehicleModel?.brand ?? "",
                      labelFontSize,
                      valueFontSize,
                    ),
                    Divider(color: AppColor().silverShadeGrayColor),
                    buildRow(
                      "Model",
                      singleVehicleModel?.model ?? "",
                      labelFontSize,
                      valueFontSize,
                    ),
                    Divider(color: AppColor().silverShadeGrayColor),
                    buildRow(
                      "Mileage",
                      singleVehicleModel?.mileage.toString() ?? "",
                      labelFontSize,
                      valueFontSize,
                    ),
                    Divider(color: AppColor().silverShadeGrayColor),
                    buildRow(
                      "Gas Type:",
                      singleVehicleModel?.gasType ?? "",
                      labelFontSize,
                      valueFontSize,
                    ),
                    Divider(color: AppColor().silverShadeGrayColor),
                    buildRow(
                      "Gas Level",
                      singleVehicleModel?.gasLevel ?? "",
                      labelFontSize,
                      valueFontSize,
                    ),
                    Divider(color: AppColor().silverShadeGrayColor),
                    buildRow(
                      "Tyre condition",
                      singleVehicleModel?.tyresCondition ?? "",
                      labelFontSize,
                      valueFontSize,
                    ),
                    Divider(color: AppColor().silverShadeGrayColor),
                    buildRow(
                      "Km/day Level",
                      singleVehicleModel?.kmPerDay.toString() ?? "",
                      labelFontSize,
                      valueFontSize,
                    ),
                    Divider(color: AppColor().silverShadeGrayColor),
                    buildRow(
                      "Extra Km",
                      singleVehicleModel?.extraKm.toString() ?? "",
                      labelFontSize,
                      valueFontSize,
                    ),

                    Divider(color: AppColor().silverShadeGrayColor),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButtonWeb(
                            text: "Previous",
                            onPressed: () {
                              widget.onScreenChange(ScreenType.myVehicle);
                            },
                            color: AppColor().darkCharcoalBlueColor,
                            textColor: AppColor().yellowWarmColor,
                            borderRadius: 7,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(
    String label,
    String value,
    double labelSize,
    double valueSize,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 16,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: MontserratStyles.montserratRegularTextStyle(
                size: 16,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
