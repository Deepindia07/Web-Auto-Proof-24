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
          Container(
            margin: const EdgeInsets.all(16.83), // 19.8 * 0.85
            decoration: BoxDecoration(
              color: AppColor().darkCharcoalBlueColor,
              borderRadius: BorderRadius.circular(11.22), // 13.2 * 0.85
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isCompleted = true),
                    child: Padding(
                      padding: const EdgeInsets.all(3.74), // 4.4 * 0.85
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.83), // 19.8 * 0.85
                        decoration: BoxDecoration(
                          color: isCompleted ? AppColor().darkYellowColor : Colors.transparent,
                          borderRadius: BorderRadius.circular(11.22), // 13.2 * 0.85
                        ),
                        child: Text(
                            'Completed',
                            textAlign: TextAlign.center,
                            style: MontserratStyles.montserratLitleBoldTextStyle(
                                color: isCompleted ? AppColor().darkCharcoalBlueColor :AppColor().darkYellowColor,
                                size: 13.09 // 15.4 * 0.85
                            )
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isCompleted = false),
                    child: Padding(
                      padding: const EdgeInsets.all(3.74), // 4.4 * 0.85
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16.83), // 19.8 * 0.85
                        decoration: BoxDecoration(
                          color: !isCompleted ? const Color(0xFFF1C40F) : Colors.transparent,
                          borderRadius: BorderRadius.circular(11.22), // 13.2 * 0.85
                        ),
                        child: Text(
                            'Make Comparison',
                            textAlign: TextAlign.center,
                            style: MontserratStyles.montserratLitleBoldTextStyle(
                                color: !isCompleted ? AppColor().darkCharcoalBlueColor :AppColor().darkYellowColor,
                                size: 13.09 // 15.4 * 0.85
                            )
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
      padding: const EdgeInsets.symmetric(horizontal: 14.96), // 17.6 * 0.85
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
      padding: const EdgeInsets.symmetric(horizontal: 14.96), // 17.6 * 0.85
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
      margin: const EdgeInsets.only(bottom: 14.96), // 17.6 * 0.85
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11.22), // 13.2 * 0.85
        border: Border.all(color: AppColor().darkCharcoalBlueColor,width: 0.935), // 1.1 * 0.85
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.96), // 17.6 * 0.85
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image
                Container(
                  width: 74.8, // 88 * 0.85
                  height: 56.1, // 66 * 0.85
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.48), // 8.8 * 0.85
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.48), // 8.8 * 0.85
                    child: Image.asset(carCopy,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.directions_car,
                            size: 29.92, // 35.2 * 0.85
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 14.96), // 17.6 * 0.85
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Identification', inspection.id),
                      const SizedBox(height: 4.675), // 5.5 * 0.85
                      _buildDetailRow('Number Plate', inspection.plate),
                      const SizedBox(height: 4.675), // 5.5 * 0.85
                      _buildDetailRow('Date', inspection.date),
                      const SizedBox(height: 4.675), // 5.5 * 0.85
                      _buildDetailRow('Name', inspection.name),
                      const SizedBox(height: 4.675), // 5.5 * 0.85
                      // _buildStatusRow(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.96), // 17.6 * 0.85
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
                      padding: const EdgeInsets.symmetric(vertical: 11.22), // 13.2 * 0.85
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.48), // 8.8 * 0.85
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Check-in Detailed',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.09, // 15.4 * 0.85
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 11.22), // 13.2 * 0.85
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle download report
                      _downloadReport(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor().darkCharcoalBlueColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 11.22), // 13.2 * 0.85
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.48), // 8.8 * 0.85
                      ),
                      elevation: 0,
                    ),
                    child:  Text(
                      'Check-out Detailed',
                      style: TextStyle(
                        color: AppColor().darkYellowColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.09, // 15.4 * 0.85
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
            style: MontserratStyles.montserratLitleBoldTextStyle(
                size: 14.96, // 17.6 * 0.85
                color: AppColor().darkCharcoalBlueColor
            )
        ),
        Expanded(
          child: Text(
              value,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 13.09, // 15.4 * 0.85
                  color: AppColor().darkCharcoalBlueColor
              )
          ),
        ),
      ],
    );
  }

  void _showInspectionReport(BuildContext context) {
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
      margin: const EdgeInsets.only(bottom: 14.96), // 17.6 * 0.85
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11.22), // 13.2 * 0.85
        border: Border.all(color: AppColor().darkCharcoalBlueColor,width: 0.935), // 1.1 * 0.85
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.96), // 17.6 * 0.85
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image
                Container(
                  width: 74.8, // 88 * 0.85
                  height: 93.5, // 110 * 0.85
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.48), // 8.8 * 0.85
                    color: Colors.grey[100],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.48), // 8.8 * 0.85
                    child: Image.asset(
                      carCopy,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.directions_car,
                            size: 29.92, // 35.2 * 0.85
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 14.96), // 17.6 * 0.85
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Identification', inspection.id),
                      const SizedBox(height: 4.675), // 5.5 * 0.85
                      _buildDetailRow('Number Plate', inspection.plate),
                      const SizedBox(height: 4.675), // 5.5 * 0.85
                      _buildDetailRow('Date', inspection.date),
                      const SizedBox(height: 4.675), // 5.5 * 0.85
                      _buildDetailRow('Name', inspection.name),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7.48), // 8.8 * 0.85
            ElevatedButton(
              onPressed: () {
                _handleCheckIn(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor().darkYellowColor,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 11.22, horizontal: 18.7), // 13.2 * 0.85, 22 * 0.85
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.48), // 8.8 * 0.85
                ),
                elevation: 0,
              ),
              child: const Text(
                'Make comparison',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.09, // 15.4 * 0.85
                ),
              ),
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
            style: MontserratStyles.montserratLitleBoldTextStyle(
                size: 14.96, // 17.6 * 0.85
                color: AppColor().darkCharcoalBlueColor
            )
        ),
        Expanded(
          child: Text(
            value,
            style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 13.09, // 15.4 * 0.85
                color: AppColor().darkCharcoalBlueColor
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
