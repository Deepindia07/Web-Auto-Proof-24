import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_route_string.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_container.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:auto_proof/utilities/responsive_screen_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ProfileDrawer extends StatelessWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: AppColor().backgroundColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding:  EdgeInsets.fromLTRB(24, 60, 24, 30),
            decoration:  BoxDecoration(
              color: AppColor().backgroundColor,
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: screenSize.width*0.20,
                      height: screenSize.height*0.09,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor().darkCharcoalBlueColor,
                          width: 1,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          "https://a-static.besthdwallpaper.com/beautiful-woman-smiling-wallpaper-828x1792-54438_218.jpg",
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
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
               vGap(20),
                 Text(
                  'Jonathan Patterson',
                  style: MontserratStyles.montserratBoldTextStyle(color:AppColor().darkCharcoalBlueColor,size: 18)
                ),
                vGap(8),
                 Text(
                  'Car Rental',
                  style: MontserratStyles.montserratSemiBoldTextStyle(color:AppColor().darkCharcoalBlueColor,size: 14),
                ),
                 vGap(10),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text(
                      'hello@reallygreatsite.com',
                         style: MontserratStyles.montserratMediumTextStyle(color:AppColor().darkCharcoalBlueColor,size: 12)
                                     ),
                     Text(
                      '7568484783',
                         style: MontserratStyles.montserratMediumTextStyle(color:AppColor().darkCharcoalBlueColor,size: 12)
                                     ),
                   ],
                 ),
              ],
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
                    'General Settings',
                    style:MontserratStyles.montserratBoldTextStyle(size: 16, color: AppColor().darkCharcoalBlueColor),
                  ),
                ),
                _buildDrawerItem(
                  icon: Icons.card_membership,
                  title: 'My Subscription',
                  onTap: () {
                    context.push(AppRoute.reportsScreen);
                    // Handle subscription tap
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.group,
                  title: 'My Team',
                  onTap: () {
                    context.push(AppRoute.teamSreenView);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.lock,
                  title: AppLocalizations.of(context)!.changeLanguage,
                  onTap: () {
                    context.push(AppRoute.changeScreen);
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.language,
                  title: 'Change Language',
                  onTap: () {
                    _onLoginOutMethodCall(context);
                    },
                ),

                vGap(20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  color: AppColor().darkYellowColor,
                  child: Text(
                    'Information',
                    style:MontserratStyles.montserratBoldTextStyle(size: 16, color: AppColor().darkCharcoalBlueColor),
                  ),
                ),

                // Information Items
                _buildDrawerItem(
                  icon: Icons.history,
                  title: 'Payment History',
                  onTap: () {
                    context.push(AppRoute.historyScreenView);// Handle about app tap
                  },
                ),

                _buildDrawerItem(
                  icon: Icons.info_outline,
                  title: 'About App',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle about app tap
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.description,
                  title: 'Terms & Conditions',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle terms tap
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.security,
                  title: 'Privacy Policy',
                  onTap: () {
                    Navigator.pop(context);
                    // Handle privacy policy tap
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.share,
                  title: 'Share This App',
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
            onPressed: (){
               _showSignOutDialog(context);
            },
            borderRadius: 12,
              text: "Sign Out",
              padding: EdgeInsets.symmetric(horizontal: screenSize.width*0.24)
          ),
          vGap(30)
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.only(left: 8,right: 8),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: const Color(0xFF2C3E50),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: MontserratStyles.montserratSemiBoldTextStyle(color:AppColor().desaturatedBlueColor,size: 14),
      ),
      trailing:  Icon(
        Icons.arrow_forward_ios,
        color:AppColor().desaturatedBlueColor,
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
                // _onLoginOutMethodCall(context);
              },
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }
}


Future _onLoginOutMethodCall(BuildContext context) {
  final List<Map<String, dynamic>> languages = [
    // {'name': 'Czech', 'flag': '🇨🇿', 'locale': const Locale('cs')},
    // {'name': 'Dutch', 'flag': '🇳🇱', 'locale': const Locale('nl')},
    {'name': 'English', 'flag': '🇺🇸', 'locale': const Locale('en')},
    {'name': 'French', 'flag': '🇫🇷', 'locale': const Locale('fr')},
    // {'name': 'German', 'flag': '🇩🇪', 'locale': const Locale('de')},
    // {'name': 'Italian', 'flag': '🇮🇹', 'locale': const Locale('it')},
    // {'name': 'Polish', 'flag': '🇵🇱', 'locale': const Locale('pl')},
    // {'name': 'Portuguese', 'flag': '🇵🇹', 'locale': const Locale('pt')},
    // {'name': 'Romanian', 'flag': '🇷🇴', 'locale': const Locale('ro')},
    // {'name': 'Spanish', 'flag': '🇪🇸', 'locale': const Locale('es')},
    // {'name': 'Swedish', 'flag': '🇸🇪', 'locale': const Locale('sv')},
    // {'name': 'Turkish', 'flag': '🇹🇷', 'locale': const Locale('tr')},
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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final lang = languages[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
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
                          color: Colors.grey.shade800,
                          size: 16,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey.shade400,
                      ),
                      onTap: () {
                        // Add haptic feedback
                        HapticFeedback.lightImpact();

                        Locale selectedLocale = lang['locale'];
                        print("Selected locale: $selectedLocale");

                        // Show loading indicator briefly
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                        // Simulate language change delay
                        Future.delayed(const Duration(milliseconds: 500), () {
                          Navigator.pop(context); // Close loading
                          // MyApp.setLocale(context, selectedLocale); // <- Implement this
                          Navigator.pop(context); // Close modal
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Select your preferred language",
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
  );
}