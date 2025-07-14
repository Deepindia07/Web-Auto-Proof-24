part of "vehicles_screen_route_imple.dart";

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const VehiclesScreenView();
  }
}

class VehiclesScreenView extends StatefulWidget {
  const VehiclesScreenView({super.key});

  @override
  State<VehiclesScreenView> createState() => _VehiclesScreenViewState();
}

class _VehiclesScreenViewState extends State<VehiclesScreenView> {
  // Sample data - in a real app, this would come from a service/repository
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(),
            const SizedBox(height: 16),
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Select a vehicle:",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
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
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(12),
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
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: _getVehicleColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
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
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${vehicle.model} • ${vehicle.plateNumber}',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          _getVehicleTypeText(),
          style: TextStyle(
            fontSize: 12,
            color: _getVehicleColor(),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectButton() {
    return CustomButton(
      backgroundColor: AppColor().darkYellowColor,
      onPressed: onSelect,
      text: "Select",
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