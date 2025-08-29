part of "vehicles_screen_route_imple.dart";

/*
class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VehiclesScreenBloc>(
      create: (_) => VehiclesScreenBloc(vehicleRepository: AuthenticationApiCall()),
      child: const VehiclesScreenView(),
    );
  }
}

class VehiclesScreenView extends StatefulWidget {
  const VehiclesScreenView({super.key});

  @override
  State<VehiclesScreenView> createState() => _VehiclesScreenViewState();
}

class _VehiclesScreenViewState extends State<VehiclesScreenView> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: "My Vehicles",
          ),
          Expanded(
            child: BlocBuilder<VehiclesScreenBloc, VehiclesScreenState>(
              builder: (context, state) {
                if (state is VehiclesScreenLoading) {
                  return  Center(
                    child: CustomLoader(),
                  );
                } else if (state is VehiclesScreenLoaded) {
                  if (state.vehicles.isEmpty) {
                    return  Center(
                      child: universalNull(),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<VehiclesScreenBloc>().add(RefreshVehiclesEvent());
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.vehicles.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) => _VehicleCard(
                        vehicle: state.vehicles[i],
                        onSelect: () => _selectVehicle(state.vehicles[i] as Vehicle),
                      ),
                    ),
                  );
                } else if (state is VehiclesScreenError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red.shade300,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${state.errorMessage}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<VehiclesScreenBloc>().add(LoadVehiclesEvent());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox(); // Initial state
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selectVehicle(Vehicle vehicle) {
    print('Selected: ${vehicle.brand}');
    // You can navigate to another screen or perform other actions here
  }
}

class _VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onSelect;

  const _VehicleCard({required this.vehicle, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final color = AppColor().darkCharcoalBlueColor;

    return CustomContainer(
      onTap: (){
       SharedPrefsHelper.instance.setString(vehicleId, vehicle.vehicleId.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VehicleDetailsScreen(vehicleList: vehicle,vehicleId: SharedPrefsHelper.instance.getString(vehicleId)!,)),
        );
      },
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(14),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.black),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: color.withOpacity(0.1)),
            ),
            child: Image.asset(carCopy, height: 20,width: 20,),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  vehicle.brand!,
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 16,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  vehicle.numberPlate!,
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 14,
                    color: color.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          CustomButton(
            elevation: 0,
            side: BorderSide.none,
            borderRadius: 12,
            backgroundColor: AppColor().darkYellowColor,
            onPressed: onSelect,
            text: "Select",
            textStyle: MontserratStyles.montserratRegularTextStyle(
              size: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Vehicle Details
///

class VehicleDetailsScreen extends StatelessWidget {
  final Vehicle vehicleList;
  final String vehicleId;
  const VehicleDetailsScreen({
    super.key, required this.vehicleList, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
              backgroundColor: AppColor().backgroundColor,
              title: "My Vehicles"),
          Expanded(child: _vehicleView(context))
        ],
      ),
    );
  }

  _vehicleView(BuildContext context){
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Vehicle Image
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(48),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(48),
              child: Image.asset(
               carCopy,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.directions_car,
                    size: 50, // Reduced from 60 to 48
                    color: Colors.grey[600],
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 16),
          Text(
            'Dodge RAM',
            style: TextStyle(
              fontSize: 19.2, // Reduced from 24 to 19.2
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 24), // Reduced from 30 to 24

          _buildDetailRow('Number Plate', vehicleList.numberPlate.toString()),
          _buildDetailRow('Brand', vehicleList.brand.toString()),
          _buildDetailRow('Model', vehicleList.model.toString()),
          _buildDetailRow('Mileage', vehicleList.mileage.toString()),
          _buildDetailRow('Gas Type', vehicleList.gasType.toString()),
          _buildDetailRow('Gas Level', vehicleList.gasLevel.toString()),
          _buildDetailRow('Tyre condition', vehicleList.tyresCondition.toString()),
          _buildDetailRow('Km/day', vehicleList.kmPerDay.toString()),
          _buildDetailRow('Extra KM', vehicleList.extraKm.toString()),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 1),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.8, horizontal: 0), // Reduced from 16 to 12.8
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16, // Reduced from 16 to 12.8
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14, // Reduced from 16 to 12.8
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}*/

class VehiclesScreen extends StatefulWidget {
  final String screenType;
  final void Function(ScreenType type, {String? vehicleId}) onScreenChange;
  const VehiclesScreen({super.key, required this.onScreenChange, required this.screenType});

