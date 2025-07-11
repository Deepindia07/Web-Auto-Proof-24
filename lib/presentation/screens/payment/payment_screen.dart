part of 'payment_screen_route_imple.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaymentScreenView();
  }
}

class PaymentScreenView extends StatefulWidget {
  const PaymentScreenView({super.key});

  @override
  State<PaymentScreenView> createState() => _PaymentScreenViewState();
}

class _PaymentScreenViewState extends State<PaymentScreenView> {
  String selectedPaymentMethod = 'apple_pay'; // Default selection

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
          Expanded(child: _paymentView(context))
        ],
      ),
    );
  }

  Widget _paymentView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance Section
          _buildBalanceCard(),

          const SizedBox(height: 20),

          // Add Balance Button
          _buildAddBalanceButton(),

          const SizedBox(height: 30),

          // Payment Method Section
          _buildPaymentMethodHeader(),

          const SizedBox(height: 16),

          // Payment Methods List
          _buildPaymentMethodsList(),

          const SizedBox(height: 25),

          // Add Payment Method Button
          _buildAddPaymentMethodButton(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor().darkCharcoalBlueColor.withOpacity(0.5),width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Balance',
              style: MontserratStyles.montserratMediumTextStyle(color: AppColor().silverShadeGrayColor,size: 12)
          ),
          vGap(8),
           Text(
            '500.00€',
               style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 25)
           ),
        ],
      ),
    );
  }

  Widget _buildAddBalanceButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: AppColor().darkCharcoalBlueColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: () {
          // Handle add balance
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
                style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkYellowColor,size: 16)
            ),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColor().darkYellowColor,
                shape: BoxShape.circle,
              ),
              child:  Icon(
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
      child:  Text(
        'Payment Method',
          style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 16)
      ),
    );
  }

  Widget _buildPaymentMethodsList() {
    return Column(
      children: [
        _buildPaymentMethodItem(
          'Apple Pay',
          Icons.apple,
          'apple_pay',
        ),
        const SizedBox(height: 1),
        _buildPaymentMethodItem(
          'Credit Card',
          Icons.credit_card,
          'credit_card',
          subtitle: '**** **** **** 7445',
        ),
      ],
    );
  }

  Widget _buildPaymentMethodItem(
      String title,
      IconData icon,
      String value, {
        String? subtitle,
      }) {
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
          icon,
          size: 24,
          color: title == 'Apple Pay' ? Colors.black : Colors.blue,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        )
            : null,
        trailing: Radio<String>(
          value: value,
          groupValue: selectedPaymentMethod,
          onChanged: (String? newValue) {
            setState(() {
              selectedPaymentMethod = newValue!;
            });
          },
          activeColor: AppColor().darkYellowColor,
        ),
        onTap: () {
          setState(() {
            selectedPaymentMethod = value;
          });
        },
      ),
    );
  }

  Widget _buildAddPaymentMethodButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: AppColor().darkCharcoalBlueColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: () {
          context.push(AppRoute.cardDetailsScreen);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor().darkCharcoalBlueColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Payment Method',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color:AppColor().darkYellowColor,
              ),
            ),
            SizedBox(width: 8),
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
}

