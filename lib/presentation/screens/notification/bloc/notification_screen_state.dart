part of 'notification_screen_bloc.dart';

abstract class NotificationScreenState extends Equatable {}

final class NotificationScreenInitial extends NotificationScreenState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class NotificationScreenLoading extends NotificationScreenState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class NotificationScreenSuccess extends NotificationScreenState {
  final GetNotificationModel getNotificationModel;
   NotificationScreenSuccess({required this.getNotificationModel});
  @override
  // TODO: implement props
  List<Object?> get props => [getNotificationModel];
}

final class NotificationScreenError extends NotificationScreenState {
  final String error ;
  NotificationScreenError({required this.error});
  @override
  List<Object?> get props => [];
}
