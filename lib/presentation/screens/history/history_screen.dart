part of "history_screen_route_imple.dart";

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HistoryScreenView();
  }
}

class HistoryScreenView extends StatefulWidget {
  const HistoryScreenView({super.key});

  @override
  State<HistoryScreenView> createState() => _HistoryScreenViewState();
}

class _HistoryScreenViewState extends State<HistoryScreenView> {
  final List<PaymentItem> paymentHistory = [
    PaymentItem(amount: 145.00, date: "Jan 24, 2024", status: "Paid"),
    PaymentItem(amount: 145.00, date: "Jan 24, 2024", status: "Paid"),
    PaymentItem(amount: 145.00, date: "Jan 24, 2024", status: "Paid"),
    PaymentItem(amount: 145.00, date: "Jan 24, 2024", status: "Paid"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
              backgroundColor: AppColor().backgroundColor,
              title: "Payment History"
          ),
          Expanded(
              child: _paymentHistory(context)
          ),
        ],
      ),
    );
  }

  Widget _paymentHistory(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: paymentHistory.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[300],
          thickness: 1,
          height: 1,
        ),
        itemBuilder: (context, index) {
          final payment = paymentHistory[index];
          return _paymentHistoryItem(payment);
        },
      ),
    );
  }

  Widget _paymentHistoryItem(PaymentItem payment) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      color: Colors.white,
      child: Row(
        children: [Container(
            width: 40,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Image.asset(creditCardIcon,height: 16,width: 16,)
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${payment.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  payment.date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            payment.status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentItem {
  final double amount;
  final String date;
  final String status;

  PaymentItem({
    required this.amount,
    required this.date,
    required this.status,
  });
}