  @override
  State<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  GetVehicleModel? getVehicleModel;
  List<Vehicle>? getVehicleList;

  @override
  void initState() {
    context.read<VehiclesScreenBloc>().add(LoadVehiclesEvent());
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: widget.screenType == "AddCar"
          ? _buildSelectVehicleLayout(context)
          : LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: customBody(),
            ),
          );
        },
      ),
    );
  }
/*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {


          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: BlocConsumer<VehiclesScreenBloc, VehiclesScreenState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      vGap(5),
                      Text(
                        "My Vehicle",
                        style: MontserratStyles.montserratBoldTextStyle(
                          size: 14,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),
                      vGap(10),
                      Expanded(
                        child: Container(
                          color: AppColor().backgroundColor,
                          child: ListView.separated(padding: EdgeInsets.only(bottom: 20),
                            itemCount: getVehicleList?.length ?? 0,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 1),
                            itemBuilder: (context, index) {
                              return _vehicleItem(
                                getVehicleList ?? <Vehicle>[],
                                index,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
                listener: (BuildContext context, VehiclesScreenState state) {
                  if (state is VehiclesScreenLoading) {
                    Center(child: CustomLoader());
                  } else if (state is VehiclesScreenLoaded) {
                    getVehicleModel = state.getVehicleModel;
                    getVehicleList = getVehicleModel?.vehicles;
                    *//*  if (state.vehicles.isEmpty) {
                      Center(child: universalNull());
                    }*//*
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }*/
  /// 📌 Vehicle selection popup style
  Widget _buildSelectVehicleLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        double containerWidth;

        if (screenWidth > 1000) {
          containerWidth = 600;
        } else if (screenWidth > 600) {
          containerWidth = screenWidth * 0.8;
        } else {
          containerWidth = screenWidth * 0.95;
        }

        return Center(
          child: Container(
            width: containerWidth,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth < 600 ? 16 : 24,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(

                    backgroundColor:Colors.white,title: "Select Vehicle",onBackPressed: (){
                    Navigator.pop(context);
                  },),
                  Center(
                    child: Text(
                      "",
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 22,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(child: customBody()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget customBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.screenType == "AddCar"
            ? const SizedBox.shrink()
            : Text(
          "My Vehicle",
          style: MontserratStyles.montserratBoldTextStyle(
            size: 14,
            color: AppColor().darkCharcoalBlueColor,
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocConsumer<VehiclesScreenBloc, VehiclesScreenState>(
            listener: (context, state) {
              if (state is VehiclesScreenLoaded) {
                getVehicleModel = state.getVehicleModel;
                getVehicleList = getVehicleModel?.vehicles;
              }
            },
            builder: (context, state) {
              if (state is VehiclesScreenLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is VehiclesScreenLoaded) {
                if (getVehicleList == null || getVehicleList!.isEmpty) {
                  return Center(
                    child: Text(
                      "No vehicles found.",
                      textAlign: TextAlign.center,
                      style: MontserratStyles.montserratRegularTextStyle(
                        size: 14,
                        color: AppColor().silverShadeGrayColor,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 12),
                  itemCount: getVehicleList!.length,
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return _vehicleItem(getVehicleList ?? <Vehicle>[],index
                    );
                  },
                );
              } else if (state is VehiclesScreenError) {
                return Center(
                  child: Text(
                    "Failed to load vehicles",
                    style: MontserratStyles.montserratSemiBoldTextStyle(
                      size: 14,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
  Widget _vehicleItem(List<Vehicle> payment, int index) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor().backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: AppColor().silverShadeGrayColor),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      margin: EdgeInsets.only(top: 5, bottom: 5),

      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage(carIconImage),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  payment[index].brand?.name ?? "",
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 14,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Number Plate: ${payment[index].numberPlate ?? ""}",
                  style: MontserratStyles.montserratRegularTextStyle(
                    size: 12,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {

              if (widget.screenType == "AddCar") {

                Navigator.of(context).pop(payment[index].vehicleId);
                //widget.onScreenChange(ScreenType.ownerDetailsScreen, inspectorId: id);
              } else {
                // ✅ Normal case → open profile view
                widget.onScreenChange(
                    ScreenType.viewVehicleProfile,
                    vehicleId:payment[index].vehicleId ?? "");
              }



            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: AppColor().yellowWarmColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
             widget.screenType == "AddCar" ?"Select car" :   "view",
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 14,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}











