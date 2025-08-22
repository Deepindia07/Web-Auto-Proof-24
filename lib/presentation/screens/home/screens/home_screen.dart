part of "home_screen_route_imple.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScreenType currentScreen = ScreenType.dashboard;
  String? companyId;
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
    fetchWelcome();
    super.initState();
  }
  Future<void> fetchWelcome() async {
    final url = Uri.parse('https://api.autoproof24.com/api/welcome');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("Response: ${response.body}");
      } else {
        print("Failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      drawer: SideMenu(
        onMenuSelected: updateScreen,
        currentScreen: currentScreen,
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
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;

          final isMobile = maxWidth < 800;
          final isTablet = maxWidth >= 800 && maxWidth < 1200;
          final isDesktop = maxWidth >= 1200;

          return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Responsive.isDesktop(context)
                        ? BlocConsumer<
                            PersonalInformationBloc,
                            PersonalInformationState
                          >(
                            listener: (context, state) {
                              if (state is GetPersonalInfoSuccess) {
                                log(
                                  state
                                          .userProfile
                                          .user
                                          ?.company
                                          ?.companyName ??
                                      "",
                                );
                              companyId = state.userProfile.user?.company?.companyId;
                              }
                            },
                            builder: (context, state) {
                              return SideMenu(
                                onMenuSelected: updateScreen,
                                currentScreen: currentScreen,
                              );
                            },
                          )
                        : SizedBox.shrink(),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vGap(20),
                          currentScreen == ScreenType.changePassword
                              ? SizedBox.shrink()
                              : WelcomeCard(
                                  onTap: () {
                                    setState(() {
                                      if (currentScreen ==
                                          ScreenType.notification) {
                                        currentScreen = ScreenType.dashboard;
                                      } else {
                                        currentScreen = ScreenType.notification;
                                      }
                                    });
                                  },
                                  isVisible:
                                      (currentScreen ==
                                              ScreenType.newInspection ||
                                          currentScreen == ScreenType.dashboard)
                                      ? true
                                      : false,
                                ),
                          currentScreen == ScreenType.profile
                              ? SizedBox.shrink()
                              : vGap(10),
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                switch (currentScreen) {
                                  case ScreenType.dashboard:
                                    return DashboardScreen(
                                      onTap: () {
                                        setState(() {
                                          currentScreen =
                                              ScreenType.newInspection;
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
                                      },
                                    );

                                  case ScreenType.myVehicle:
                                    return VehiclesScreen();
                                  case ScreenType.paymentHistory:
                                    return PaymentHistoryScreen();
                                  case ScreenType.newInspection:
                                    return InstructionScreen();
                                  case ScreenType.notification:
                                    return NotificationScreen(
                                      isBacked: false,
                                      onBack: () {},
                                    );
                                  case ScreenType.contactUs:
                                    return ContactUsScreen();
                                  case ScreenType.companyInformation:
                                    return CompanyInfoScreen();
                                  case ScreenType.changePassword:
                                    return ChangePasswordScreen();
                                  case ScreenType.addInspector:
                                    return AddInspectorScreen(
                                      companyId: companyId ?? "" ,
                                    );



                                  case ScreenType.viewTeamProfile:
                                    return MyTeamDetailsScreen(
                                      inspectorId: selectedInspectorId ?? '',
                                      onScreenChange: (type, {inspectorId}) {
                                        setState(() {
                                          currentScreen = type;
                                          selectedInspectorId = inspectorId;
                                        });
                                      },
                                    );
                                  case ScreenType.deleteAccount:
                                    return Container();
                                }
                              },
                            ),
                          ),
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
  deleteAccount,
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
    return Container(
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
    );
  }
}

class CreateInspectionButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CreateInspectionButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
