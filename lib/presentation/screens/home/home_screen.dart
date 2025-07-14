part of "home_screen_route_imple.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreenView();
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final List<ContainersData> _appSectionsInfo = AppSectionsData.getAppSections();
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
  Widget build(BuildContext context) {
    return BlocProvider<HomeScreenBloc>(
      create: (context) => HomeScreenBloc(),
      child: Scaffold(
        backgroundColor: AppColor().backgroundColor,
        bottomNavigationBar: _bottomView(context),
        body: _getBodyForIndex(_currentIndex),
      ),
    );
  }

  Widget _getBodyForIndex(int index) {
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
    return CollectInformationScreen();
  }

  Widget _reportsWidget(BuildContext context) {
    return ReportsScreen();
  }

  Widget _notificationWidget(BuildContext context) {
    return NotificationScreen();
  }

  Widget _contactUsWidget(BuildContext context) {
    return ContactUsScreen();
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
                          Text("My Subscription", style: MontserratStyles
                              .montserratSemiBoldTextStyle(color: Colors.white,
                              size: 20)),
                          Text("29,99€ / month", style: MontserratStyles
                              .montserratSemiBoldTextStyle(color: AppColor()
                              .darkYellowColor, size: 20)),
                        ],
                      ),
                      CustomButton(
                        onPressed: () {},
                        backgroundColor: AppColor().darkYellowColor,
                        text: "Renew Now",
                        textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                            color: AppColor().darkCharcoalBlueColor, size: 14),
                      ),
                    ],
                  ),
                  vGap(20),
                  Text(".  Free Account",
                      style: MontserratStyles.montserratNormalTextStyle(
                          color: AppColor().darkYellowColor, size: 14)),
                  vGap(5),
                  Text(".  20 Check-In/ Check-Out",
                      style: MontserratStyles.montserratNormalTextStyle(
                          color: AppColor().darkYellowColor, size: 14)),
                  vGap(5),
                  Text(".  Valable 31/12/2026 ",
                      style: MontserratStyles.montserratNormalTextStyle(
                          color: AppColor().darkYellowColor, size: 14))
                ],
              ),
            ),
            // Grid of 7 Containers
            _buildContainersGrid(context),
            _actionsButtonView(context),
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

  Widget _actionsButtonView(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.all(16),
      backgroundColor: AppColor().darkYellowColor,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Text("Action", style: MontserratStyles.montserratMediumTextStyle(size: 14, color: AppColor().darkCharcoalBlueColor)),
        ],
      ),
    );
  }

  Widget _createNewInspectionButton(BuildContext context) {
    return CustomContainer(
      onTap: () => _navigateToNewInspection(context),
      padding: EdgeInsets.all(16),
      backgroundColor: AppColor().darkCharcoalBlueColor,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Create a new Inspection", style: MontserratStyles.montserratMediumTextStyle(size: 14, color: AppColor().darkYellowColor)),
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
      padding: EdgeInsets.all(8),
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
    Navigator.pushNamed(context, '/new-inspection');
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
              color: AppColor().darkCharcoalBlueColor,
            ),
            child: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage("https://a-static.besthdwallpaper.com/beautiful-woman-smiling-wallpaper-828x1792-54438_218.jpg"),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome Back!", style: MontserratStyles.montserratMediumTextStyle(size: 16, color: AppColor().darkYellowColor)),
              Text("Jonathan Patterson", style: MontserratStyles.montserratMediumTextStyle(size: 20, color: AppColor().darkCharcoalBlueColor)),
              vGap(10),
              Row(
                spacing: 5,
                children: [
                  Image.asset(locationIcon,height: 18,width: 18,),
                  Text("123 Anywhere Street, Any City", style: MontserratStyles.montserratSemiBoldTextStyle(size: 14, color: AppColor().darkCharcoalBlueColor)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}