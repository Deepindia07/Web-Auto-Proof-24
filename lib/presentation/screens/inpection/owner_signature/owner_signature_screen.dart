part of 'owner_signature_screen_route_imple.dart';

class OwnerSignatureScreen extends StatefulWidget {
  const OwnerSignatureScreen({super.key, required this.carDetailsModel});
  final CarDetailsModel carDetailsModel;

  @override
  State<OwnerSignatureScreen> createState() => _OwnerSignatureScreenState();
}

class _OwnerSignatureScreenState extends State<OwnerSignatureScreen> {
  String? formattedDateTime;
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    formattedDateTime = DateFormat("dd MMMM yyyy - h:mma").format(now);
    _signatureController.addListener(() {
      setState(() {
        _hasSignature = !_signatureController.isEmpty;
      });
    });
  }

  SignatureModel? _capturedSignature;
  final bool _isProcessing = false;
  bool _hasSignature = false;

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
            subTitle: formattedDateTime ?? 'Current time not available',
          ),

          vGap(12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Signature(
                              controller: _signatureController,
                              backgroundColor: Colors.white,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: _clearSignature,
                              child: Image.asset("assets/icon/ic_delete.png", height: 34, width: 34,)
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    local.directlyWithFinger,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          // Show processing indicator
                          if (_isProcessing)
                            Container(
                              color: Colors.black26,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          side: BorderSide.none,
                          onPressed: () {},
                          text: local.seeReport,
                          textStyle: MontserratStyles.montserratMediumTextStyle(
                            size: 14,
                            color: AppColor().darkYellowColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomButton(
                          side: BorderSide.none,
                          onPressed: () {
                            final bloc = context.read<ClientSignatureScreenBloc>();

                            bloc.add(
                              OnSubmittingInspectionDataEvent(
                                carDetails: widget.carDetailsModel.carDetails!,
                                ownerDetails: widget.carDetailsModel.ownerDetails!,
                                clientDetails: widget.carDetailsModel.clientDetails!,
                                carImages: {
                                  "front_side": {
                                    "before": widget.carDetailsModel.processedPhotos?.photos?.frontSide?.before ?? "",
                                  },
                                  "rear_side": {
                                    "before": widget.carDetailsModel.processedPhotos?.photos?.rearSide?.before ?? "",
                                  },
                                },
                                clientSignature: {
                                  "during_check_in_time": widget.carDetailsModel.processedPhotos?.signatures?.clientSignature?.duringCheckInTime ?? "",
                                },
                                ownerSignature: {
                                  "during_check_in_time": widget.carDetailsModel.processedPhotos?.signatures?.inspectorSignature?.duringCheckInTime ?? "",
                                },
                              ),
                            );
                          },
                          text: local.submitButton,
                          textStyle: MontserratStyles.montserratMediumTextStyle(
                            size: 14,
                            color: _hasSignature ? AppColor().darkYellowColor : Colors.grey,
                          ),
                        ),
                      )
                      // Expanded(
                      //   child: CustomButton(
                      //     side: BorderSide.none,
                      //     onPressed: _isProcessing ? null : () => _showValidationDialog(context),
                      //     text: local.validation,
                      //     textStyle: MontserratStyles.montserratMediumTextStyle(
                      //       size: 14,
                      //       color: AppColor().darkYellowColor,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          local.byPressingValidate,
                          style: MontserratStyles.montserratMediumTextStyle(
                            color: AppColor().darkCharcoalBlueColor,
                            size: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildBulletPoint(local.acceptTerms),
                        _buildBulletPoint(local.acceptPolicy),
                        _buildBulletPoint(local.confirmLegalSignature),
                        _buildBulletPoint(local.allowSignatureUsage),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4,
          height: 4,
          margin: const EdgeInsets.only(top: 6, right: 6),
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
              size: 13,
            ),
          ),
        ),
      ],
    ),
  );

  void _clearSignature() {
    setState(() {
      _signatureController.clear();
      _capturedSignature = null;
    });
  }

  void _showValidationDialog(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(local.validateSignature),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                Text(local.validateSignatureQuestion),
                SizedBox(height: 30,),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () => Navigator.of(context).pop(),
                        text: local.cancel,
                        side: BorderSide(color: AppColor().darkCharcoalBlueColor),
                        textColor: AppColor().darkYellowColor,
                        backgroundColor: AppColor().darkCharcoalBlueColor,
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: CustomButton(
                        side: BorderSide(color: AppColor().darkYellowColor),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await _validateSignature();
                        },
                        text:local.validate,
                        textColor: AppColor().darkCharcoalBlueColor,
                        backgroundColor: AppColor().darkYellowColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _validateSignature() async {
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
   // context.push(AppRoute.clientSignatureViewScreen, extra:  widget.carDetailsModel);
  }


  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }
}
