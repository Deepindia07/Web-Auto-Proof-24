part of 'get_subscription_bloc.dart';

abstract class GetSubscriptionState extends Equatable {
  const GetSubscriptionState();
}

final class GetSubscriptionInitial extends GetSubscriptionState {
  @override
  List<Object> get props => [];
}

///------------

final class GetSubscriptionLoading extends GetSubscriptionState{
  @override
  List<Object> get props => [];
}


 class GetSubscriptionSuccess extends GetSubscriptionState{
  GetSubscriptionPlanModel? getSubscriptionPlanModel ;
  GetSubscriptionSuccess({required this.getSubscriptionPlanModel});
  @override
  List<Object?> get props => [getSubscriptionPlanModel];

}

class GetSubscriptionError extends GetSubscriptionState {
  final String error ;
  GetSubscriptionError({required this.error});
  @override
  List<Object?> get props => [error];
}