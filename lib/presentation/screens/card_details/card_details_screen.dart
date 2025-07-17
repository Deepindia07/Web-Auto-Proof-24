

part of "card_details_screen_route_imple.dart";

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CardDetailsScreenView();
  }
}

class CardDetailsScreenView extends StatefulWidget {
  const CardDetailsScreenView({super.key});

  @override
  State<CardDetailsScreenView> createState() => _CardDetailsScreenViewState();
}

class _CardDetailsScreenViewState extends State<CardDetailsScreenView> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _holderNameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  bool _isDefaultCard = false;
  bool _isLoading = false;
  File? _capturedImage;
  final ImagePicker _picker = ImagePicker();
  // final TextRecognizer _textRecognizer = TextRecognizer();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _holderNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    // _textRecognizer.close();
    super.dispose();
  }

  // Method to scan card from camera or gallery
  Future<void> _scanCard(ImageSource source) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        _capturedImage = File(pickedFile.path);
        // await _processCardImage(_capturedImage!);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error scanning card: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // // Process the captured image to extract card details
  // Future<void> _processCardImage(File imageFile) async {
  //   try {
  //     final InputImage inputImage = InputImage.fromFile(imageFile);
  //     final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
  //
  //     String extractedText = recognizedText.text;
  //     _extractCardDetails(extractedText);
  //
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error processing image: ${e.toString()}')),
  //     );
  //   }
  // }

  // Extract card details from recognized text
  void _extractCardDetails(String text) {
    // Extract card number (16 digits)
    RegExp cardNumberRegex = RegExp(r'\b\d{4}\s?\d{4}\s?\d{4}\s?\d{4}\b');
    Match? cardNumberMatch = cardNumberRegex.firstMatch(text);
    if (cardNumberMatch != null) {
      String cardNumber = cardNumberMatch.group(0)!.replaceAll(' ', '');
      _cardNumberController.text = _formatCardNumber(cardNumber);
    }

    // Extract expiry date (MM/YY or MM/YYYY)
    RegExp expiryRegex = RegExp(r'\b(0[1-9]|1[0-2])\s?[/\-]\s?(\d{2}|\d{4})\b');
    Match? expiryMatch = expiryRegex.firstMatch(text);
    if (expiryMatch != null) {
      String expiry = expiryMatch.group(0)!.replaceAll(' ', '');
      _expiryDateController.text = expiry;
    }

    // Extract CVV (3 or 4 digits)
    RegExp cvvRegex = RegExp(r'\b\d{3,4}\b');
    Iterable<Match> cvvMatches = cvvRegex.allMatches(text);
    for (Match match in cvvMatches) {
      String potential = match.group(0)!;
      if (potential.length == 3 || potential.length == 4) {
        // Additional logic to identify CVV vs other numbers
        if (!_cardNumberController.text.contains(potential)) {
          _cvvController.text = potential;
          break;
        }
      }
    }

    // Extract cardholder name (typically in uppercase)
    List<String> lines = text.split('\n');
    for (String line in lines) {
      line = line.trim();
      if (line.length > 3 &&
          line.toUpperCase() == line &&
          RegExp(r'^[A-Z\s]+$').hasMatch(line) &&
          !RegExp(r'\d').hasMatch(line)) {
        _holderNameController.text = line;
        break;
      }
    }

    setState(() {});
  }

  String _formatCardNumber(String cardNumber) {
    cardNumber = cardNumber.replaceAll(' ', '');
    if (cardNumber.length >= 4) {
      String formatted = '';
      for (int i = 0; i < cardNumber.length; i += 4) {
        if (i + 4 <= cardNumber.length) {
          formatted += cardNumber.substring(i, i + 4) + ' ';
        } else {
          formatted += cardNumber.substring(i);
        }
      }
      return formatted.trim();
    }
    return cardNumber;
  }


  void _showScanOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Scan Credit Card',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColor().darkYellowColor,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _scanCard(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.green),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _scanCard(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: "Add new card",
          ),
          Expanded(child: _buildCardDetailsForm()),
        ],
      ),
    );
  }

  Widget _buildCardDetailsForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Credit Card Preview
          _buildCardPreview(),
          const SizedBox(height: 30),

          // Scan Card Button
          _buildScanButton(),
          const SizedBox(height: 20),

          // Card Number Field
          _buildTextField(
            controller: _cardNumberController,
            label: 'Card Number',
            hintText: 'XXXX XXXX XXXX XXXX',
            keyboardType: TextInputType.number,
            formatter: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
              _CardNumberFormatter(),
            ],
          ),
          const SizedBox(height: 16),

          // Holder Name Field
          _buildTextField(
            controller: _holderNameController,
            label: 'Holder Name',
            hintText: 'John Doe',
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),

          // Expiry Date and CVV Row
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _expiryDateController,
                  label: 'Expiry Date',
                  hintText: 'MM/YY',
                  keyboardType: TextInputType.number,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    _ExpiryDateFormatter(),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  controller: _cvvController,
                  label: 'CVC/CVV',
                  hintText: 'XXX',
                  keyboardType: TextInputType.number,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Default Card Checkbox
          Row(
            children: [
              Text(
                'Set as default card',
                style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 14),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  checkboxTheme: CheckboxThemeData(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5), // apply border radius
                    ),
                    side: BorderSide(color: AppColor().darkCharcoalBlueColor, width: 1),
                  ),
                ),
                child: Checkbox(
                  value: _isDefaultCard,
                  onChanged: (value) {
                    setState(() {
                      _isDefaultCard = value ?? false;
                    });
                  },
                ),
              ),

            ],
          ),
          const SizedBox(height: 40),

          // Pay Now Button
          _buildPayButton(),
        ],
      ),
    );
  }

  Widget _buildCardPreview() {
    return Container(
      width: double.infinity,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF2E2E2E), Color(0xFF1A1A1A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Credit Card',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const Text(
                  'Bank Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Chip
            Container(
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 20),
            // Card Number
            Text(
              _cardNumberController.text.isEmpty
                  ? '1234 5678 9012 3456'
                  : _cardNumberController.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '0123',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            // const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _holderNameController.text.isEmpty
                      ? 'Name Surname'
                      : _holderNameController.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'VALID',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 8,
                      ),
                    ),
                    Text(
                      'THRU',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 8,
                      ),
                    ),
                    Text(
                      _expiryDateController.text.isEmpty
                          ? '01/80'
                          : _expiryDateController.text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScanButton() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor().darkCharcoalBlueColor, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _isLoading ? null : _showScanOptions,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: _isLoading
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt,
                  color: AppColor().darkCharcoalBlueColor,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  'Scan Credit Card',
                  style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 16),

        ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType? keyboardType,
    List<TextInputFormatter>? formatter,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 14),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          borderRadius: 12,
          borderWidth: 2,
          fillColor: AppColor().backgroundColor,
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: formatter,
          hintText: hintText,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().silverShadeGrayColor,size: 12),
          onChanged: (value){
            setState(() {
            });
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        )
      ],
    );
  }

  Widget _buildPayButton() {
    return CustomButton(
      width: double.infinity,
      height: 64,
      borderRadius: 48,
      onPressed: (){
        context.push(AppRoute.homeScreen);
      },
        text: "Save Card",
        textStyle: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkYellowColor,size: 16),
    );
  }
}

class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll(' ', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

// Custom formatter for expiry date
class _ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();

    for (int i = 0; i < text.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}
