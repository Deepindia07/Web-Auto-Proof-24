part of 'contact_us_screen_bloc.dart';

@immutable
sealed class ContactUsScreenState {}

final class ContactUsScreenInitial extends ContactUsScreenState {}

final class ContactUsScreenLoading extends ContactUsScreenState {}

final class ContactUsScreenSuccess extends ContactUsScreenState {
  final ContactUsResponseModel response;

  ContactUsScreenSuccess({required this.response});
}

final class ContactUsScreenError extends ContactUsScreenState {
  final String errorMessage;

  ContactUsScreenError({required this.errorMessage});
}