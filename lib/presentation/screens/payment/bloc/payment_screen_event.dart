part of 'payment_screen_bloc.dart';

@immutable
abstract class PaymentScreenEvent {}

class LoadPaymentMethods extends PaymentScreenEvent {}

class SelectPaymentMethod extends PaymentScreenEvent {
  final String paymentMethod;
  SelectPaymentMethod(this.paymentMethod);
}

class InitializeStripePayment extends PaymentScreenEvent {
  final double amount;
  final String currency;
  InitializeStripePayment({required this.amount, this.currency = 'eur'});
}

class ConfirmStripePayment extends PaymentScreenEvent {}

class AddBalance extends PaymentScreenEvent {
  final double amount;
  AddBalance(this.amount);
}

class AddPaymentMethod extends PaymentScreenEvent {}
