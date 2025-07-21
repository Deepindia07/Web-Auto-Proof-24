import 'package:auto_proof/constants/const_string.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:meta/meta.dart';

part 'payment_screen_event.dart';
part 'payment_screen_state.dart';

class PaymentScreenBloc extends Bloc<PaymentScreenEvent, PaymentScreenState> {

  PaymentScreenBloc() : super(PaymentScreenInitial()) {
    on<LoadPaymentMethods>(_onLoadPaymentMethods);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<InitializeStripePayment>(_onInitializeStripePayment);
    on<ConfirmStripePayment>(_onConfirmStripePayment);
    on<AddBalance>(_onAddBalance);
    on<AddPaymentMethod>(_onAddPaymentMethod);

    // Initialize Stripe
    _initializeStripe();
  }

  void _initializeStripe() {
    Stripe.publishableKey = stripeKey;
  }

  void _onLoadPaymentMethods(LoadPaymentMethods event, Emitter<PaymentScreenState> emit) {
    emit(PaymentScreenLoading());

    try {
      final paymentMethods = [
        PaymentMethod(
          id: 'apple_pay',
          title: 'Apple Pay',
          type: 'apple_pay',
          iconPath: 'assets/icons/apple_pay.png',
        ),
        PaymentMethod(
          id: 'credit_card',
          title: 'Credit Card',
          type: 'credit_card',
          subtitle: '**** **** **** 7445',
          iconPath: 'assets/icons/credit_card.png',
        ),
      ];

      emit(PaymentScreenLoaded(
        selectedPaymentMethod: 'apple_pay',
        balance: 500.00,
        paymentMethods: paymentMethods,
      ));
    } catch (e) {
      emit(PaymentScreenError('Failed to load payment methods: ${e.toString()}'));
    }
  }

  void _onSelectPaymentMethod(SelectPaymentMethod event, Emitter<PaymentScreenState> emit) {
    final currentState = state;
    if (currentState is PaymentScreenLoaded) {
      emit(PaymentScreenLoaded(
        selectedPaymentMethod: event.paymentMethod,
        balance: currentState.balance,
        paymentMethods: currentState.paymentMethods,
      ));
    }
  }

  void _onInitializeStripePayment(InitializeStripePayment event, Emitter<PaymentScreenState> emit) async {
    emit(PaymentScreenLoading());

    try {
      // Create payment intent on your backend
      // final response = await http.post(
      //   Uri.parse('$_backendUrl/create-payment-intent'),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode({
      //     'amount': (event.amount * 100).toInt(), // Convert to cents
      //     'currency': event.currency,
      //   }),
      // );

      // if (response.statusCode == 200) {
      //   final data = jsonDecode(response.body);
      //   final clientSecret = data['client_secret'];
      //
      //   emit(StripePaymentInitialized(clientSecret));
      // } else {
      //   emit(PaymentScreenError('Failed to initialize payment'));
      // }
    } catch (e) {
      emit(PaymentScreenError('Payment initialization failed: ${e.toString()}'));
    }
  }

  void _onConfirmStripePayment(ConfirmStripePayment event, Emitter<PaymentScreenState> emit) async {
    emit(PaymentProcessing());

    try {
      final currentState = state;
      if (currentState is StripePaymentInitialized) {
        // Confirm payment with Stripe
        // final paymentIntent = await Stripe.instance.confirmPayment(
        //   paymentIntentClientSecret: currentState.clientSecret,
        //   data: const PaymentMethodData.card(
        //     CardFieldInputDetails(),
        //   ),
        // );

        // if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        //   emit(PaymentSuccess(
        //     paymentIntentId: paymentIntent.id,
        //     amount: 0.0, // You'll need to track this
        //   ));
        // } else {
        //   emit(PaymentScreenError('Payment failed'));
        // }
      }
    } catch (e) {
      emit(PaymentScreenError('Payment confirmation failed: ${e.toString()}'));
    }
  }

  void _onAddBalance(AddBalance event, Emitter<PaymentScreenState> emit) {
    // Initialize Stripe payment for adding balance
    add(InitializeStripePayment(amount: event.amount));
  }

  void _onAddPaymentMethod(AddPaymentMethod event, Emitter<PaymentScreenState> emit) {
    // Handle navigation to add payment method screen
    // This would typically trigger navigation in the UI
  }

}
