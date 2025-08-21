part of 'personal_information_bloc.dart';

abstract class PersonalInformationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends PersonalInformationEvent {
  final ProfileModel profile;
  UpdateProfileEvent({required this.profile});

  @override
  List<Object?> get props => [profile];
}


class GetPersonalInfoApiEvent extends PersonalInformationEvent{

  GetPersonalInfoApiEvent();
  @override
  List<Object?> get props => [];
}

