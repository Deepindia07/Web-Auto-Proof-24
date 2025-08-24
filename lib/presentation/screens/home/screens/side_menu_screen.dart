part of "home_screen_route_imple.dart";

class SideMenu extends StatelessWidget {
  final ScreenType? currentScreen;
  final String userName;
  final String? companyId;
  final Function(ScreenType) onMenuSelected;

  const SideMenu({super.key, required this.onMenuSelected, this.currentScreen, required this.userName, required this.companyId});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
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
                   Text(
                    userName ?? "",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24), // Menu Items
                  MenuItem(
                    selected: currentScreen == ScreenType.dashboard,
                    icon: dashboardIcon,
                    title: AppLocalizations.of(context)!.dashboardText,
                    onTap: () => onMenuSelected(ScreenType.dashboard),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.subscription,
                    icon: prizeIcon,
                    title: /*AppLocalizations.of(context)!.myProfile*/
                        "My Package",
                    onTap: () => onMenuSelected(ScreenType.subscription),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.profile,
                    icon: whitePersonIcon,
                    title: AppLocalizations.of(context)!.myProfileText,
                    onTap: () => onMenuSelected(ScreenType.profile),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.companyInformation,
                    icon: companyInfoIcon,
                    title: AppLocalizations.of(context)!.companyInformation,
                    onTap: () => onMenuSelected(ScreenType.companyInformation),
                  ),
                companyId == "" ?SizedBox.shrink() :  MenuItem(
                    selected: currentScreen == ScreenType.myTeam,
                    icon: teamIcon,
                    title: AppLocalizations.of(context)!.myTeam,
                    onTap: () => onMenuSelected(ScreenType.myTeam),
                  ),
                  MenuItem(
                    selected: currentScreen == ScreenType.myVehicle,
                    icon: car4Icon,
                    title: AppLocalizations.of(context)!.myVehicles,
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

                  BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
                    listener: (context, state) async {
                      if (state is DeleteAccountSuccess) {
                        if (context.mounted) {
                          await SharedPrefsHelper.instance.remove(localToken);
                          context.pushReplacementNamed(AppRoute.loginScreen);
                        }
                      }
                    },
                    builder: (context, state) {
                      return MenuItem(
                        selected: false,
                        icon: deleteImage,
                        title: localizations.accountDelete,
                        onTap: () {
                          final token = SharedPrefsHelper.instance.getString(
                            localToken,
                          );
                          log("token----token --$token");
                          _showAccountDeleteDialog(context, () async {
                            context.read<DeleteAccountBloc>().add(
                              DeleteAccountApiEvent(),
                            );
                          });
                        },
                      );
                    },
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

  void _showAccountDeleteDialog(BuildContext context, VoidCallback onConfirm) {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor().backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            localizations.accountDelete, // e.g. "Delete Account"
            style: MontserratStyles.montserratBoldTextStyle(
              size: 18,
              color: AppColor().darkCharcoalBlueColor,
            ),
          ),
          content: Text(
            localizations.accountDeleteConfirm,
            style: MontserratStyles.montserratMediumTextStyle(
              size: 15,
              color: AppColor().darkCharcoalBlueColor,
            ),
          ),
          actions: [
            CustomButton(
              width: 120,
              height: 40,
              borderRadius: 10,
              text: localizations.cancelButton,
              textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                color: AppColor().yellowWarmColor,
                size: 14,
              ),
              backgroundColor: AppColor().darkCharcoalBlueColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
            CustomButton(
              width: 120,
              height: 40,
              borderRadius: 10,
              text: localizations.deleteButton,
              textStyle: MontserratStyles.montserratSemiBoldTextStyle(
                color: AppColor().darkCharcoalBlueColor,
                size: 14,
              ),
              backgroundColor: AppColor().darkYellowColor,
              onPressed: () {
                Navigator.of(context).pop();
                onConfirm(); // Trigger delete
              },
            ),
          ],
        );
      },
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
