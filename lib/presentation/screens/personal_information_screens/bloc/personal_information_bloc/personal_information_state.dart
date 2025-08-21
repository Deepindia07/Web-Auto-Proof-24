part of 'personal_information_bloc.dart';

abstract class PersonalInformationState extends Equatable {
  const PersonalInformationState();
}

class PersonalInformationInitial extends PersonalInformationState {
  @override
  List<Object> get props => [];
}

class PersonalInformationLoading extends PersonalInformationState {
  @override
  List<Object> get props => [];
}

class PersonalInformationSuccess extends PersonalInformationState {


  @override
  List<Object> get props => [];
}

class PersonalInformationError extends PersonalInformationState {
  final String error;
  const PersonalInformationError({required this.error});
  @override
  List<Object> get props => [error];
}

class GetPersonalInfoLoading extends PersonalInformationState {
  @override
  List<Object> get props => [];
}

class GetPersonalInfoSuccess extends PersonalInformationState {
 final UserResponseModel userProfile;
 const GetPersonalInfoSuccess({required this.userProfile});
  @override
  List<Object> get props => [userProfile];
}

class GetPersonalInfoError extends PersonalInformationState {
  final String error;
  const GetPersonalInfoError({required this.error});
  @override
  List<Object> get props => [error];
}
