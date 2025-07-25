part of "vehicles_screen_route_imple.dart";

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VehiclesScreenBloc>(create: (BuildContext context) =>VehiclesScreenBloc(),
    child: const VehiclesScreenView());
  }
}

class VehiclesScreenView extends StatefulWidget {
  const VehiclesScreenView({super.key});

  @override
  State<VehiclesScreenView> createState() => _VehiclesScreenViewState();
}

class _VehiclesScreenViewState extends State<VehiclesScreenView> {
  final List<Vehicle> _vehicles = [
    Vehicle(
      id: '1',
      name: 'Honda Civic',
      model: '2022',
      plateNumber: 'ABC-1234',
      type: VehicleType.car,
    ),
    Vehicle(
      id: '2',
      name: 'Toyota Camry',
      model: '2023',
      plateNumber: 'XYZ-5678',
      type: VehicleType.car,
    ),
    Vehicle(
      id: '3',
      name: 'Ford Transit',
      model: '2021',
      plateNumber: 'DEF-9012',
      type: VehicleType.van,
    ),
    Vehicle(
      id: '4',
      name: 'Yamaha R15',
      model: '2023',
      plateNumber: 'MNO-3456',
      type: VehicleType.motorcycle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          _buildAppBar(),
          _buildVehiclesList(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return CustomAppBar(
      backgroundColor: AppColor().backgroundColor,
      title: "My Vehicles",
    );
  }

  Widget _buildVehiclesList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: _vehicles.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _VehicleCard(
                  vehicle: _vehicles[index],
                  onSelect: () => _handleVehicleSelection(_vehicles[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleVehicleSelection(Vehicle vehicle) {
    // Handle vehicle selection logic here
    print('Selected vehicle: ${vehicle.name}');
    // You can add navigation, state updates, or other logic here
  }
}


class _VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onSelect;

  const _VehicleCard({
    required this.vehicle,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      backgroundColor: Colors.white,
      padding: const EdgeInsets.all(14),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.black),
      child: Row(
        children: [
          _buildVehicleIcon(),
          const SizedBox(width: 12),
          Expanded(child: _buildVehicleInfo()),
          _buildSelectButton(),
        ],
      ),
    );
  }

  Widget _buildVehicleIcon() {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        // color: _getVehicleColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: AppColor().darkCharcoalBlueColor.withOpacity(0.09))
      ),
      child: Icon(
        _getVehicleIcon(),
        color: _getVehicleColor(),
        size: 24,
      ),
    );
  }

  Widget _buildVehicleInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          vehicle.name,
          style: MontserratStyles.montserratMediumTextStyle(size: 18,color: AppColor().darkCharcoalBlueColor)
        ),
        const SizedBox(height: 4),
        Text(
          'Number Plate: \n${vehicle.plateNumber}',
          style: MontserratStyles.montserratSemiBoldTextStyle(size: 16,color: AppColor().darkCharcoalBlueColor.withOpacity(0.8))
        ),
      ],
    );
  }

  Widget _buildSelectButton() {
    return CustomButton(
      elevation: 0,
      side: BorderSide.none,
      borderRadius: 14,
      backgroundColor: AppColor().darkYellowColor,
      onPressed: onSelect,
      text: "Select",
      textStyle: MontserratStyles.montserratRegularTextStyle(size: 16,color: AppColor().darkCharcoalBlueColor),
    );
  }

  IconData _getVehicleIcon() {
    switch (vehicle.type) {
      case VehicleType.car:
        return Icons.directions_car;
      case VehicleType.motorcycle:
        return Icons.motorcycle;
      case VehicleType.van:
        return Icons.airport_shuttle;
      case VehicleType.truck:
        return Icons.local_shipping;
      default:
        return Icons.directions_car;
    }
  }

  Color _getVehicleColor() {
    switch (vehicle.type) {
      case VehicleType.car:
        return Colors.blue;
      case VehicleType.motorcycle:
        return Colors.orange;
      case VehicleType.van:
        return Colors.green;
      case VehicleType.truck:
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  String _getVehicleTypeText() {
    switch (vehicle.type) {
      case VehicleType.car:
        return 'Car';
      case VehicleType.motorcycle:
        return 'Motorcycle';
      case VehicleType.van:
        return 'Van';
      case VehicleType.truck:
        return 'Truck';
      default:
        return 'Vehicle';
    }
  }
}

// Data models for vehicles
enum VehicleType { car, motorcycle, van, truck }

class Vehicle {
  final String id;
  final String name;
  final String model;
  final String plateNumber;
  final VehicleType type;

  const Vehicle({
    required this.id,
    required this.name,
    required this.model,
    required this.plateNumber,
    required this.type,
  });
}