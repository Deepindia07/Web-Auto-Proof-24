part of 'share_app_bloc.dart';

@immutable
// sealed class ShareAppEvent {}
abstract class ShareEvent extends Equatable {
  const ShareEvent();

  @override
  List<Object> get props => [];
}

class ShareAppEvent extends ShareEvent {
  final String? subject;
  final String? customMessage;

  const ShareAppEvent({this.subject, this.customMessage});

  @override
  List<Object> get props => [subject ?? '', customMessage ?? ''];
}
