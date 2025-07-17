import 'dart:io';
import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/constants/const_route_string.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:auto_proof/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_container.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:auto_proof/utilities/responsive_screen_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../l10n_controller/l10n_switcher_bloc.dart';
import '../../utilities/cusom_image_picker.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  String? profileImagePath;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: AppColor().backgroundColor,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
                String name = '';
                String location = '';
                String email = '';
                String phone = '';
                String profileImage = '';

                if (state is HomeScreenProfileLoaded) {
                  final profile = state.userProfile;
                  name = '${profile.user!.firstName} ${profile.user!.lastName}';
                  location = profile.user!.address ?? 'No Address';
                  email = profile.user!.email ?? "";
                  phone = profile.user!.phoneNumber ?? "";
                  profileImage = profile.user!.profileImage ?? '';
                }

                return Column(
                  children: [
                    // Profile Image with Edit Button
                    vGap(70),
                    Stack(
                      children: [
                        Container(
                          width: screenSize.width * 0.25,
                          height: screenSize.width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor().darkYellowColor,
                              width: 1,
                            ),
                          ),
                          child: ClipOval(
                            child: profileImagePath != null
                                ? Image.file(
                              File(profileImagePath!),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFE0B663),
                                  child: const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            )
                                : profileImage.isNotEmpty
                                ? Image.network(
                              profileImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFE0B663),
                                  child: const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            )
                                : Container(
                              color: const Color(0xFFE0B663),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2C3E50),
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              onTap: () async {
                                final selectedImage = await CustomImageSelector.show(
                                  context,
                                  title: 'Update Profile Picture',
                                  primaryColor: const Color(0xFF2C3E50),
                                );

                                if (selectedImage != null) {
                                  setState(() {
                                    profileImagePath = selectedImage.path;
                                  });

                                  // You can also save the image path to storage or upload to server
                                  print('Selected image: ${selectedImage.path}');
                                }
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (name.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        name,
                        style: MontserratStyles.montserratSemiBoldTextStyle(
                          color: AppColor().desaturatedBlueColor,
                          size: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (email.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          email,
                          style: MontserratStyles.montserratRegularTextStyle(
                            color: AppColor().desaturatedBlueColor,
                            size: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ],
                );
              },
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // General Settings Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  color: AppColor().darkYellowColor,
                  child: Text(
                    AppLocalizations.of(context)!.generalSettings,
                    style: MontserratStyles.montserratBoldTextStyle(
                        size: 16, color: AppColor().darkCharcoalBlueColor),
                  ),
                ),
                vGap(10),
                _buildDrawerItem(
                  icon: subscriptionIcon,
                  title: AppLocalizations.of(context)!.mySubscription,
                  onTap: () {
                    context.push(AppRoute.reportsScreen);
                    // Handle subscription tap
                  },
                ),
                _buildDrawerItem(
                  icon: userIcon,
                  title: AppLocalizations.of(context)!.myTeam,
                  onTap: () {
                    context.push(AppRoute.teamSreenView);
                  },
                ),
                _buildDrawerItem(
                  icon: changePasswordLockIcon,
                  title: AppLocalizations.of(context)!.changePassword,
                  onTap: () {
                    context.push(AppRoute.changeScreen);
                  },
                ),
                _buildDrawerItem(
                  icon: languageIcon,
                  title: AppLocalizations.of(context)!.changeLanguage,
                  onTap: () {
                    _onLanguageChangeMethodCall(context);
                  },
                ),

                vGap(10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  color: AppColor().darkYellowColor,
                  child: Text(
                    AppLocalizations.of(context)!.information,
                    style: MontserratStyles.montserratBoldTextStyle(
                        size: 16, color: AppColor().darkCharcoalBlueColor),
                  ),
                ),

                // Information Items
                vGap(10),
                _buildDrawerItem(
                  icon: activityHistoryIcon,
                  title: AppLocalizations.of(context)!.paymentHistory,
                  onTap: () {
                    context.push(AppRoute.historyScreenView);
                  },
                ),

                _buildDrawerItem(
                  icon: phoneIcon,
                  title: AppLocalizations.of(context)!.aboutApp,
                  onTap: () {
                    Navigator.pop(context);
                    // Handle about app tap
                  },
                ),
                _buildDrawerItem(
                  icon: termsIcon,
                  title: AppLocalizations.of(context)!.termsAndConditions,
                  onTap: () {
                    Navigator.pop(context);
                    // Handle terms tap
                  },
                ),
                _buildDrawerItem(
                  icon: privacyIcon,
                  title: AppLocalizations.of(context)!.privacyPolicy,
                  onTap: () {
                    Navigator.pop(context);
                    // Handle privacy policy tap
                  },
                ),
                _buildDrawerItem(
                  icon: shareIcon,
                  title: AppLocalizations.of(context)!.shareThisApp,
                  onTap: () {
                    Navigator.pop(context);
                    // Handle share app tap
                  },
                ),
              ],
            ),
          ),

          CustomButton(
            side: BorderSide.none,
            onPressed: () {
              _showSignOutDialog(context);
            },
            borderRadius: 12,
            text: AppLocalizations.of(context)!.signOut,
            textColor: AppColor().darkYellowColor,
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.20),
          ),
          vGap(30)
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String? icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.only(left: 8, right: 8),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          icon!,
          height: 24,
          width: 24,
          color: AppColor().darkCharcoalBlueColor,
        ),
      ),
      title: Text(
        title,
        style: MontserratStyles.montserratSemiBoldTextStyle(
            color: AppColor().desaturatedBlueColor, size: 14),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: AppColor().desaturatedBlueColor,
        size: 16,
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                SharedPrefsHelper.instance.remove(localToken);
                context.pushReplacement(AppRoute.loginScreen);
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}

