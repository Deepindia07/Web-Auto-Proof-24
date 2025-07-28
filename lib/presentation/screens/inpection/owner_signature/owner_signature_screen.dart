part of 'owner_signature_screen_route_imple.dart';

class OwnerSignatureScreen extends StatefulWidget {
  const OwnerSignatureScreen({super.key});

  @override
  State<OwnerSignatureScreen> createState() =>
      _OwnerSignatureScreenState();
}

class _OwnerSignatureScreenState extends State<OwnerSignatureScreen> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
            title: local.ownerSignature,
            subTitle: "01 January 2025 - 9:00PM", // Date can be formatted dynamically if required
          ),

          vGap(20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Signature(
                              controller: _signatureController,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: _clearSignature,
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
                          if (_signatureController.isEmpty)
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    local.signHere,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    local.directlyWithFinger,
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
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          side: BorderSide.none,
                          onPressed: () {},
                          text: local.seeReport,
                          textStyle: MontserratStyles.montserratMediumTextStyle(
                            size: 16,
                            color: AppColor().darkYellowColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomButton(
                          side: BorderSide.none,
                          onPressed: () => _showValidationDialog(context),
                          text: local.validation,
                          textStyle: MontserratStyles.montserratMediumTextStyle(
                            size: 16,
                            color: AppColor().darkYellowColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
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
                          local.byPressingValidate,
                          style: MontserratStyles.montserratMediumTextStyle(
                            color: AppColor().darkCharcoalBlueColor,
                            size: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildBulletPoint(local.acceptTerms),
                        _buildBulletPoint(local.acceptPolicy),
                        _buildBulletPoint(local.confirmLegalSignature),
                        _buildBulletPoint(local.allowSignatureUsage),
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

  Widget _buildBulletPoint(String text) => Padding(
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
            style: MontserratStyles.montserratRegularTextStyle(
              color: AppColor().darkCharcoalBlueColor,
              size: 14,
            ),
          ),
        ),
      ],
    ),
  );

  void _clearSignature() {
    setState(() => _signatureController.clear());
  }

  void _showValidationDialog(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(local.validateSignature),
          content: Text(local.validateSignatureQuestion),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(local.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AppRoute.clientSignatureViewScreen);
              },
              child: Text(local.validate),
            ),
          ],
        );
      },
    );
  }

  void _validateSignature() {
    final local = AppLocalizations.of(context)!;
    if (_signatureController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(local.provideSignatureError),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(local.signatureValidated),
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
