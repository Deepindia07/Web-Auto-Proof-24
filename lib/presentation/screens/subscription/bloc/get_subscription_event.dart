part of 'get_subscription_bloc.dart';

abstract class GetSubscriptionEvent extends Equatable {
  const GetSubscriptionEvent();
}

class  GetSubscriptionApiEvent extends GetSubscriptionEvent {
  @override
List<Object> get props=> [];

}