Future _onLanguageChangeMethodCall(BuildContext context) {
  final List<Map<String, dynamic>> languages = [
    {'name': 'English', 'flag': '🇺🇸', 'locale': const Locale('en')},
    {'name': 'French', 'flag': '🇫🇷', 'locale': const Locale('fr')},
  ];

  return showCupertinoModalPopup(
    context: context,
    builder: (context) => Material(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BlocListener<LocalizationsBlocController, LocalizationsState>(
          listener: (context, state) {
            if (state is LocalizationsChanged) {
              Navigator.pop(context); // Close modal when language changes
            } else if (state is LocalizationsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.changeLanguage,
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        color: AppColor().desaturatedBlueColor,
                        size: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Divider
              Container(
                height: 1,
                color: Colors.grey.shade200,
              ),

              // Language List
              Expanded(
                child: BlocBuilder<LocalizationsBlocController, LocalizationsState>(
                  builder: (context, state) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        final lang = languages[index];
                        final isSelected = state.locale == lang['locale'];
                        final isLoading = state is LocalizationsLoading;

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? Colors.blue : Colors.grey.shade200,
                              width: isSelected ? 2 : 1,
                            ),
                            color: isSelected ? Colors.blue.shade50 : Colors.white,
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  lang['flag'],
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            title: Text(
                              lang['name'],
                              style: MontserratStyles.montserratMediumTextStyle(
                                color: isSelected ? Colors.blue : Colors.grey.shade800,
                                size: 16,
                              ),
                            ),
                            trailing: isLoading && isSelected
                                ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                                : Icon(
                              isSelected ? Icons.check_circle : Icons.arrow_forward_ios,
                              size: 16,
                              color: isSelected ? Colors.blue : Colors.grey.shade400,
                            ),
                            onTap: isLoading
                                ? null
                                : () {
                              HapticFeedback.lightImpact();
                              final selectedLocale = lang['locale'] as Locale;

                              // Trigger language change through BLoC
                              context
                                  .read<LocalizationsBlocController>()
                                  .add(ChangeLanguageEvent(selectedLocale));
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  AppLocalizations.of(context)!.selectPreferredLanguage,
                  style: MontserratStyles.montserratRegularTextStyle(
                    color: Colors.grey.shade600,
                    size: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}