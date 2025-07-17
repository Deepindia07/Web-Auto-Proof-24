part of 'payment_screen_route_imple.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentScreenBloc()..add(LoadPaymentMethods()),
      child: const PaymentScreenView(),
    );
  }
}

class PaymentScreenView extends StatefulWidget {
  const PaymentScreenView({super.key});

  @override
  State<PaymentScreenView> createState() => _PaymentScreenViewState();
}

class _PaymentScreenViewState extends State<PaymentScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: "Payment Method",
          ),
          Expanded(
            child: BlocConsumer<PaymentScreenBloc, PaymentScreenState>(
              listener: (context, state) {
                if (state is PaymentScreenError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                } else if (state is PaymentSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Payment successful! Amount: €${state.amount}'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is StripePaymentInitialized) {
                  _showStripePaymentSheet(context, state.clientSecret);
                }
              },
              builder: (context, state) {
                if (state is PaymentScreenLoading || state is PaymentProcessing) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PaymentScreenLoaded) {
                  return _paymentView(context, state);
                } else {
                  return const Center(child: Text('Something went wrong'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentView(BuildContext context, PaymentScreenLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBalanceCard(state.balance),
          const SizedBox(height: 20),
          _buildAddBalanceButton(context),
          const SizedBox(height: 30),
          _buildPaymentMethodHeader(),
          const SizedBox(height: 16),
          _buildPaymentMethodsList(context, state),
          const SizedBox(height: 25),
          _buildAddPaymentMethodButton(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBalanceCard(double balance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor().darkCharcoalBlueColor.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Balance',
            style: MontserratStyles.montserratMediumTextStyle(
              color: AppColor().silverShadeGrayColor,
              size: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '€${balance.toStringAsFixed(2)}',
            style: MontserratStyles.montserratMediumTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddBalanceButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: AppColor().darkCharcoalBlueColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: () {
          _showAddBalanceDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor().darkCharcoalBlueColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Balance',
              style: MontserratStyles.montserratMediumTextStyle(
                color: AppColor().darkYellowColor,
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColor().darkYellowColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: AppColor().darkCharcoalBlueColor,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColor().darkYellowColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        'Payment Method',
        style: MontserratStyles.montserratMediumTextStyle(
          color: AppColor().darkCharcoalBlueColor,
          size: 16,
        ),
      ),
    );
  }

  Widget _buildPaymentMethodsList(BuildContext context, PaymentScreenLoaded state) {
    return Column(
      children: state.paymentMethods.map((method) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 1),
          child: _buildPaymentMethodItem(
            context,
            method,
            state.selectedPaymentMethod,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPaymentMethodItem(
      BuildContext context,
      PaymentMethod method,
      String selectedMethod,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(
          method.type == 'apple_pay' ? Icons.apple : Icons.credit_card,
          size: 24,
          color: method.type == 'apple_pay' ? Colors.black : Colors.blue,
        ),
        title: Text(
          method.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        subtitle: method.subtitle != null
            ? Text(
          method.subtitle!,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        )
            : null,
        trailing: Radio<String>(
          value: method.id,
          groupValue: selectedMethod,
          onChanged: (String? newValue) {
            if (newValue != null) {
              context.read<PaymentScreenBloc>().add(SelectPaymentMethod(newValue));
            }
          },
          activeColor: AppColor().darkYellowColor,
        ),
        onTap: () {
          context.read<PaymentScreenBloc>().add(SelectPaymentMethod(method.id));
        },
      ),
    );
  }

  Widget _buildAddPaymentMethodButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: AppColor().darkCharcoalBlueColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: () {
          context.read<PaymentScreenBloc>().add(AddPaymentMethod());
          // Navigate to card details screen
          // context.push(AppRoute.cardDetailsScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor().darkCharcoalBlueColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Payment Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor().darkYellowColor,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: AppColor().darkYellowColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddBalanceDialog(BuildContext context) {
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Balance'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Enter amount',
            prefixText: '€',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final amount = double.tryParse(amountController.text);
              if (amount != null && amount > 0) {
                Navigator.pop(context);
                context.read<PaymentScreenBloc>().add(AddBalance(amount));
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showStripePaymentSheet(BuildContext context, String clientSecret) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // Payment successful
      if (context.mounted) {
        context.read<PaymentScreenBloc>().add(ConfirmStripePayment());
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment cancelled: ${e.toString()}')),
        );
      }
    }
  }
}
