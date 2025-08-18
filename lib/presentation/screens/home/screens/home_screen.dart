part of "home_screen_route_imple.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScreenType currentScreen = ScreenType.dashboard;

  void updateScreen(ScreenType type) {
    setState(() {
      currentScreen = type;
      print("current-----$currentScreen-----$type");
    });
  }

  @override
  void initState() {
    super.initState();
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
                                      onScreenChange: (type) {
                                        setState(() {
                                          currentScreen =
                                              type;
                                        });
                                      },
                                    );

                                  case ScreenType.myVehicle:
                                    return VehiclesScreen();
                                  case ScreenType.paymentHistory:
                                    return PaymentHistoryScreen();
                                  case ScreenType.newInspection:
                                    return WebInspectionScreen();
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
                                    return AddInspectorScreen();
                                  case ScreenType.viewTeamProfile:
                                    return MyTeamDetailsScreen();
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

class SideMenu extends StatelessWidget {
  final ScreenType? currentScreen;
  final Function(ScreenType) onMenuSelected;

  const SideMenu({super.key, required this.onMenuSelected, this.currentScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      color: const Color(0xFF1F2D4A),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 32),
                  ProfileImageUploader(),
                  const SizedBox(height: 8),
                  const Text(
                    'Jonathan Patterson',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24), // Menu Items
                  MenuItem(
                    selected: currentScreen == ScreenType.dashboard,
                    icon: dashboardIcon,
                    title: 'Dashboard',
                    onTap: () => onMenuSelected(ScreenType.dashboard),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.subscription,
                    icon: prizeIcon,
                    title: 'My Package',
                    onTap: () => onMenuSelected(ScreenType.subscription),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.profile,
                    icon: whitePersonIcon,
                    title: 'My Profile',
                    onTap: () => onMenuSelected(ScreenType.profile),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.companyInformation,
                    icon: companyInfoIcon,
                    title: 'Company Information',
                    onTap: () => onMenuSelected(ScreenType.companyInformation),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.myTeam,
                    icon: teamIcon,
                    title: 'My Team',
                    onTap: () => onMenuSelected(ScreenType.myTeam),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.myVehicle,
                    icon: car4Icon,
                    title: 'My Vehicle',
                    onTap: () => onMenuSelected(ScreenType.myVehicle),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.paymentHistory,
                    icon: paymentIcon,
                    title: 'Payment History',
                    onTap: () => onMenuSelected(ScreenType.paymentHistory),
                  ),

                  MenuItem(
                    selected: currentScreen == ScreenType.contactUs,
                    icon: contactUsIcon,
                    title: 'Contact us',
                    onTap: () => onMenuSelected(ScreenType.contactUs),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.changePassword,
                    icon: changePasswordLockIcon,
                    title: 'Change password',
                    onTap: () => onMenuSelected(ScreenType.changePassword),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showSignOutDialog(context);
            },
            child: Container(
              alignment: Alignment.center,
              width: 180,
              margin: const EdgeInsets.only(bottom: 12.0),
              decoration: BoxDecoration(
                color: AppColor().yellowWarmColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Text(
                  'Sign Out',
                  style: MontserratStyles.montserratSemiBoldTextStyle(
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider _buildImageProviderSafe(String imagePath) {
    if (imagePath.isEmpty) {
      return AssetImage('assets/image/profile.png');
    } else if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      return NetworkImage(imagePath);
    } else {
      try {
        final file = File(imagePath);
        if (file.existsSync()) {
          return FileImage(file);
        } else {
          return AssetImage('assets/image/profile.png');
        }
      } catch (e) {
        print('Error loading image from path: $imagePath, Error: $e');
        return AssetImage('assets/image/profile.png');
      }
    }
  }

  void _showSignOutDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor().backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Reduced from 12
          ),
          title: Text(
            localizations.signOutTitle, // e.g., "Sign Out"
            style: MontserratStyles.montserratBoldTextStyle(
              size: 18,
              color: AppColor().darkCharcoalBlueColor,
            ), // Reduced from 20
          ),
          content: SizedBox(
            width: 220, // Reduced from 250
            child: Text(
              localizations.signOutConfirm,
              style: MontserratStyles.montserratMediumTextStyle(
                size: 15,
                color: AppColor().darkCharcoalBlueColor,
              ), // Reduced from 16
            ),
          ),
          actionsPadding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ), // Reduced padding
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            CustomButton(
              width: 130,
              height: 40, // Reduced from 45
              borderRadius: 10, // Reduced from 12
              padding: EdgeInsets.symmetric(horizontal: 32), // Reduced from 40
              text: localizations.cancelButton,
              textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                color: AppColor().yellowWarmColor,
                size: 14,
              ),
              backgroundColor: AppColor().darkCharcoalBlueColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CustomButton(
              width: 130,
              height: 40, // Reduced from 45
              borderRadius: 10, // Reduced from 12
              padding: EdgeInsets.symmetric(horizontal: 32), // Reduced from 40
              text: localizations.signOutButton,
              textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                color: AppColor().darkCharcoalBlueColor,
                size: 14,
              ),
              backgroundColor: AppColor().darkYellowColor,
              onPressed: () async {
                await SharedPrefsHelper.instance.remove(localToken);
                if (context.mounted) {
                  context.pushReplacement(AppRoute.loginScreen);
                }
              },
            ),
          ],
        );
      },
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
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Create a new Inspection',
                style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 20,
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

