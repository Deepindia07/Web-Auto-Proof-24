part of 'payment_screen_bloc.dart';

@immutable
abstract class PaymentScreenState {}

class PaymentScreenInitial extends PaymentScreenState {}

class PaymentScreenLoading extends PaymentScreenState {}

class PaymentScreenLoaded extends PaymentScreenState {
  final String selectedPaymentMethod;
  final double balance;
  final List<PaymentMethod> paymentMethods;

  PaymentScreenLoaded({
    required this.selectedPaymentMethod,
    required this.balance,
    required this.paymentMethods,
  });
}

class PaymentScreenError extends PaymentScreenState {
  final String message;
  PaymentScreenError(this.message);
}

class StripePaymentInitialized extends PaymentScreenState {
  final String clientSecret;
  StripePaymentInitialized(this.clientSecret);
}

class PaymentSuccess extends PaymentScreenState {
  final String paymentIntentId;
  final double amount;
  PaymentSuccess({required this.paymentIntentId, required this.amount});
}

class PaymentProcessing extends PaymentScreenState {}

// payment_method.dart
class PaymentMethod {
  final String id;
  final String title;
  final String type;
  final String? subtitle;
  final String iconPath;

  PaymentMethod({
    required this.id,
    required this.title,
    required this.type,
    this.subtitle,
    required this.iconPath,
  });
}