import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'VEHICLE INSPECTION APPLICATION'**
  String get appTitle;

  /// No description provided for @pleaseWait.
  ///
  /// In en, this message translates to:
  /// **'Please wait...'**
  String get pleaseWait;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'WELCOME'**
  String get welcome;

  /// No description provided for @secureCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Secure Check-In.'**
  String get secureCheckIn;

  /// No description provided for @smartCheckOut.
  ///
  /// In en, this message translates to:
  /// **'Smart Check-out.'**
  String get smartCheckOut;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone'**
  String get emailOrPhone;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @loggingIn.
  ///
  /// In en, this message translates to:
  /// **'Logging in...'**
  String get loggingIn;

  /// No description provided for @validatingEmail.
  ///
  /// In en, this message translates to:
  /// **'Validating email...'**
  String get validatingEmail;

  /// No description provided for @emailValidated.
  ///
  /// In en, this message translates to:
  /// **'Email validated successfully!'**
  String get emailValidated;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccessful;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter password'**
  String get pleaseEnterPassword;

  /// No description provided for @pleaseEnterEmailOrPhoneShort.
  ///
  /// In en, this message translates to:
  /// **'Please enter email or phone'**
  String get pleaseEnterEmailOrPhoneShort;

  /// No description provided for @pleaseEnterEmailOrPhoneFirst.
  ///
  /// In en, this message translates to:
  /// **'Please enter email or phone number first'**
  String get pleaseEnterEmailOrPhoneFirst;

  /// No description provided for @pleaseEnterValidEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email or phone number'**
  String get pleaseEnterValidEmailOrPhone;

  /// No description provided for @letsCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Let’s\nCreate Your Account'**
  String get letsCreateAccount;

  /// No description provided for @lets.
  ///
  /// In en, this message translates to:
  /// **'Let\'s\n'**
  String get lets;

  /// No description provided for @createYourAccount.
  ///
  /// In en, this message translates to:
  /// **'Create\nYour\nAccount'**
  String get createYourAccount;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @retypePassword.
  ///
  /// In en, this message translates to:
  /// **'Retype Password'**
  String get retypePassword;

  /// No description provided for @agreeTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get agreeTerms;

  /// No description provided for @termsPrivacy.
  ///
  /// In en, this message translates to:
  /// **' Terms & Privacy'**
  String get termsPrivacy;

  /// No description provided for @createAnAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Create an Account'**
  String get createAnAccountTitle;

  /// No description provided for @creatingAccount.
  ///
  /// In en, this message translates to:
  /// **'Creating Account...'**
  String get creatingAccount;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Have an account?'**
  String get haveAccount;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @resetInstructionsMessage.
  ///
  /// In en, this message translates to:
  /// **'No worries, we’ll send you reset instructions'**
  String get resetInstructionsMessage;

  /// No description provided for @enterEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email/Phone No.'**
  String get enterEmailOrPhone;

  /// No description provided for @pleaseEnterEmailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email or phone number'**
  String get pleaseEnterEmailOrPhone;

  /// No description provided for @sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get sending;

  /// No description provided for @emailVerification.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get emailVerification;

  /// No description provided for @emailSentMessage.
  ///
  /// In en, this message translates to:
  /// **'We have sent code to your email'**
  String get emailSentMessage;

  /// No description provided for @dontReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Don’t receive code ?'**
  String get dontReceiveCode;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @newPasswordScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get newPasswordScreenTitle;

  /// No description provided for @newPasswordScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Update your current password to keep your account secure.'**
  String get newPasswordScreenSubtitle;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @createPassword.
  ///
  /// In en, this message translates to:
  /// **'Create Password'**
  String get createPassword;

  /// No description provided for @forgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot'**
  String get forgot;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @verification.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verification;

  /// No description provided for @otpVerified.
  ///
  /// In en, this message translates to:
  /// **'OTP verified successfully'**
  String get otpVerified;

  /// No description provided for @pleaseEnterCompleteCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter the complete code'**
  String get pleaseEnterCompleteCode;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password reset successfully!'**
  String get passwordResetSuccess;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get generalSettings;

  /// No description provided for @mySubscription.
  ///
  /// In en, this message translates to:
  /// **'My Subscription'**
  String get mySubscription;

  /// No description provided for @myTeam.
  ///
  /// In en, this message translates to:
  /// **'My Team'**
  String get myTeam;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment History'**
  String get paymentHistory;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditions;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @shareThisApp.
  ///
  /// In en, this message translates to:
  /// **'Share This App'**
  String get shareThisApp;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @selectPreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get selectPreferredLanguage;

  /// No description provided for @renewNow.
  ///
  /// In en, this message translates to:
  /// **'Renew Now'**
  String get renewNow;

  /// No description provided for @freeAccount.
  ///
  /// In en, this message translates to:
  /// **'Free Account'**
  String get freeAccount;

  /// No description provided for @checkInOutCount.
  ///
  /// In en, this message translates to:
  /// **'20 Check-In/Check-Out'**
  String get checkInOutCount;

  /// No description provided for @validUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until'**
  String get validUntil;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @createNewInspection.
  ///
  /// In en, this message translates to:
  /// **'Create a new Inspection'**
  String get createNewInspection;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back!'**
  String get welcomeBack;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @newInspection.
  ///
  /// In en, this message translates to:
  /// **'New Inspection'**
  String get newInspection;

  /// No description provided for @checkOutList.
  ///
  /// In en, this message translates to:
  /// **'Check-Out List'**
  String get checkOutList;

  /// No description provided for @checkInList.
  ///
  /// In en, this message translates to:
  /// **'Check-In List'**
  String get checkInList;

  /// No description provided for @myVehicles.
  ///
  /// In en, this message translates to:
  /// **'My Vehicles'**
  String get myVehicles;

  /// No description provided for @signOutTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutTitle;

  /// No description provided for @signOutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get signOutConfirm;

  /// No description provided for @signOutButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOutButton;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @myPersonalInformation.
  ///
  /// In en, this message translates to:
  /// **'My Personal Information'**
  String get myPersonalInformation;

  /// No description provided for @myCompanyInformation.
  ///
  /// In en, this message translates to:
  /// **'My Company Information'**
  String get myCompanyInformation;

  /// No description provided for @informationType.
  ///
  /// In en, this message translates to:
  /// **'Information Type'**
  String get informationType;

  /// No description provided for @personal.
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personal;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// No description provided for @lastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameRequired;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'000-000-0000'**
  String get phoneHint;

  /// No description provided for @phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get phoneRequired;

  /// No description provided for @phoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Phone number must be at least 10 digits'**
  String get phoneInvalid;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressHint.
  ///
  /// In en, this message translates to:
  /// **'123 Anywhere St, Any City, ST 12345'**
  String get addressHint;

  /// No description provided for @addressRequired.
  ///
  /// In en, this message translates to:
  /// **'Address is required'**
  String get addressRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @companyLogo.
  ///
  /// In en, this message translates to:
  /// **'Company Logo *'**
  String get companyLogo;

  /// No description provided for @companyLogoRequired.
  ///
  /// In en, this message translates to:
  /// **'Company logo is required'**
  String get companyLogoRequired;

  /// No description provided for @selectTheFile.
  ///
  /// In en, this message translates to:
  /// **'Select the file'**
  String get selectTheFile;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyName;

  /// No description provided for @companyNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Company name is required'**
  String get companyNameRequired;

  /// No description provided for @website.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get website;

  /// No description provided for @websiteHint.
  ///
  /// In en, this message translates to:
  /// **'www.autoproof24.com'**
  String get websiteHint;

  /// No description provided for @websiteRequired.
  ///
  /// In en, this message translates to:
  /// **'Website is required'**
  String get websiteRequired;

  /// No description provided for @websiteInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid website URL'**
  String get websiteInvalid;

  /// No description provided for @vatNumber.
  ///
  /// In en, this message translates to:
  /// **'VAT Number'**
  String get vatNumber;

  /// No description provided for @vatRequired.
  ///
  /// In en, this message translates to:
  /// **'VAT number is required'**
  String get vatRequired;

  /// No description provided for @companyRegistrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Company Registration No.'**
  String get companyRegistrationNumber;

  /// No description provided for @registrationRequired.
  ///
  /// In en, this message translates to:
  /// **'Company registration number is required'**
  String get registrationRequired;

  /// No description provided for @shareCapital.
  ///
  /// In en, this message translates to:
  /// **'Share Capital'**
  String get shareCapital;

  /// No description provided for @shareCapitalHint.
  ///
  /// In en, this message translates to:
  /// **'€100,000'**
  String get shareCapitalHint;

  /// No description provided for @shareCapitalRequired.
  ///
  /// In en, this message translates to:
  /// **'Share capital is required'**
  String get shareCapitalRequired;

  /// No description provided for @termsRequired.
  ///
  /// In en, this message translates to:
  /// **'Terms & conditions URL is required'**
  String get termsRequired;

  /// No description provided for @privacyRequired.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy URL is required'**
  String get privacyRequired;

  /// No description provided for @urlInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid URL'**
  String get urlInvalid;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields'**
  String get fillAllFields;

  /// No description provided for @selectCompanyLogo.
  ///
  /// In en, this message translates to:
  /// **'Please select a company logo'**
  String get selectCompanyLogo;

  /// No description provided for @selectCountryCode.
  ///
  /// In en, this message translates to:
  /// **'Please select a country code'**
  String get selectCountryCode;

  /// No description provided for @searchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search country'**
  String get searchCountry;

  /// No description provided for @contactUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get contactUsTitle;

  /// No description provided for @contactUsInfo.
  ///
  /// In en, this message translates to:
  /// **'We\'re happy to assist! If you need help with our mobile app or have any race-related questions, don\'t hesitate to reach out.'**
  String get contactUsInfo;

  /// No description provided for @writeUs.
  ///
  /// In en, this message translates to:
  /// **'Write us'**
  String get writeUs;

  /// No description provided for @subjectLabel.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get subjectLabel;

  /// No description provided for @subjectHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Subject'**
  String get subjectHint;

  /// No description provided for @messageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messageLabel;

  /// No description provided for @messageHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Message'**
  String get messageHint;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @addTeam.
  ///
  /// In en, this message translates to:
  /// **'Add Team'**
  String get addTeam;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @roleDeveloper.
  ///
  /// In en, this message translates to:
  /// **'Developer'**
  String get roleDeveloper;

  /// No description provided for @roleTeamLead.
  ///
  /// In en, this message translates to:
  /// **'Team Lead'**
  String get roleTeamLead;

  /// No description provided for @roleUIDesigner.
  ///
  /// In en, this message translates to:
  /// **'UI/UX Designer'**
  String get roleUIDesigner;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
