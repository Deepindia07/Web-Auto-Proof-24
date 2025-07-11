
part of 'client_signature_screen_route_imple.dart';

class ClientSignatureScreen extends StatelessWidget {
  const ClientSignatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=> ClientSignatureScreenBloc(),
        child: ClientSignatureScreenView() ,);
  }
}

class ClientSignatureScreenView extends StatefulWidget {
  const ClientSignatureScreenView({super.key});

  @override
  State<ClientSignatureScreenView> createState() => _ClientSignatureScreenViewState();
}

class _ClientSignatureScreenViewState extends State<ClientSignatureScreenView> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: "Client Signature",
            subTitle: "01 January 2025 - 9:00PM",
          ),

          vGap(20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Signature Canvas
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Signature pad
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Signature(
                              controller: _signatureController,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          // Delete icon - positioned at top right corner
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                _clearSignature();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.red.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red.shade700,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          // Placeholder text when empty
                          if (_signatureController.isEmpty)
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign Here',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Directly with your finger',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          side: BorderSide.none,
                          onPressed: (){},
                          text: "See Report",
                          textStyle: MontserratStyles.montserratMediumTextStyle(size: 16,color: AppColor().darkYellowColor),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                          child: CustomButton(
                            side: BorderSide.none,
                            onPressed: (){
                              _showValidationDialog(context);
                            },
                            text: "Validation",
                            textStyle: MontserratStyles.montserratMediumTextStyle(size: 16,color: AppColor().darkYellowColor),
                          )
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Terms and conditions
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'By Pressing "Validate" :',
                          style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 16),
                        ),
                        const SizedBox(height: 12),
                        _buildBulletPoint('I accept the terms and conditions of Auto Proof.'),
                        _buildBulletPoint('I accept the data protection policy.'),
                        _buildBulletPoint('I confirm that the signature is legally valid and has the same value as a handwritten signature.'),
                        _buildBulletPoint('This signature may be used by me (or my authorized representative) on the vehicle inspection report.'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 4,
            margin: const EdgeInsets.only(top: 8, right: 8),
            decoration: const BoxDecoration(
              color: Colors.black87,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: MontserratStyles.montserratRegularTextStyle(color: AppColor().darkCharcoalBlueColor,size: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _clearSignature() {
    setState(() {
      _signatureController.clear();
    });
  }

  void _showValidationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Validate Signature'),
          content: const Text('Are you sure you want to validate this signature?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AppRoute.clientSignatureViewScreen);
                // Navigator.of(context).pop();
                // // Handle signature validation
                // // _validateSignature();
              },
              child: const Text('Validate'),
            ),
          ],
        );
      },
    );
  }

  void _validateSignature() {
    if (_signatureController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please provide a signature before validating'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Add your signature validation logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Signature validated successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }
}