part of "team_screen_route_imple.dart";

class MyTeamScreen extends StatefulWidget {
  final void Function(ScreenType type, {String? inspectorId}) onScreenChange;

  const MyTeamScreen({super.key, required this.onScreenChange});

  @override
  State<MyTeamScreen> createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {
  List<GetTeamUserData>? getTeamUserData;

  @override
  void initState() {
    context.read<TeamScreenBloc>().add(LoadTeamMembers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;

          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  vGap(5),
                  Row(
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
                          // Trigger screen change in parent
                          widget.onScreenChange(ScreenType.addInspector);
                        },
                        child: Row(
                          children: [
                            Text(
                              "Add Team",
                              style:
                              MontserratStyles.montserratRegularTextStyle(
                                size: 12,
                                color: AppColor().silverShadeGrayColor,
                              ),
                            ),
                            hGap(10),
                            Image.asset(addIcon, height: 20, width: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                  vGap(10),
                  Expanded(
                    child: BlocConsumer<TeamScreenBloc, TeamScreenState>(
                      listener: (context, state) {
                        if (state is TeamScreenLoaded) {
                          getTeamUserData = state.teamMembers;
                        }
if(state is TeamScreenError){}
                      },
                      builder: (context, state) {
                        if (state is TeamScreenLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is TeamScreenLoaded) {
                          if (getTeamUserData == null ||
                              getTeamUserData!.isEmpty || getTeamUserData == []) {
                            return Center(
                              child: Text(
                                "No team members yet.\nPlease add a team first.",
                                textAlign: TextAlign.center,
                                style: MontserratStyles
                                    .montserratRegularTextStyle(
                                  size: 14,
                                  color: AppColor().silverShadeGrayColor,
                                ),
                              ),
                            );
                          }
                          return ListView.separated(
                            itemCount: getTeamUserData!.length,
                            separatorBuilder: (context, index) =>
                            const SizedBox(height: 1),
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
                              style: MontserratStyles
                                  .montserratSemiBoldTextStyle(
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
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _teamItem({
    required String name,
    required String email,
    required String id,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor().backgroundColor,
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
              widget.onScreenChange(
                ScreenType.viewTeamProfile,
                inspectorId: id,
              );
            },
            child: Container(
              alignment: Alignment.center,
              width: 180,
              height: 50,
              decoration: BoxDecoration(
                color: AppColor().yellowWarmColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "View",
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
