part of "home_screen_route_imple.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeScreenBloc>(
      create: (context) => HomeScreenBloc(authenticationApiCall: AuthenticationApiCall()),
      child: HomeScreenView(),);
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  late List<ContainersData> _appSectionsInfo = [];
  int _currentIndex = 0;

  final List<BottomNavItem> _navItems = [
    BottomNavItem(
      icon: homeIcon,
      activeIcon: homeIcon,
      // label: 'Home',
    ),
    BottomNavItem(
      icon: personIcon,
      activeIcon: personIcon,
    ),
    BottomNavItem(
      icon: listIcon,
      activeIcon: listIcon,
    ),
    BottomNavItem(
      icon: notificationsIcon,
      activeIcon: notificationsIcon,
    ),
    BottomNavItem(
      icon: headPhoneIcon,
      activeIcon: headPhoneIcon,
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appSectionsInfo = AppSectionsData.getAppSections(context);
  }

  @override
  void initState() {
    super.initState();
    final accessToken = SharedPrefsHelper.instance.getString(userId);
    print("Access Token =>>> $accessToken");
    context.read<HomeScreenBloc>().add(GetProfileEvent(userId: accessToken));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state is HomeScreenError) {
          CherryToast.error(context, state.message);
        } else if (state is HomeScreenProfileLoaded) {
          print('Profile loaded: ${state.userProfile.toString()}');
        }
      },
      child: Scaffold(
        backgroundColor: AppColor().backgroundColor,
        bottomNavigationBar: _bottomView(context),
        body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            if (state is HomeScreenLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return _getBodyForIndex(_currentIndex, context);
          },
        ),
      ),
    );
  }

  Widget _getBodyForIndex(int index, BuildContext context) {
    switch (index) {
      case 0:
        return _mainWidget(context);
      case 1:
        return _infoViewWidget(context);
      case 2:
        return _reportsWidget(context);
      case 3:
        return _notificationWidget(context);
      case 4:
        return _contactUsWidget(context);
      default:
        return _mainWidget(context);
    }
  }

  Widget _bottomView(BuildContext context) {
    return CustomContainer(
      backgroundColor: AppColor().darkCharcoalBlueColor,
      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _navItems.asMap().entries.map((entry) {
          int index = entry.key;
          BottomNavItem item = entry.value;
          bool isSelected = _currentIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
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
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _infoViewWidget(BuildContext context) {
    final id = SharedPrefsHelper.instance.getString(userId);
    return CollectInformationScreen(
        isBacked:true,
      onBack: () {
        setState(() {
          _currentIndex = 0;
        });
      }, userId: id!,
    );
  }

  Widget _reportsWidget(BuildContext context) {
    return ReportsScreen(
      isBacked:true,
      onBack: () {
        setState(() {
          _currentIndex = 0;
        });

      },
    );
  }

  Widget _notificationWidget(BuildContext context,) {
    return NotificationScreen(
      onBack: () {
        setState(() {
          _currentIndex = 0;
        });
      }, isBacked: true,
    );
  }

  Widget _contactUsWidget(BuildContext context) {
    return ContactUsScreen(
      onBack: () {
        setState(() {
          _currentIndex = 0;
        });
      }, isBacked: true,
    );
  }

  Widget _mainWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      drawer: const ProfileDrawer(),
      appBar: AppBar(
        backgroundColor: AppColor().backgroundColor,
        leading: Builder(
          builder: (context) =>
              CustomContainer(
                  backgroundColor: AppColor().backgroundColor,
                  onTap: () => Scaffold.of(context).openDrawer(),
                  height: 40,
                  width: 40,
                  child: Center(
                      child: Image.asset(menuIcon, height: 35,
                        width: 35,
                        color: AppColor().darkCharcoalBlueColor,))),

        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24.0, top: 24.0),
        child: Column(
          spacing: 16,
          children: [
            _introSection(context),
            Divider(),
            // Subscription info Container
            CustomContainer(
              padding: EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.mySubscription, style: MontserratStyles
                              .montserratSemiBoldTextStyle(color: Colors.white,
                              size: 20)),
                          Text("29,99€ / month", style: MontserratStyles
                              .montserratSemiBoldTextStyle(color: AppColor()
                              .darkYellowColor, size: 20)),
                        ],
                      ),
                      CustomButton(
                        height: AppLocalizations.of(context)!.renewNow=='Renew Now'?50:60,
                        onPressed: () {},
                        backgroundColor: AppColor().darkYellowColor,
                        text: AppLocalizations.of(context)!.renewNow,
                        textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                            color: AppColor().darkCharcoalBlueColor, size: 14),
                      ),
                    ],
                  ),
                  vGap(20),
                  Text(".  ${AppLocalizations.of(context)!.freeAccount}",
                      style: MontserratStyles.montserratNormalTextStyle(
                          color: AppColor().darkYellowColor, size: 14)),
                  vGap(5),
                  Text(".  ${AppLocalizations.of(context)!.checkInOutCount}",
                      style: MontserratStyles.montserratNormalTextStyle(
                          color: AppColor().darkYellowColor, size: 14)),
                  vGap(5),
                  Text(".  ${AppLocalizations.of(context)!.validUntil} 31/12/2026 ",
                      style: MontserratStyles.montserratNormalTextStyle(
                          color: AppColor().darkYellowColor, size: 14))
                ],
              ),
            ),
            // Grid of 7 Containers
            _buildContainersGrid(context),
            // _actionsButtonView(context),
            _createNewInspectionButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildContainersGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // 4 columns
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: _appSectionsInfo.length,
      itemBuilder: (context, index) {
        return _multiContainerWidget(
          context,
          _appSectionsInfo[index].icons,
          _appSectionsInfo[index].title,
          index,
        );
      },
    );
  }

  // Widget _actionsButtonView(BuildContext context) {
  //   return CustomContainer(
  //     padding: EdgeInsets.all(16),
  //     backgroundColor: AppColor().darkYellowColor,
  //     borderRadius: BorderRadius.circular(12),
  //     child: Row(
  //       children: [
  //         Text(AppLocalizations.of(context)!.action, style: MontserratStyles.montserratMediumTextStyle(size: 14, color: AppColor().darkCharcoalBlueColor)),
  //       ],
  //     ),
  //   );
  // }

  Widget _createNewInspectionButton(BuildContext context) {
    return CustomContainer(
      onTap: () => _navigateToNewInspection(context),
      padding: EdgeInsets.all(16),
      backgroundColor: AppColor().darkCharcoalBlueColor,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppLocalizations.of(context)!.createNewInspection, style: MontserratStyles.montserratMediumTextStyle(size: 14, color: AppColor().darkYellowColor)),
          Image.asset(arrowForwardRoundIcon, height: 22, width: 22,)
        ],
      ),
    );
  }

  Widget _multiContainerWidget(BuildContext context, String icons, String title, int index) {
    return CustomContainer(
      onTap: () => _handleContainerTap(context, index, title),
      borderRadius: BorderRadius.circular(12),
      backgroundColor: AppColor().silverShadeGrayColor,
      padding: EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icons,
            height: 24,
            width: 24,
          ),
          vGap(8),
          Text(
            title,
            style: MontserratStyles.montserratRegularTextStyle(
              size: 10,
              color: AppColor().darkCharcoalBlueColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _handleContainerTap(BuildContext context, int index, String title) {
    switch (index) {
      case 0:
        Scaffold.of(context).openDrawer();
        break;
      case 1:
        context.push(AppRoute.instructionScreen);
        break;
      case 2:
        context.push(AppRoute.inpectionScreenViewScreen);
        break;
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
        _showContainerDialog(context, title);
        break;
    }
  }

  void _navigateToNewInspection(BuildContext context) {
    context.push(AppRoute.instructionScreen);
  }

  void _showContainerDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('This feature is coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _introSection(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        String name = '';
        String location = '';
        String profileImage = '';

        if (state is HomeScreenProfileLoaded) {
          final profile = state.userProfile;
          name = '${profile.user!.firstName} ${profile.user!.lastName}';
          location = profile.user!.address ?? 'No Address';
          profileImage = profile.user!.profileImage ?? '';
        }

        return CustomContainer(
          backgroundColor: AppColor().backgroundColor,
          padding: EdgeInsets.all(8),
          child: Row(
            spacing: 10,
            children: [
              Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor().darkYellowColor,
                ),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage:_buildImageProviderSafe(profileImage),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.welcomeBack,
                    style: MontserratStyles.montserratMediumTextStyle(
                        size: 16, color: AppColor().darkYellowColor),
                  ),
                  Text(
                    name.isNotEmpty ? name : "Guest",
                    style: MontserratStyles.montserratMediumTextStyle(
                        size: 20, color: AppColor().darkCharcoalBlueColor),
                  ),
                  vGap(10),
                  Row(
                    spacing: 5,
                    children: [
                      Image.asset(locationIcon, height: 18, width: 18),
                      Text(
                        location,
                        style: MontserratStyles.montserratSemiBoldTextStyle(
                            size: 14, color: AppColor().darkCharcoalBlueColor),
                      ),
                    ],
                  )
                ],
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
