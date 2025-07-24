part of "home_screen_route_imple.dart";

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

  // Cache user role from SharedPrefs
  String? _cachedUserRole;

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
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
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
    final accessToken = SharedPrefsHelper.instance.getString(userId);

    if (accessToken != null && accessToken.isNotEmpty) {
      context.read<HomeScreenBloc>().add(GetProfileEvent(userId: accessToken));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appSectionsInfo = AppSectionsData.getAppSections(context);
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
          const SizedBox(height: 16),
          Text(
            'Loading...',
            style: MontserratStyles.montserratMediumTextStyle(
              size: 16,
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
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
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
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16.0 : 8.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor().darkYellowColor.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
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
                height: 28,
              ),
            ),
            // if (item.label != null && isSelected) ...[
            //   const SizedBox(height: 4),
            //   Text(
            //     item.label!,
            //     style: MontserratStyles.montserratRegularTextStyle(
            //       size: 10,
            //       color: AppColor().darkYellowColor,
            //     ),
            //   ),
            // ],
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
      appBar:widget.userRole != "instructor" ? _buildAppBar(context):null,
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColor().darkYellowColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 24.0),
          child: Column(
            children: [
              _buildIntroSection(context),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              if (widget.userRole != 'instructor') ...[
                _buildSubscriptionSection(context),
                const SizedBox(height: 16),
                _buildContainersGrid(context),
                const SizedBox(height: 16),
              ],
              _buildCreateNewInspectionButton(context),
              const SizedBox(height: 24), // Bottom spacing
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
     await Future.delayed(const Duration(milliseconds: 500));
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
          height: 40,
          width: 40,
          child: Center(
            child: Image.asset(
              menuIcon,
              height: 35,
              width: 35,
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
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(24),
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
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "29,99€ / month",
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        color: AppColor().darkYellowColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                height: AppLocalizations.of(context)!.renewNow == 'Renew Now' ? 50 : 60,
                onPressed: () => _handleRenewSubscription(context),
                backgroundColor: AppColor().darkYellowColor,
                text: AppLocalizations.of(context)!.renewNow,
                textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  size: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSubscriptionFeature(context, AppLocalizations.of(context)!.freeAccount),
          const SizedBox(height: 5),
          _buildSubscriptionFeature(context, AppLocalizations.of(context)!.checkInOutCount),
          const SizedBox(height: 5),
          _buildSubscriptionFeature(context, "${AppLocalizations.of(context)!.validUntil} 31/12/2026"),
        ],
      ),
    );
  }

  Widget _buildSubscriptionFeature(BuildContext context, String text) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: AppColor().darkYellowColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: MontserratStyles.montserratNormalTextStyle(
              color: AppColor().darkYellowColor,
              size: 14,
            ),
          ),
        ),
      ],
    );
  }

  void _handleRenewSubscription(BuildContext context) {
    // TODO: Implement subscription renewal logic
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
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
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
      padding: const EdgeInsets.all(16),
      backgroundColor: AppColor().darkCharcoalBlueColor,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.createNewInspection,
              style: MontserratStyles.montserratMediumTextStyle(
                size: 14,
                color: AppColor().darkYellowColor,
              ),
            ),
          ),
          Image.asset(
            arrowForwardRoundIcon,
            height: 22,
            width: 22,
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
      borderRadius: BorderRadius.circular(12),
      backgroundColor: AppColor().figmaColor,
      padding: const EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icons,
            height: 24,
            width: 24,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: MontserratStyles.montserratRegularTextStyle(
              size: 10,
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
        context.push(AppRoute.teamSreenView);
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
              size: 18,
            ),
          ),
          content: Text(
            'This feature is coming soon!',
            style: MontserratStyles.montserratRegularTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: MontserratStyles.montserratMediumTextStyle(
                  color: AppColor().darkYellowColor,
                  size: 14,
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
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor().darkYellowColor,
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: _buildImageProviderSafe(profileImage),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcomeBack,
                      style: MontserratStyles.montserratMediumTextStyle(
                        size: 16,
                        color: AppColor().darkYellowColor,
                      ),
                    ),
                    Text(
                      name.isNotEmpty ? name : "Guest",
                      style: MontserratStyles.montserratMediumTextStyle(
                        size: 20,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          locationIcon,
                          height: 18,
                          width: 18,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            location,
                            style: MontserratStyles.montserratSemiBoldTextStyle(
                              size: 14,
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
}
