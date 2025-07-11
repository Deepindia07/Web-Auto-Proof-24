part of "inpection_list_screen_route_imple.dart";

class InspectionListScreen extends StatelessWidget {
  // final bool? isCheckedOut;
  // final bool? isCheckIn;
  const InspectionListScreen({super.key, /*required this.isCheckedOut, required this.isCheckIn*/});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InpectionListScreenBloc>(
      create: (context) => InpectionListScreenBloc(),
      child: const InspectionListScreenView(),
    );
  }
}

class InspectionListScreenView extends StatefulWidget {
  const InspectionListScreenView({super.key});

  @override
  State<InspectionListScreenView> createState() => _InspectionListScreenViewState();
}

class _InspectionListScreenViewState extends State<InspectionListScreenView> {
  bool isCompleted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: "My Inspections List",
          ),
          vGap(30),
          // Toggle Header
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2C3E50),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isCompleted = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isCompleted ? const Color(0xFFF1C40F) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Completed',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isCompleted ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isCompleted = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !isCompleted ? const Color(0xFFF1C40F) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Make Comparison',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !isCompleted ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Switchable Content
          Expanded(
            child: isCompleted
                ? const CompletedInspectionsScreen()
                : const ComparisonInspectionsScreen(),
          ),
        ],
      ),
    );
  }
}

/// Completed Inspections Screen
class CompletedInspectionsScreen extends StatelessWidget {
  const CompletedInspectionsScreen({super.key});

  final List<InspectionModel> completedInspections = const [
    InspectionModel(
      id: 'AR100001',
      plate: 'WW-000-TH',
      date: '31/12/2024',
      name: 'Preet',
      status: InspectionStatus.completed,
    ),
    InspectionModel(
      id: 'AR100002',
      plate: 'AB-123-CD',
      date: '30/12/2024',
      name: 'John',
      status: InspectionStatus.completed,
    ),
    InspectionModel(
      id: 'AR100003',
      plate: 'XY-456-ZW',
      date: '29/12/2024',
      name: 'Sarah',
      status: InspectionStatus.completed,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: completedInspections.length,
      itemBuilder: (context, index) {
        return CompletedInspectionCard(
          inspection: completedInspections[index],
        );
      },
    );
  }
}

class ComparisonInspectionsScreen extends StatelessWidget {
  const ComparisonInspectionsScreen({super.key});

  final List<InspectionModel> comparisonInspections = const [
    InspectionModel(
      id: 'AR200001',
      plate: 'PQ-789-RS',
      date: '31/12/2024',
      name: 'Mike',
      status: InspectionStatus.pending,
    ),
    InspectionModel(
      id: 'AR200002',
      plate: 'LM-012-NO',
      date: '30/12/2024',
      name: 'Emma',
      status: InspectionStatus.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: comparisonInspections.length,
      itemBuilder: (context, index) {
        return ComparisonInspectionCard(
          inspection: comparisonInspections[index],
        );
      },
    );
  }
}


/// Updated Inspection Card for Completed Inspections
class CompletedInspectionCard extends StatelessWidget {
  final InspectionModel inspection;

  const CompletedInspectionCard({super.key, required this.inspection});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/yellow_car.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.directions_car,
                            size: 32,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Identification', inspection.id),
                      const SizedBox(height: 8),
                      _buildDetailRow('Number Plate', inspection.plate),
                      const SizedBox(height: 8),
                      _buildDetailRow('Date', inspection.date),
                      const SizedBox(height: 8),
                      _buildDetailRow('Name', inspection.name),
                      const SizedBox(height: 8),
                      _buildStatusRow(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Action Buttons for Completed Inspections
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle view report
                      _showInspectionReport(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF1C40F),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'View Report',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle download report
                      _downloadReport(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C3E50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Download Report',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label : ',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow() {
    return Row(
      children: [
        const Text(
          'Status : ',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'Completed',
            style: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _showInspectionReport(BuildContext context) {
    // Navigate to report screen or show dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing report for ${inspection.id}')),
    );
  }

  void _downloadReport(BuildContext context) {
    // Handle report download
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading report for ${inspection.id}')),
    );
  }
}

// Comparison Inspection Card
class ComparisonInspectionCard extends StatelessWidget {
  final InspectionModel inspection;

  const ComparisonInspectionCard({super.key, required this.inspection});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image
                Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/yellow_car.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.directions_car,
                            size: 32,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Identification', inspection.id),
                      const SizedBox(height: 8),
                      _buildDetailRow('Number Plate', inspection.plate),
                      const SizedBox(height: 8),
                      _buildDetailRow('Date', inspection.date),
                      const SizedBox(height: 8),
                      _buildDetailRow('Name', inspection.name),
                      const SizedBox(height: 8),
                      _buildStatusRow(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Action Buttons for Comparison Inspections
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle check-in detailed
                      _handleCheckIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF1C40F),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Check-in Detailed',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle check-out detailed
                      _handleCheckOut(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2C3E50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Check-out Detailed',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label : ',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow() {
    return Row(
      children: [
        const Text(
          'Status : ',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'Pending',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  void _handleCheckIn(BuildContext context) {
    // Navigate to check-in screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Check-in for ${inspection.id}')),
    );
  }

  void _handleCheckOut(BuildContext context) {
    // Navigate to check-out screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Check-out for ${inspection.id}')),
    );
  }
}

// Updated Inspection Model with Status



// Add this to your AppColor class if not already present
extension AppColorExtension on AppColor {
  Color get backgroundColor => const Color(0xFFF5F5F5);
}