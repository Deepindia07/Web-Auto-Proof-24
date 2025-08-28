part of "home_screen_route_imple.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScreenType currentScreen = ScreenType.dashboard;
  String companyId = "";

  String userName = "Unknown";
  late DioClient dioClient;
  String? selectedInspectorId;

  void updateScreen(ScreenType type, {String? inspectorId}) {
    setState(() {
      currentScreen = type;
      if (inspectorId != null) {
        selectedInspectorId = inspectorId;
      }
    });
  }

  @override
  void initState() {
    context.read<PersonalInformationBloc>().add(GetPersonalInfoApiEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      drawer: SideMenu(
        onMenuSelected: updateScreen,
        currentScreen: currentScreen,
        userName: userName,
        companyId: companyId,
      ),

      appBar: Responsive.isDesktop(context)
          ? null
          : AppBar(
              backgroundColor: AppColor().backgroundColor,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          final isMobile = maxWidth < 800;

          return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Sidebar for Desktop
                    BlocConsumer<
                      PersonalInformationBloc,
                      PersonalInformationState
                    >(
                      listener: (context, state) {
                        if (state is GetPersonalInfoSuccess) {
                          setState(() {
                            userName =
                                "${state.userProfile.user?.firstName ?? ""} ${state.userProfile.user?.lastName ?? ""}";
                            companyId =
                                state.userProfile.user?.company?.companyId ??
                                "";
                            debugPrint("userName--------$userName");
                            debugPrint("companyId--------$companyId");
                          });
                        }
                      },
                      builder: (context, state) {
                        return (Responsive.isDesktop(context))
                            ? SideMenu(
                                onMenuSelected: updateScreen,
                                currentScreen: currentScreen,
                                userName: userName,
                                companyId: companyId,
                              )
                            : SizedBox();
                      },
                    ),

                    const SizedBox(width: 20),

                    // ✅ Main Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vGap(20),

                          // ✅ Welcome Card (not for Change Password / Profile)
                          if (currentScreen != ScreenType.changePassword)
                            WelcomeCard(
                              onTap: () {
                                setState(() {
                                  currentScreen =
                                      currentScreen == ScreenType.notification
                                      ? ScreenType.dashboard
                                      : ScreenType.notification;
                                });
                              },
                              isVisible:
                                  currentScreen == ScreenType.newInspection ||
                                  currentScreen == ScreenType.dashboard,
                            ),

                          if (currentScreen != ScreenType.profile) vGap(10),

                          // ✅ Switch Screens
                          Expanded(child: _buildScreen(currentScreen)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScreen(ScreenType screen) {
    switch (screen) {
      case ScreenType.dashboard:
        return DashboardScreen(
          onTap: () {
            if (companyId.isEmpty) {
              // ✅ Company not selected
              debugPrint(
                "Please create a company before starting an inspection.",
              );
              return;
            }

        /*    if (selectedInspectorId == null || selectedInspectorId!.isEmpty) {
              // ✅ Inspector not selected
              debugPrint(
                "Please create/select a team before starting an inspection.",
              );
              return;
            }*/

            // ✅ Both company and inspector exist → go to new inspection screen
            setState(() {
              currentScreen = ScreenType.newInspection;
            });
          },
        );
      case ScreenType.profile:
        return PersonalInformationScreen();
      case ScreenType.subscription:
        return SubscriptionScreen();
      case ScreenType.myTeam:
        return MyTeamScreen(
          onScreenChange: (type, {inspectorId}) {
            setState(() {
              currentScreen = type;
              selectedInspectorId = inspectorId;
            });
          }, screenType: '',
        );
      case ScreenType.myVehicle:
        return VehiclesScreen(
          onScreenChange: (type) {
            setState(() => currentScreen = type);
          },
        );
      case ScreenType.paymentHistory:
        return PaymentHistoryScreen();
      case ScreenType.newInspection:
        return InstructionScreen();
      case ScreenType.notification:
        return NotificationScreen(isBacked: false, onBack: () {});
      case ScreenType.contactUs:
        return ContactUsScreen();
      case ScreenType.companyInformation:
        return CompanyInfoScreen();
      case ScreenType.changePassword:
        return ChangePasswordScreen();
      case ScreenType.addInspector:
        return AddInspectorScreen(
          getCompanyId: companyId,
          onScreenChange: (type, {inspectorId}) {
            setState(() {

            });
          },
        );
      case ScreenType.viewTeamProfile:
        return MyTeamDetailsScreen(
          inspectorId: selectedInspectorId ?? '',
          onScreenChange: (type, {inspectorId}) {
            setState(() {
              currentScreen = type;
              selectedInspectorId = inspectorId;
              print("selectedInspectorId----__$selectedInspectorId");
            });
          },
        );
      case ScreenType.viewVehicleProfile:
        return MyVehicleDetailsScreen(
          onScreenChange: (type) {
            setState(() => currentScreen = type);
          },
        );
      case ScreenType.deleteAccount:
        return Container();
      case ScreenType.inspectionList:
        return InspectionListScreen();
      case ScreenType.ownerDetailsScreen:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}

enum ScreenType {
  dashboard,
  profile,
  subscription,
  myTeam,
  newInspection,
  myVehicle,
  paymentHistory,
  notification,
  contactUs,
  companyInformation,
  changePassword,
  addInspector,
  viewTeamProfile,
  ownerDetailsScreen,
  viewVehicleProfile,
  deleteAccount,
  inspectionList,
}

class MenuItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool selected;

  const MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.selected = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // ✅ Hand cursor
      child: Container(
        color: selected ? AppColor().yellowWarmColor : Colors.transparent,
        child: ListTile(
          leading: Image.asset(
            icon,
            height: 20,
            width: 20,
            color: selected ? AppColor().darkCharcoalBlueColor : Colors.white,
          ),
          title: Text(
            title,
            style: MontserratStyles.montserratMediumTextStyle(
              size: 12,
              color: selected ? AppColor().darkCharcoalBlueColor : Colors.white,
            ),
          ),
          trailing: Image.asset(
            rightArrowIcon,
            height: 20,
            width: 20,
            color: selected ? AppColor().darkCharcoalBlueColor : Colors.white,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class CreateInspectionButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CreateInspectionButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFDCB3E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.createNewInspection,
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 18,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
                Image.asset(circleRightIcon, height: 20, width: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
