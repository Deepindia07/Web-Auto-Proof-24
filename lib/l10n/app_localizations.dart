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

  /// No description provided for @emailValidationMsg.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get emailValidationMsg;

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

  /// No description provided for @phoneSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Phone Number verified successfully!'**
  String get phoneSuccessfully;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Your password has been successfully forgot'**
  String get forgotPassword;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **' Terms'**
  String get terms;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @createAccountNow.
  ///
  /// In en, this message translates to:
  /// **'Create Free Account Now'**
  String get createAccountNow;

  /// No description provided for @staticTitle.
  ///
  /// In en, this message translates to:
  /// **'Get 3 free Inspections '**
  String get staticTitle;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @frenchText.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get frenchText;

  /// No description provided for @verifyEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email address first'**
  String get verifyEmailAddress;

  /// No description provided for @agreeTermsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms & Privacy'**
  String get agreeTermsPrivacy;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address first'**
  String get enterEmail;

  /// No description provided for @emailSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Email verified successfully!'**
  String get emailSuccessfully;

  /// No description provided for @verificationOtpMsg.
  ///
  /// In en, this message translates to:
  /// **'Verification code sent to your email!'**
  String get verificationOtpMsg;

  /// No description provided for @subTitleText1.
  ///
  /// In en, this message translates to:
  /// **'The smart vehicle inspection app.'**
  String get subTitleText1;

  /// No description provided for @subTitleText2.
  ///
  /// In en, this message translates to:
  /// **'Digitize your condition reports.'**
  String get subTitleText2;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @accountDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get accountDelete;

  /// No description provided for @accountDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete?'**
  String get accountDeleteConfirm;

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
  /// **'I have read, understand, and agree to Auto proof 24 '**
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
  /// **'Have an account? '**
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

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

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

  /// No description provided for @companyInformationSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Create company information successfully'**
  String get companyInformationSuccessfully;

  /// Label for the information section
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

  /// No description provided for @dashboardText.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardText;

  /// No description provided for @myProfileText.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfileText;

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

  /// No description provided for @forgotPasswordText.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordText;

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

  /// No description provided for @companyInformation.
  ///
  /// In en, this message translates to:
  /// **'Company Information'**
  String get companyInformation;

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

  /// No description provided for @checkInOut.
  ///
  /// In en, this message translates to:
  /// **'Check in / out'**
  String get checkInOut;

  /// No description provided for @selectGasLevel.
  ///
  /// In en, this message translates to:
  /// **'Select Gas Level'**
  String get selectGasLevel;

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

  /// No description provided for @instruction.
  ///
  /// In en, this message translates to:
  /// **'Instruction'**
  String get instruction;

  /// No description provided for @carDetails.
  ///
  /// In en, this message translates to:
  /// **'Car Details'**
  String get carDetails;

  /// No description provided for @ownerDetails.
  ///
  /// In en, this message translates to:
  /// **'Owner Details'**
  String get ownerDetails;

  /// No description provided for @clientDetails.
  ///
  /// In en, this message translates to:
  /// **'Client Details'**
  String get clientDetails;

  /// No description provided for @step.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get step;

  /// Indicates the current step out of the total steps.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepOfTotal(int current, int total);

  /// No description provided for @departureGuide.
  ///
  /// In en, this message translates to:
  /// **'Departure Guide'**
  String get departureGuide;

  /// No description provided for @returnGuide.
  ///
  /// In en, this message translates to:
  /// **'Return Guide'**
  String get returnGuide;

  /// No description provided for @inspectionNumber.
  ///
  /// In en, this message translates to:
  /// **'Inspection Number'**
  String get inspectionNumber;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @welcomeVehicleInspection.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Vehicle Inspection'**
  String get welcomeVehicleInspection;

  /// No description provided for @followInstructions.
  ///
  /// In en, this message translates to:
  /// **'Please follow the instructions carefully to complete your vehicle inspection process.'**
  String get followInstructions;

  /// Button text to import car information
  ///
  /// In en, this message translates to:
  /// **'Import Information'**
  String get importInformation;

  /// Label for number plate field
  ///
  /// In en, this message translates to:
  /// **'Number Plate'**
  String get numberPlate;

  /// Hint text for number plate format
  ///
  /// In en, this message translates to:
  /// **'LL-000-00'**
  String get numberPlateHint;

  /// Label for car brand field
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// Hint text for car brand
  ///
  /// In en, this message translates to:
  /// **'FERRARI'**
  String get brandHint;

  /// Label for car model field
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// Hint text for car model
  ///
  /// In en, this message translates to:
  /// **'SF90 Stradale'**
  String get modelHint;

  /// Label for car mileage field
  ///
  /// In en, this message translates to:
  /// **'Mileage'**
  String get mileage;

  /// Hint text for car mileage
  ///
  /// In en, this message translates to:
  /// **'7.7 km'**
  String get mileageHint;

  /// Label for gas type dropdown
  ///
  /// In en, this message translates to:
  /// **'Gas Type'**
  String get gasType;

  /// Diesel fuel type option
  ///
  /// In en, this message translates to:
  /// **'Diesel'**
  String get diesel;

  /// Petrol fuel type option
  ///
  /// In en, this message translates to:
  /// **'Petrol'**
  String get petrol;

  /// Electric fuel type option
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get electric;

  /// Hybrid fuel type option
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get hybrid;

  /// Label for gas level dropdown
  ///
  /// In en, this message translates to:
  /// **'Gas Level'**
  String get gasLevel;

  /// Empty gas level option
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get empty;

  /// One eighth gas level
  ///
  /// In en, this message translates to:
  /// **'1/8'**
  String get oneEighth;

  /// Two eighths gas level
  ///
  /// In en, this message translates to:
  /// **'2/8'**
  String get twoEighths;

  /// Three eighths gas level
  ///
  /// In en, this message translates to:
  /// **'3/8'**
  String get threeEighths;

  /// Half gas level
  ///
  /// In en, this message translates to:
  /// **'Half'**
  String get half;

  /// Five eighths gas level
  ///
  /// In en, this message translates to:
  /// **'5/8'**
  String get fiveEighths;

  /// Six eighths gas level
  ///
  /// In en, this message translates to:
  /// **'6/8'**
  String get sixEighths;

  /// Seven eighths gas level
  ///
  /// In en, this message translates to:
  /// **'7/8'**
  String get sevenEighths;

  /// Full gas level
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get full;

  /// Label for tyre condition field
  ///
  /// In en, this message translates to:
  /// **'Tyre Condition'**
  String get tyreCondition;

  /// Hint text for tyre condition
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get tyreConditionHint;

  /// Label for kilometers per day field
  ///
  /// In en, this message translates to:
  /// **'Km/day'**
  String get kmDay;

  /// Label for extra kilometers cost field
  ///
  /// In en, this message translates to:
  /// **'Extra KM'**
  String get extraKm;

  /// Euro currency symbol
  ///
  /// In en, this message translates to:
  /// **'€'**
  String get euroSymbol;

  /// Label for total price field
  ///
  /// In en, this message translates to:
  /// **'Price Total '**
  String get priceTotal;

  /// Label for upload insurance button
  ///
  /// In en, this message translates to:
  /// **'Up.insurance'**
  String get uploadInsurance;

  /// Insurance file name display
  ///
  /// In en, this message translates to:
  /// **'Insrance.jpg'**
  String get insuranceFile;

  /// Label for the checklist section
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get checklist;

  /// Label for softy pack checklist item
  ///
  /// In en, this message translates to:
  /// **'Safety Pack'**
  String get softyPack;

  /// No description provided for @selectLeaseStartDate.
  ///
  /// In en, this message translates to:
  /// **'Lease Start Date & Time'**
  String get selectLeaseStartDate;

  /// No description provided for @selectLeaseEndDate.
  ///
  /// In en, this message translates to:
  /// **'Lease End Date & Time'**
  String get selectLeaseEndDate;

  /// Label for spare wheel checklist item
  ///
  /// In en, this message translates to:
  /// **'Spare Wheel'**
  String get spareWheel;

  /// Label for phone older checklist item
  ///
  /// In en, this message translates to:
  /// **'Phone holder'**
  String get phoneOlder;

  /// Label for GPS checklist item
  ///
  /// In en, this message translates to:
  /// **'GPS'**
  String get gps;

  /// Label for charging port checklist item
  ///
  /// In en, this message translates to:
  /// **'Charging Port'**
  String get chargingPort;

  /// Label for car papers checklist item
  ///
  /// In en, this message translates to:
  /// **'Car Papers'**
  String get carPapers;

  /// Label for comment section
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// Hint text for comment field
  ///
  /// In en, this message translates to:
  /// **'Enter Comments'**
  String get enterComments;

  /// Text shown in file upload area
  ///
  /// In en, this message translates to:
  /// **'Upload Insurance'**
  String get dropTheFile;

  /// Error message when image fails to load
  ///
  /// In en, this message translates to:
  /// **'Error loading image'**
  String get errorLoadingImage;

  /// Message when no image is selected
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get noImageSelected;

  /// Title for validation error dialog
  ///
  /// In en, this message translates to:
  /// **'Validation Errors'**
  String get validationErrors;

  /// OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Title for update profile picture dialog
  ///
  /// In en, this message translates to:
  /// **'Update Profile Picture'**
  String get updateProfilePicture;

  /// Error message for invalid image format
  ///
  /// In en, this message translates to:
  /// **'Invalid image format or user ID not found'**
  String get invalidImageFormat;

  /// Error message when image selection fails
  ///
  /// In en, this message translates to:
  /// **'Error selecting image: {error}'**
  String errorSelectingImage(String error);

  /// No description provided for @gpsMandatory.
  ///
  /// In en, this message translates to:
  /// **'GPS is mandatory and cannot be turned off.'**
  String get gpsMandatory;

  /// No description provided for @licenseInstruction.
  ///
  /// In en, this message translates to:
  /// **'I checked and took picture of the original driver\'s license. (Copy not accepted)'**
  String get licenseInstruction;

  /// No description provided for @licenseInstructionId.
  ///
  /// In en, this message translates to:
  /// **'I checked and took picture of the original driver\'s ID. (Copy not accepted)'**
  String get licenseInstructionId;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// No description provided for @drivingLicense.
  ///
  /// In en, this message translates to:
  /// **'Driving License'**
  String get drivingLicense;

  /// No description provided for @dateOfIssue.
  ///
  /// In en, this message translates to:
  /// **'Date of Issue'**
  String get dateOfIssue;

  /// No description provided for @selectGasType.
  ///
  /// In en, this message translates to:
  /// **'Select Gas Type'**
  String get selectGasType;

  /// No description provided for @rentalDuration.
  ///
  /// In en, this message translates to:
  /// **'Rental Duration'**
  String get rentalDuration;

  /// No description provided for @leaseEndDateTime.
  ///
  /// In en, this message translates to:
  /// **'Lease end date & time'**
  String get leaseEndDateTime;

  /// No description provided for @mandatoryPicture.
  ///
  /// In en, this message translates to:
  /// **'Mandatory Picture'**
  String get mandatoryPicture;

  /// No description provided for @frontSide.
  ///
  /// In en, this message translates to:
  /// **'Front Side'**
  String get frontSide;

  /// No description provided for @frontLeftWheel.
  ///
  /// In en, this message translates to:
  /// **'Front Left Wheel'**
  String get frontLeftWheel;

  /// No description provided for @frontLeftSide.
  ///
  /// In en, this message translates to:
  /// **'Front Left Side'**
  String get frontLeftSide;

  /// No description provided for @rearLeftSide.
  ///
  /// In en, this message translates to:
  /// **'Rear Left Side'**
  String get rearLeftSide;

  /// No description provided for @rearLeftWheel.
  ///
  /// In en, this message translates to:
  /// **'Rear Left Wheel'**
  String get rearLeftWheel;

  /// No description provided for @rearSide.
  ///
  /// In en, this message translates to:
  /// **'Rear Side'**
  String get rearSide;

  /// No description provided for @backRightWheel.
  ///
  /// In en, this message translates to:
  /// **'Back Right Wheel'**
  String get backRightWheel;

  /// No description provided for @addCar.
  ///
  /// In en, this message translates to:
  /// **'Add Car'**
  String get addCar;

  /// No description provided for @agentDetails.
  ///
  /// In en, this message translates to:
  /// **'Agent Details'**
  String get agentDetails;

  /// No description provided for @addAgent.
  ///
  /// In en, this message translates to:
  /// **'Add Agent'**
  String get addAgent;

  /// No description provided for @rearRightSide.
  ///
  /// In en, this message translates to:
  /// **'Rear Right Side'**
  String get rearRightSide;

  /// No description provided for @frontRightSide.
  ///
  /// In en, this message translates to:
  /// **'Front Right Side'**
  String get frontRightSide;

  /// No description provided for @frontRightWheel.
  ///
  /// In en, this message translates to:
  /// **'Front Right Wheel'**
  String get frontRightWheel;

  /// No description provided for @frontSeats.
  ///
  /// In en, this message translates to:
  /// **'Front Seats'**
  String get frontSeats;

  /// No description provided for @rearSeats.
  ///
  /// In en, this message translates to:
  /// **'Rear Seats'**
  String get rearSeats;

  /// No description provided for @odometer.
  ///
  /// In en, this message translates to:
  /// **'Odometer'**
  String get odometer;

  /// No description provided for @optionalImage1.
  ///
  /// In en, this message translates to:
  /// **'Optional Image 1'**
  String get optionalImage1;

  /// No description provided for @optionalImage2.
  ///
  /// In en, this message translates to:
  /// **'Optional Image 2'**
  String get optionalImage2;

  /// No description provided for @optionalImage3.
  ///
  /// In en, this message translates to:
  /// **'Optional Image 3'**
  String get optionalImage3;

  /// No description provided for @ownerSignature.
  ///
  /// In en, this message translates to:
  /// **'Owner Signature'**
  String get ownerSignature;

  /// No description provided for @signHere.
  ///
  /// In en, this message translates to:
  /// **'Sign Here'**
  String get signHere;

  /// No description provided for @directlyWithFinger.
  ///
  /// In en, this message translates to:
  /// **'Directly with your finger'**
  String get directlyWithFinger;

  /// No description provided for @seeReport.
  ///
  /// In en, this message translates to:
  /// **'See Report'**
  String get seeReport;

  /// No description provided for @validation.
  ///
  /// In en, this message translates to:
  /// **'Validation'**
  String get validation;

  /// No description provided for @byPressingValidate.
  ///
  /// In en, this message translates to:
  /// **'By Pressing \"Validate\" :'**
  String get byPressingValidate;

  /// No description provided for @acceptTerms.
  ///
  /// In en, this message translates to:
  /// **'I accept the terms and conditions of Auto Proof.'**
  String get acceptTerms;

  /// No description provided for @acceptPolicy.
  ///
  /// In en, this message translates to:
  /// **'I accept the data protection policy.'**
  String get acceptPolicy;

  /// No description provided for @confirmLegalSignature.
  ///
  /// In en, this message translates to:
  /// **'I confirm that the signature is legally valid and has the same value as a handwritten signature.'**
  String get confirmLegalSignature;

  /// No description provided for @allowSignatureUsage.
  ///
  /// In en, this message translates to:
  /// **'This signature may be used by me (or my authorized representative) on the vehicle inspection report.'**
  String get allowSignatureUsage;

  /// No description provided for @validateSignature.
  ///
  /// In en, this message translates to:
  /// **'Validate Signature'**
  String get validateSignature;

  /// No description provided for @validateSignatureQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to validate this signature?'**
  String get validateSignatureQuestion;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @changeText.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get changeText;

  /// No description provided for @passwordText.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordText;

  /// No description provided for @emailSentMessageTittle.
  ///
  /// In en, this message translates to:
  /// **'We have sent code to your '**
  String get emailSentMessageTittle;

  /// No description provided for @validate.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get validate;

  /// No description provided for @provideSignatureError.
  ///
  /// In en, this message translates to:
  /// **'Please provide a signature before validating'**
  String get provideSignatureError;

  /// No description provided for @signatureValidated.
  ///
  /// In en, this message translates to:
  /// **'Signature validated successfully'**
  String get signatureValidated;

  /// No description provided for @accountCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreatedSuccessfully;

  /// No description provided for @pinIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Pin is incorrect'**
  String get pinIncorrect;

  /// No description provided for @clientSignature.
  ///
  /// In en, this message translates to:
  /// **'Client Signature'**
  String get clientSignature;

  /// No description provided for @autoProofTitle.
  ///
  /// In en, this message translates to:
  /// **'Auto Proof 24'**
  String get autoProofTitle;

  /// No description provided for @aboutTheAppTitle.
  ///
  /// In en, this message translates to:
  /// **'About the App'**
  String get aboutTheAppTitle;

  /// No description provided for @aboutTheAppDescription.
  ///
  /// In en, this message translates to:
  /// **'Auto Proof 24 is a simple, easy-to-use digital car inspection app designed to make vehicle check-ins and check-outs faster, clearer, and more reliable. Whether you’re running a car rental service, managing a dealership, or just want to keep a personal record of your vehicle’s condition, this app is built for you.'**
  String get aboutTheAppDescription;

  /// No description provided for @ourGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'Our Goal'**
  String get ourGoalTitle;

  /// No description provided for @ourGoalDescription.
  ///
  /// In en, this message translates to:
  /// **'Our goal is to take the stress out of car inspections by making the process digital, efficient, and completely paper-free.'**
  String get ourGoalDescription;

  /// No description provided for @whatYouCanDoTitle.
  ///
  /// In en, this message translates to:
  /// **'What You Can Do'**
  String get whatYouCanDoTitle;

  /// No description provided for @whatYouCanDoDescription.
  ///
  /// In en, this message translates to:
  /// **'Create an account, carry out detailed inspections, and receive a professional report instantly by email. The app walks you through each step — take photos, add notes, log mileage, fuel levels, tire conditions, and any existing damage.'**
  String get whatYouCanDoDescription;

  /// No description provided for @digitalReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Digital Reports'**
  String get digitalReportsTitle;

  /// No description provided for @digitalReportsDescription.
  ///
  /// In en, this message translates to:
  /// **'Every inspection generates a time-stamped digital report that’s automatically shared with both the vehicle owner and the customer, creating a clear and trustworthy record.'**
  String get digitalReportsDescription;

  /// No description provided for @whoItsForTitle.
  ///
  /// In en, this message translates to:
  /// **'Who It’s For'**
  String get whoItsForTitle;

  /// No description provided for @whoItsForDescription.
  ///
  /// In en, this message translates to:
  /// **'Whether you’re handling a fleet or just one vehicle, Auto Proof 24 gives you a smart and reliable way to document your car’s condition — anytime, anywhere.'**
  String get whoItsForDescription;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version: {version}'**
  String appVersion(Object version);
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
