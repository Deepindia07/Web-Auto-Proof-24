part of 'share_app_bloc.dart';

@immutable
abstract class ShareState extends Equatable {
  const ShareState();

  @override
  List<Object> get props => [];
}

class ShareInitial extends ShareState {}

class ShareLoading extends ShareState {}

class ShareSuccess extends ShareState {
  final String message;

  const ShareSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ShareError extends ShareState {
  final String error;

  const ShareError(this.error);

  @override
  List<Object> get props => [error];
}
