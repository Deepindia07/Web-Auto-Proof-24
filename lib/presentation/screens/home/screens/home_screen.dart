part of "home_screen_route_imple.dart";
/*
class HomeScreen extends StatelessWidget {
  final String userRole;
  const HomeScreen({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeScreenBloc>(
      create: (context) => HomeScreenBloc(
        authenticationApiCall: AuthenticationApiCall(),
      ),
      child: HomeScreenView(userRole: userRole),
    );
  }
}

class HomeScreenView extends StatefulWidget {
  final String userRole;
  const HomeScreenView({super.key, required this.userRole});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView>
    with TickerProviderStateMixin {
  late List<ContainersData> _appSectionsInfo = [];
  int _currentIndex = 0;
  late AnimationController _bottomNavAnimationController;
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;
  String? _cachedUserRole;
  String? _cachedCompanyId; // Add this to cache companyId

  List<BottomNavItem> get _navItems {
    final baseItems = [
      const BottomNavItem(
        icon: homeIcon,
        activeIcon: homeIcon,
      ),
      const BottomNavItem(
        icon: personIcon,
        activeIcon: personIcon,
      ),
    ];

    if (widget.userRole != 'instructor') {
      baseItems.add(const BottomNavItem(
        icon: listIcon,
        activeIcon: listIcon,
      ));
    }

    baseItems.add(const BottomNavItem(
      icon: notificationsIcon,
      activeIcon: notificationsIcon,
    ));

    if (widget.userRole != 'instructor') {
      baseItems.add(const BottomNavItem(
        icon: headPhoneIcon,
        activeIcon: headPhoneIcon,
      ));
    }

    return baseItems;
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadUserData();
  }

  void _initializeAnimations() {
    _bottomNavAnimationController = AnimationController(
      duration: const Duration(milliseconds: 270),
      vsync: this,
    );

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeAnimationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimationController.forward();
  }

  void _loadUserData() {
    _cachedUserRole = SharedPrefsHelper.instance.getString(roleKey);
    _cachedCompanyId = SharedPrefsHelper.instance.getString(companyId);
    final accessToken = SharedPrefsHelper.instance.getString(userId);

    if (accessToken != null && accessToken.isNotEmpty) {
      context.read<HomeScreenBloc>().add(GetProfileEvent(userId: accessToken));
    }
  }

  // Method to check if user has companyId
  bool _hasCompanyId() {
    return _cachedCompanyId != null && _cachedCompanyId!.isNotEmpty;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Filter app sections based on companyId
    _appSectionsInfo = _getFilteredAppSections(context);
  }

  // Method to get filtered app sections based on companyId
  List<ContainersData> _getFilteredAppSections(BuildContext context) {
    final allSections = AppSectionsData.getAppSections(context);

    if (!_hasCompanyId()) {
      // If no companyId, filter out the "My Team" section
      // Assuming "My Team" is at index 4 based on your handleContainerTap method
      return allSections.where((section) {
        final index = allSections.indexOf(section);
        return index != 4; // Remove "My Team" section
      }).toList();
    }

    return allSections; // Return all sections if companyId exists
  }

  @override
  void dispose() {
    _bottomNavAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: _handleBlocStateChanges,
      child: Scaffold(
        backgroundColor: AppColor().backgroundColor,
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: FadeTransition(
          opacity: _fadeAnimation,
          child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
              if (state is HomeScreenLoading) {
                return _buildLoadingWidget();
              }
              return _getBodyForIndex(_currentIndex, context);
            },
          ),
        ),
      ),
    );
  }

  void _handleBlocStateChanges(BuildContext context, HomeScreenState state) {
    switch (state.runtimeType) {
      case HomeScreenError:
        final errorState = state as HomeScreenError;
        _showErrorToast(context, errorState.message);
        break;
      case HomeScreenProfileLoaded:
        final profileState = state as HomeScreenProfileLoaded;
        debugPrint('Profile loaded: ${profileState.userProfile.toString()}');
        debugPrint('Profile loaded: ${profileState.userProfile.toString()}');
        // Reload companyId after profile is loaded in case it was updated
        setState(() {
          _cachedCompanyId = SharedPrefsHelper.instance.getString('companyId');
          _appSectionsInfo = _getFilteredAppSections(context);
        });
        break;
    }
  }

  void _showErrorToast(BuildContext context, String message) {
    CherryToast.error(context, message);
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColor().darkYellowColor,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Loading...',
            style: MontserratStyles.montserratMediumTextStyle(
              size: 14,
              color: AppColor().darkCharcoalBlueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBodyForIndex(int index, BuildContext context) {
    final userRole = _cachedUserRole ?? widget.userRole;

    switch (index) {
      case 0:
        return _buildMainWidget(context, userRole);
      case 1:
        return _buildInfoViewWidget(context, userRole);
      case 2:
        return widget.userRole != 'instructor'
            ? _buildReportsWidget(context, userRole)
            : _buildNotificationWidget(context, userRole);
      case 3:
        return widget.userRole != 'instructor'
            ? _buildNotificationWidget(context, userRole)
            : _buildContactUsWidget(context, userRole);
      case 4:
        return _buildContactUsWidget(context, userRole);
      default:
        return _buildMainWidget(context, userRole);
    }
  }

  Widget _buildBottomNavigationBar() {
    return CustomContainer(
      backgroundColor: AppColor().darkCharcoalBlueColor,
      padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 14.0),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _navItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = _currentIndex == index;

            return _buildBottomNavItem(item, index, isSelected);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(BottomNavItem item, int index, bool isSelected) {
    return GestureDetector(
      onTap: () => _onBottomNavTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 14.0 : 7.0,
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor().darkYellowColor.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
          border: isSelected
              ? Border.all(
            color: AppColor().darkYellowColor.withOpacity(0.3),
            width: 1.0,
          )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                isSelected
                    ? AppColor().darkYellowColor
                    : AppColor().yellowWarmColor,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                isSelected ? item.activeIcon : item.icon,
                height: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onBottomNavTap(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      _bottomNavAnimationController.forward().then((_) {
        _bottomNavAnimationController.reverse();
      });
    }
  }

  Widget _buildInfoViewWidget(BuildContext context, String userRole) {
    final id = SharedPrefsHelper.instance.getString(userId);
    return CollectInformationScreen(
      isBacked: true,
      onBack: () => _navigateToHome(),
      userId: id ?? '',
    );
  }

  Widget _buildReportsWidget(BuildContext context, String userRole) {
    return ReportsScreen(
      isBacked: true,
      onBack: () => _navigateToHome(),
    );
  }

  Widget _buildNotificationWidget(BuildContext context, String userRole) {
    return NotificationScreen(
      onBack: () => _navigateToHome(),
      isBacked: true,
    );
  }

  Widget _buildContactUsWidget(BuildContext context, String userRole) {
    return ContactUsScreen(
      onBack: () => _navigateToHome(),
      isBacked: true,
    );
  }

  void _navigateToHome() {
    setState(() {
      _currentIndex = 0;
    });
  }

  Widget _buildMainWidget(BuildContext context, String userRole) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      drawer: widget.userRole != "instructor" ? const ProfileDrawer() : null,
      appBar:_buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColor().darkYellowColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(right: 22.0, left: 22.0, top: 7),
          child: Column(
            children: [
              _buildIntroSection(context),
              const SizedBox(height: 4),
              const Divider(),
              const SizedBox(height: 4),
              if (widget.userRole != 'instructor') ...[
                _buildSubscriptionSection(context),
                const SizedBox(height: 14),
                _buildContainersGrid(context),
                const SizedBox(height: 14),
              ],
              _buildCreateNewInspectionButton(context),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    final accessToken = SharedPrefsHelper.instance.getString(userId);
    if (accessToken != null && accessToken.isNotEmpty) {
      context.read<HomeScreenBloc>().add(GetProfileEvent(userId: accessToken));
    }
    await Future.delayed(const Duration(milliseconds: 450));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor().backgroundColor,
      elevation: 0,
      leading: widget.userRole != "instructor"
          ? Builder(
        builder: (context) => CustomContainer(
          backgroundColor: AppColor().backgroundColor,
          onTap: () => Scaffold.of(context).openDrawer(),
          height: 27,
          width: 27,
          child: Center(
            child: Image.asset(
              menuIcon,
              height: 27,
              width: 27,
              color: AppColor().darkCharcoalBlueColor,
            ),
          ),
        ),
      )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildSubscriptionSection(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(14),
      borderRadius: BorderRadius.circular(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.mySubscription,
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "29,99€ / month",
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        color: AppColor().darkYellowColor,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                side: BorderSide(color: Colors.white,width: 2),
                height: AppLocalizations.of(context)!.renewNow == 'Renew Now' ? 45 : 54,
                onPressed: () => _handleRenewSubscription(context),
                backgroundColor: AppColor().darkYellowColor,
                text: AppLocalizations.of(context)!.renewNow,
                textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _buildSubscriptionFeature(context, AppLocalizations.of(context)!.freeAccount),
          const SizedBox(height: 4),
          _buildSubscriptionFeature(context, AppLocalizations.of(context)!.checkInOutCount),
          const SizedBox(height: 4),
          _buildSubscriptionFeature(context, "${AppLocalizations.of(context)!.validUntil} 31/12/2026"),
        ],
      ),
    );
  }

  Widget _buildSubscriptionFeature(BuildContext context, String text) {
    return Row(
      children: [
        Container(
          width: 3.5,
          height: 3.5,
          decoration: BoxDecoration(
            color: AppColor().darkYellowColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: MontserratStyles.montserratNormalTextStyle(
              color: AppColor().darkYellowColor,
              size: 13,
            ),
          ),
        ),
      ],
    );
  }

  void _handleRenewSubscription(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Renew subscription feature coming soon!'),
        backgroundColor: AppColor().darkYellowColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildContainersGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 11,
        mainAxisSpacing: 11,
        childAspectRatio: 1.0,
      ),
      itemCount: _appSectionsInfo.length,
      itemBuilder: (context, index) {
        return _buildMultiContainerWidget(
          context,
          _appSectionsInfo[index].icons,
          _appSectionsInfo[index].title,
          index,
        );
      },
    );
  }

  Widget _buildCreateNewInspectionButton(BuildContext context) {
    return CustomContainer(
      onTap: () => _navigateToNewInspection(context),
      padding: const EdgeInsets.all(14),
      backgroundColor: AppColor().darkCharcoalBlueColor,
      borderRadius: BorderRadius.circular(11),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.createNewInspection,
              style: MontserratStyles.montserratMediumTextStyle(
                size: 13,
                color: AppColor().darkYellowColor,
              ),
            ),
          ),
          Image.asset(
            arrowForwardRoundIcon,
            height: 20,
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildMultiContainerWidget(
      BuildContext context,
      String icons,
      String title,
      int index,
      ) {
    return CustomContainer(
      onTap: () => _handleContainerTap(context, index, title),
      borderRadius: BorderRadius.circular(11),
      backgroundColor: AppColor().figmaColor,
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icons,
            height: 22,
            width: 22,
          ),
          const SizedBox(height: 7),
          Text(
            title,
            style: MontserratStyles.montserratRegularTextStyle(
              size: 9,
              color: AppColor().darkCharcoalBlueColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _handleContainerTap(BuildContext context, int index, String title) {
    HapticFeedback.lightImpact();

    switch (index) {
      case 0:
        Scaffold.of(context).openDrawer();
        break;
      case 1:
        context.push(AppRoute.instructionScreen);
        break;
      case 2:
      case 3:
        context.push(AppRoute.inpectionScreenViewScreen);
        break;
      case 4:
      // Check if user has companyId before allowing access to My Team
        if (_hasCompanyId()) {
          context.push(AppRoute.teamSreenView);
        } else {
          _showNoCompanyAccessDialog(context);
        }
        break;
      case 5:
        context.push(AppRoute.vehiclesScreenView);
        break;
      case 6:
        context.push(AppRoute.historyScreenView);
        break;
      default:
        _showFeatureComingSoonDialog(context, title);
        break;
    }
  }

  // New method to show dialog when user doesn't have companyId
  void _showNoCompanyAccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor().backgroundColor,
          title: Text(
            'Access Restricted',
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 16,
            ),
          ),
          content: Text(
            'You need to be associated with a company to access the My Team feature.',
            style: MontserratStyles.montserratRegularTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkYellowColor,
                  size: 13,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToNewInspection(BuildContext context) {
    HapticFeedback.lightImpact();
    context.push(AppRoute.instructionScreen);
  }

  void _showFeatureComingSoonDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor().backgroundColor,
          title: Text(
            title,
            style: MontserratStyles.montserratSemiBoldTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 16,
            ),
          ),
          content: Text(
            'This feature is coming soon!',
            style: MontserratStyles.montserratRegularTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 13,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkYellowColor,
                  size: 13,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildIntroSection(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        String name = '';
        String location = '';
        String profileImage = '';

        if (state is HomeScreenProfileLoaded || state is HomeScreenProfileImageUpdated) {
          UserResponseModel profile;

          if (state is HomeScreenProfileLoaded) {
            profile = state.userProfile;
          } else {
            profile = (state as HomeScreenProfileImageUpdated).userProfile;
          }

          name = '${profile.user?.firstName ?? ''} ${profile.user?.lastName ?? ''}'.trim();
          location = profile.user?.address ?? 'No Address';
          profileImage = profile.user?.profileImage ?? '';
        }

        return CustomContainer(
          backgroundColor: AppColor().backgroundColor,
          padding: const EdgeInsets.all(7),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor().darkYellowColor,
                ),
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: _buildImageProviderSafe(profileImage),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcomeBack,
                      style: MontserratStyles.montserratMediumTextStyle(
                        size: 14,
                        color: AppColor().darkYellowColor,
                      ),
                    ),
                    if(widget.userRole =="owner")
                      Text(
                        name.isNotEmpty ? name : "Guest",
                        style: MontserratStyles.montserratMediumTextStyle(
                          size: 18,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if(widget.userRole =="instructor")
                      Text(
                        name.isNotEmpty ? name : "Guest",
                        style: MontserratStyles.montserratMediumTextStyle(
                          size: 18,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        Image.asset(
                          locationIcon,
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location,
                            style: MontserratStyles.montserratSemiBoldTextStyle(
                              size: 13,
                              color: AppColor().darkCharcoalBlueColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
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
}*/

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
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      drawer: screenWidth < 800
          ? Drawer(child: SideMenu(onMenuSelected: updateScreen,currentScreen:currentScreen))
          : null,
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
                    if (!isMobile) SideMenu(onMenuSelected: updateScreen, currentScreen: currentScreen,),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vGap(20),
                          currentScreen == ScreenType.profile
                              ? SizedBox.shrink()
                              : WelcomeCard(
                                  onTap: () {
                                    setState(() {
                                      currentScreen = ScreenType.notification;
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
                                    return MyProfileScreen();
                                  case ScreenType.subscription:
                                    return SubscriptionScreen();
                                  case ScreenType.myTeam:
                                    return MyTeamScreen();
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
  final ScreenType? currentScreen ;
  final Function(ScreenType) onMenuSelected;


  const SideMenu({super.key, required this.onMenuSelected, this.currentScreen,});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 240,
      color: const Color(0xFF1F2D4A),
      child: Column(
        children: [
          const SizedBox(height: 32),
          const CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage('assets/image/profile.png'),
          ),
          const SizedBox(height: 8),
          const Text(
            'Jonathan Patterson',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24), // Menu Items
          MenuItem(selected:  currentScreen == ScreenType.dashboard,
            icon: dashboardIcon,
            title: 'Dashboard',
            onTap: () => onMenuSelected(ScreenType.dashboard),
          ),
          MenuItem(selected:  currentScreen == ScreenType.profile,
            icon: whitePersonIcon,
            title: 'My Profile',
            onTap: () => onMenuSelected(ScreenType.profile),
          ),
          MenuItem(selected:  currentScreen == ScreenType.subscription,
            icon: prizeIcon,
            title: 'My subscription',
            onTap: () => onMenuSelected(ScreenType.subscription),
          ),
          MenuItem(selected:  currentScreen == ScreenType.myTeam,
            icon: teamIcon,
            title: 'My Team',
            onTap: () => onMenuSelected(ScreenType.myTeam),
          ),
          MenuItem(selected:  currentScreen == ScreenType.myVehicle,
            icon: car4Icon,
            title: 'My Vehicle',
            onTap: () => onMenuSelected(ScreenType.myVehicle),
          ),
          MenuItem(selected:  currentScreen == ScreenType.paymentHistory,
            icon: paymentIcon,
            title: 'Payment History',
            onTap: () => onMenuSelected(ScreenType.paymentHistory),
          ),

          const Spacer(),
          Container(
            alignment: Alignment.center,
            width: 180,
            margin: const EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Text('Sign Out', style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
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
        leading: Image.asset(icon, height: 20, width: 20,color: selected ? AppColor().darkCharcoalBlueColor: Colors.white),
        title: Text(
          title,
          style: MontserratStyles.montserratMediumTextStyle(size: 12,color: selected ?  AppColor().darkCharcoalBlueColor: Colors.white),),

        trailing: Image.asset(rightArrowIcon, height: 20, width: 20,color: selected ? AppColor().darkCharcoalBlueColor: Colors.white),
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
