import 'dart:io';

import '../bloc/collect_information_screen_bloc.dart';

extension CollectInformationScreenBlocExtension on CollectInformationScreenBloc {
  void updatePersonalInformation({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required String address,
    required String userId,
  }) {
    add(UpdatePersonalInformationEvent(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
      address: address,
      userId: userId,
    ));
  }

  void updateCompanyInformation({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String countryCode,
    required String address,
    required String companyName,
    required String website,
    required String vatNumber,
    required String companyRegistrationNumber,
    required String shareCapital,
    required String termAndConditions,
    required String companyPolicy,
    required String userId,
    File? companyLogo,
  }) {
    add(UpdateCompanyInformationEvent(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
      address: address,
      companyName: companyName,
      website: website,
      vatNumber: vatNumber,
      companyRegistrationNumber: companyRegistrationNumber,
      shareCapital: shareCapital,
      termAndConditions: termAndConditions,
      companyPolicy: companyPolicy,
      userId: userId,
      companyLogo: companyLogo,
    ));
  }

  void resetState() {
    add(ResetCollectInformationStateEvent());
  }
}
