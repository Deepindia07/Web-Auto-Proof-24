part of "inpection_list_screen_route_imple.dart";

class InspectionListScreen extends StatelessWidget {
  const InspectionListScreen({
    super.key /*required this.isCheckedOut, required this.isCheckIn*/,
  });

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
  State<InspectionListScreenView> createState() =>
      _InspectionListScreenViewState();
}

class _InspectionListScreenViewState extends State<InspectionListScreenView> {
  bool isCompleted = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          /*   CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: "My Inspections List",
          ),*/
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.22),
              color: AppColor().darkCharcoalBlueColor,
              // 13.2 * 0.85
            ),
            child: Row(
              children: [
                ToggleButton(
                  label: "Completed",
                  isSelected: isCompleted,
                  onTap: () => setState(() => isCompleted = true),
                ),
                ToggleButton(
                  label: "Make Comparison",
                  isSelected: !isCompleted,
                  onTap: () => setState(() => isCompleted = false),
                ),
                /*   Expanded(
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
                ),*/
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
      itemCount: completedInspections.length,
      itemBuilder: (context, index) {
        return CompletedInspectionCard(inspection: completedInspections[index]);
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
      margin: const EdgeInsets.only(bottom: 14.96),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11.22),
        border: Border.all(
          color: AppColor().darkCharcoalBlueColor,
          width: 0.935,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🚗 Car Icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.48),
                    color: Colors.grey[100],
                  ),
                  child: Image.asset(carIconImage, height: 30, width: 30),
                ),
                const SizedBox(width: 14.96),

                // 📑 Details (left + right)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                              'Identification',
                              inspection.id,
                              context,
                            ),
                            const SizedBox(height: 4.675),
                            _buildDetailRow(
                              'Number Plate',
                              inspection.plate,
                              context,
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Date', inspection.date, context),
                            const SizedBox(height: 4.675),
                            _buildDetailRow('Name', inspection.name, context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14.96),
            // 🎛 Action buttons (now below)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _showInspectionReport(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1C40F),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 11.22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.48),
                    ),
                    elevation: 0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: const Text(
                      'Check-in Detailed',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.09,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 11.22),
                ElevatedButton(
                  onPressed: () => _downloadReport(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor().darkCharcoalBlueColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 11.22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.48),
                    ),
                    elevation: 0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      'Check-out Detailed',
                      style: TextStyle(
                        color: AppColor().darkYellowColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.09,
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

  double getResponsiveFontSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 1200) {
      return baseSize + 4; // Desktop → bigger
    } else if (screenWidth >= 800) {
      return baseSize + 2; // Tablet → medium
    } else {
      return baseSize; // Mobile → default
    }
  }

  Widget _buildDetailRow(String label, String value, BuildContext context) {
    return Row(
      children: [
        Responsive.isDesktop(context)
            ? AutoSizeText(
                '$label : ',
                style: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                ),
                minFontSize: 10,
                maxFontSize: 16,
                overflow: TextOverflow.ellipsis,
              )
            : SizedBox.shrink(),
        AutoSizeText(
          value,
          style: MontserratStyles.montserratMediumTextStyle(
            color: AppColor().darkCharcoalBlueColor,
          ),
          minFontSize: 10,
          maxFontSize: 16,
          overflow: TextOverflow.ellipsis,
        ),

        /* Text(overflow: TextOverflow.ellipsis,
          maxLines: 1,

          '$label : ',
          style: MontserratStyles.montserratSemiBoldTextStyle(
            size: getResponsiveFontSize(context, 14),
            color: AppColor().darkCharcoalBlueColor,
          ),
        ),*/
        /* Text(overflow: TextOverflow.ellipsis,
          maxLines: 1,

          value,
          style: MontserratStyles.montserratMediumTextStyle(
            size: 13,
            color: AppColor().darkCharcoalBlueColor,
          ),
        ),*/
      ],
    );
  }

  void _showInspectionReport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Viewing report for ${inspection.id}')),
    );
  }

  void _downloadReport(BuildContext context) {
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
      margin: const EdgeInsets.only(bottom: 14.96),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11.22),
        border: Border.all(
          color: AppColor().darkCharcoalBlueColor,
          width: 0.935,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Image + Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.48),
                    color: Colors.grey[100],
                  ),
                  child: Image.asset(carIconImage, height: 30, width: 30),
                ),

                const SizedBox(width: 14.96),

                // Details Left & Right
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Left Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow(
                              'Identification',
                              inspection.id,
                              context,
                            ),
                            const SizedBox(height: 4.675),
                            _buildDetailRow(
                              'Number Plate',
                              inspection.plate,
                              context,
                            ),
                          ],
                        ),
                      ),

                      // Right Column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Date', inspection.date, context),
                            const SizedBox(height: 4.675),
                            _buildDetailRow('Name', inspection.name, context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 7.48),

            // Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 70.96),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () => _handleCheckIn(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor().darkCharcoalBlueColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 11.22,
                        horizontal: 18.7,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.48),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Make comparison',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.09,
                        color: AppColor().darkYellowColor,
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

  Widget _buildDetailRow(String label, String value, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Responsive.isDesktop(context)
            ? Text(
                '$label : ',
                style: MontserratStyles.montserratLitleBoldTextStyle(
                  size: 14.96,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              )
            : SizedBox.shrink(),
        Text(
          value,
          style: MontserratStyles.montserratSemiBoldTextStyle(
            size: 13.09,
            color: AppColor().darkCharcoalBlueColor,
          ),
        ),
      ],
    );
  }

  void _handleCheckIn(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Check-in for ${inspection.id}')));
  }
}