/*class ProfileResponsiveScreen extends StatelessWidget {
  const ProfileResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // full screen size
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    // simple breakpoints for desktop responsiveness (adjust as needed)
    double maxCardWidth;
    double horizontalPadding;
    double avatarSize;
    double titleSize;
    double labelSize;
    double valueSize;
    double verticalGap;

    if (screenWidth >= 1600) {
      // very large desktop
      maxCardWidth = 900;
      horizontalPadding = 180;
      avatarSize = 120;
      titleSize = 28;
      labelSize = 14;
      valueSize = 14;
      verticalGap = 28;
    } else if (screenWidth >= 1200) {
      // large desktop
      maxCardWidth = 760;
      horizontalPadding = 140;
      avatarSize = 110;
      titleSize = 26;
      labelSize = 14;
      valueSize = 14;
      verticalGap = 24;
    } else if (screenWidth >= 900) {
      // medium desktop / small laptop
      maxCardWidth = 720;
      horizontalPadding = 100;
      avatarSize = 100;
      titleSize = 24;
      labelSize = 13;
      valueSize = 13;
      verticalGap = 20;
    } else {
      // narrow / tablet
      maxCardWidth = screenWidth * 0.92;
      horizontalPadding = 16;
      avatarSize = 84;
      titleSize = 20;
      labelSize = 12;
      valueSize = 12;
      verticalGap = 16;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FB),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            // keep card centered with some left/right padding
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxCardWidth,
                // ensure it can grow vertically
                minHeight: screenHeight * 0.8,
              ),
              child: Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: max(24, maxCardWidth * 0.04),
                    vertical: verticalGap,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        'My Profile',
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF233142),
                        ),
                      ),
                      SizedBox(height: verticalGap / 2),

                      // Avatar
                      CircleAvatar(
                        radius: avatarSize / 2,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/300',
                        ), // replace with your image
                      ),
                      SizedBox(height: 12),

                      // Name
                      Text(
                        'Name: James Paul',
                        style: TextStyle(
                          fontSize: valueSize + 1,
                          color: const Color(0xFF233142),
                        ),
                      ),
                      SizedBox(height: verticalGap),

                      // Details list (label on left, value right)
                      _buildInfoRow(
                        label: 'Gmail:',
                        value: 'preet@gamil.com',
                        labelStyle: TextStyle(
                          fontSize: labelSize,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2F4658),
                        ),
                        valueStyle: TextStyle(
                          fontSize: valueSize,
                          color: const Color(0xFF2F4658),
                        ),
                      ),
                      _divider(),

                      _buildInfoRow(
                        label: 'Phone Number',
                        value: '638364839',
                        labelStyle: TextStyle(
                          fontSize: labelSize,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2F4658),
                        ),
                        valueStyle: TextStyle(
                          fontSize: valueSize,
                          color: const Color(0xFF2F4658),
                        ),
                      ),
                      _divider(),

                      _buildInfoRow(
                        label: 'Inspection',
                        value: '39',
                        labelStyle: TextStyle(
                          fontSize: labelSize,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2F4658),
                        ),
                        valueStyle: TextStyle(
                          fontSize: valueSize,
                          color: const Color(0xFF2F4658),
                        ),
                      ),
                      _divider(),

                      _buildInfoRow(
                        label: 'Upcoming',
                        value: '3',
                        labelStyle: TextStyle(
                          fontSize: labelSize,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2F4658),
                        ),
                        valueStyle: TextStyle(
                          fontSize: valueSize,
                          color: const Color(0xFF2F4658),
                        ),
                      ),
                      _divider(),

                      _buildInfoRow(
                        label: 'Completed:',
                        value: '69',
                        labelStyle: TextStyle(
                          fontSize: labelSize,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2F4658),
                        ),
                        valueStyle: TextStyle(
                          fontSize: valueSize,
                          color: const Color(0xFF2F4658),
                        ),
                      ),
                      _divider(),

                      _buildInfoRow(
                        label: 'Ongoing',
                        value: '6',
                        labelStyle: TextStyle(
                          fontSize: labelSize,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2F4658),
                        ),
                        valueStyle: TextStyle(
                          fontSize: valueSize,
                          color: const Color(0xFF2F4658),
                        ),
                      ),
                      SizedBox(height: verticalGap),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // helper builder for each row
  Widget _buildInfoRow({
    required String label,
    required String value,
    required TextStyle labelStyle,
    required TextStyle valueStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(label, style: labelStyle)),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(value, style: valueStyle),
            ),
          ),
        ],
      ),
    );
  }


  Widget _divider() {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFE0E6EB));
  }
}*/
