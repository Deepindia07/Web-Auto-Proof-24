part of "team_screen_route_imple.dart";

class MyTeamScreen extends StatefulWidget {
  final String screenType;
  final void Function(ScreenType type, {String? inspectorId}) onScreenChange;

  const MyTeamScreen({
    super.key,
    required this.onScreenChange,
    required this.screenType,
  });

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {
  List<GetTeamUserData>? getTeamUserData;

  @override
  void initState() {
    print("test---------${widget.screenType}");
    context.read<TeamScreenBloc>().add(LoadTeamMembers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: widget.screenType == "AddAgent"
          ? _buildAddAgentLayout(context) // ✅ Separate method for clarity
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

  Widget _buildAddAgentLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // ✅ Adaptive width based on device
        double containerWidth;
        if (screenWidth > 1000) {
          containerWidth = 600; // Desktop
        } else if (screenWidth > 600) {
          containerWidth = screenWidth * 0.8; // Tablet
        } else {
          containerWidth = screenWidth * 0.95; // Mobile
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
              // ✅ Padding adapts to device size
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth < 600 ? 16 : 24,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      children: [
                        Text(
                          "Select Agent",
                          style: MontserratStyles.montserratBoldTextStyle(
                            size: 22,
                            color: AppColor().darkCharcoalBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // ✅ scrollable body
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
        widget.screenType == "AddAgent"
            ? SizedBox.shrink()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Team",
                    style: MontserratStyles.montserratBoldTextStyle(
                      size: 14,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.onScreenChange(ScreenType.addInspector);
                    },
                    child: Row(
                      children: [
                        Text(
                          "Add Team",
                          style: MontserratStyles.montserratRegularTextStyle(
                            size: 12,
                            color: AppColor().silverShadeGrayColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(addIcon, height: 20, width: 20),
                      ],
                    ),
                  ),
                ],
              ),
        const SizedBox(height: 10),
        Expanded(
          child: BlocConsumer<TeamScreenBloc, TeamScreenState>(
            listener: (context, state) {
              if (state is TeamScreenLoaded) {
                getTeamUserData = state.teamMembers;
              }
            },
            builder: (context, state) {
              if (state is TeamScreenLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TeamScreenLoaded) {
                if (getTeamUserData == null || getTeamUserData!.isEmpty) {
                  return Center(
                    child: Text(
                      "No team members yet.\nPlease add a team first.",
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
                  itemCount: getTeamUserData!.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return _teamItem(
                      name: getTeamUserData![index].firstName ?? "",
                      email: getTeamUserData![index].email ?? "",
                      id: getTeamUserData![index].inspectorId ?? "",
                    );
                  },
                );
              } else if (state is TeamScreenError) {
                return Center(
                  child: Text(
                    "Failed to load team members",
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


  Widget _teamItem({
    required String name,
    required String email,
    required String id,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: widget.screenType == "AddAgent"
            ? Colors.white
            : AppColor().backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: AppColor().silverShadeGrayColor),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/image/profile.png'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    size: 14,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
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

              if (widget.screenType == "AddAgent") {

                Navigator.of(context).pop(id);
                //widget.onScreenChange(ScreenType.ownerDetailsScreen, inspectorId: id);
              } else {
                // ✅ Normal case → open profile view
                widget.onScreenChange(ScreenType.viewTeamProfile, inspectorId: id);
              }


            },
            child: Container(
              alignment: Alignment.center,
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                color: AppColor().yellowWarmColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                widget.screenType == "AddAgent" ? "Select" : "View",
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
