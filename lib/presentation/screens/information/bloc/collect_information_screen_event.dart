part of 'collect_information_screen_bloc.dart';

@immutable
abstract class CollectInformationScreenEvent {}

class UpdatePersonalInformationEvent extends CollectInformationScreenEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String countryCode;
  final String address;
  final String userId;

  UpdatePersonalInformationEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.countryCode,
    required this.address,
    required this.userId,
  });
}

class UpdateCompanyInformationEvent extends CollectInformationScreenEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String countryCode;
  final String address;
  final String companyName;
  final String website;
  final String vatNumber;
  final String companyRegistrationNumber;
  final String shareCapital;
  final String termAndConditions;
  final String companyPolicy;
  final String userId;
  final File? companyLogo;

  UpdateCompanyInformationEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.countryCode,
    required this.address,
    required this.companyName,
    required this.website,
    required this.vatNumber,
    required this.companyRegistrationNumber,
    required this.shareCapital,
    required this.termAndConditions,
    required this.companyPolicy,
    required this.userId,
    this.companyLogo,
  });
}

class ResetCollectInformationStateEvent extends CollectInformationScreenEvent {}
