part of 'subscription_screen_route_imple.dart';

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Card Details",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2D4A),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Add new card",
                  style: TextStyle(fontSize: 16, color: Color(0xFF1F2D4A)),
                ),
                const SizedBox(height: 20),

                // Card Image
                Image.asset(dummyCardIcon, height: 100),
                const SizedBox(height: 24),

                // Card Number
                _buildField('Card Number', hint: "Card Number"),

                const SizedBox(height: 16),

                // Holder Name
                _buildField('Holder Name', hint: "Holder Name"),

                const SizedBox(height: 16),

                // Expiry Date
                _buildField('Expiry Date', hint: "234-345-6789"),

                const SizedBox(height: 16),

                // Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (val) {},
                      side: const BorderSide(
                        color: Color(0xFF1F2D4A),
                        width: 1.5,
                      ),
                    ),
                    const Text(
                      "Set as default card",
                      style: TextStyle(color: Color(0xFF1F2D4A), fontSize: 14),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Pay Now Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF1F2D4A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Pay Now",
                      style: TextStyle(color: Colors.amber, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, {String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF1F2D4A),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          decoration: InputDecoration(
            isDense: true,
            hintText: hint ?? label,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 9,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Color(0xFF1F2D4A)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Color(0xFF1F2D4A)),
            ),
          ),
        ),
      ],
    );
  }
}
