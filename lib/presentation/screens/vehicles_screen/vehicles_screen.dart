part of "vehicles_screen_route_imple.dart";

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
    context.read<VehiclesScreenBloc>().add(LoadVehiclesEvent());
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
}