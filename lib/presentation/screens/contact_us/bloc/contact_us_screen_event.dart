part of 'contact_us_screen_bloc.dart';

@immutable
sealed class ContactUsScreenEvent {}

class SubmitContactUsEvent extends ContactUsScreenEvent {
  final String subject;
  final String message;

  SubmitContactUsEvent({
    required this.subject,
    required this.message,
  });
}