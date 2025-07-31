part of "vehicles_screen_route_imple.dart";

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VehiclesScreenBloc>(
      create: (_) => VehiclesScreenBloc(),
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
  static const _vehicles = [
    Vehicle(id: '1', name: 'Honda Civic', model: '2022', plateNumber: 'ABC-1234', image: carCopy),
    Vehicle(id: '2', name: 'Ford Transit', model: '2021', plateNumber: 'DEF-9012', image: carCopy),
    Vehicle(id: '3', name: 'Yamaha R15', model: '2023', plateNumber: 'MNO-3456', image: carCopy),
  ];

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
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: _vehicles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, i) => _VehicleCard(
                vehicle: _vehicles[i],
                onSelect: () => _selectVehicle(_vehicles[i]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectVehicle(Vehicle vehicle) {
    print('Selected: ${vehicle.name}');
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
                  vehicle.name,
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 16,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  vehicle.plateNumber,
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


class Vehicle {
  final String id;
  final String name;
  final String model;
  final String plateNumber;
  final String image;


  const Vehicle({
    required this.id,
    required this.name,
    required this.model,
    required this.plateNumber,
    required this.image
  });
}