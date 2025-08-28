part of 'client_signature_screen_route_imple.dart';

class ClientSignatureScreen extends StatelessWidget {
  const ClientSignatureScreen({super.key, required this.carDetailsModel});

  final CarDetailsModel carDetailsModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ClientSignatureScreenBloc>(
      create: (context)=> ClientSignatureScreenBloc(
          authenticationApiCall: AuthenticationApiCall()
      )..add(OnSubmittingInspectionDataEvent(
        carDetails: carDetailsModel.carDetails,
        ownerDetails: carDetailsModel.ownerDetails,
        clientDetails: carDetailsModel.clientDetails
      )),
      child: Builder(
        builder: (context) {
          return ClientSignatureScreenView(carDetailsModel: carDetailsModel,);
        },
      ),
    );
  }
}

class ClientSignatureScreenView extends StatefulWidget {
  const ClientSignatureScreenView({
    super.key, required this.carDetailsModel,
  });

  final CarDetailsModel carDetailsModel;

  @override
  State<ClientSignatureScreenView> createState() => _ClientSignatureScreenViewState();
}

class _ClientSignatureScreenViewState extends State<ClientSignatureScreenView> {
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  bool _hasSignature = false;
  final bool _isProcessing = false;
  String? formattedDateTime;

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

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final carDetails = widget.carDetailsModel;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: BlocConsumer<ClientSignatureScreenBloc, ClientSignatureScreenState>(
        listener: (context, state) {
          if (state is ClientSignatureScreenError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is ClientSignatureScreenSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Signature saved successfully'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ClientSignatureScreenValidated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(local.signatureValidated),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is OnSubmittingInspectionDataLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Inspection data submitted successfully'),
                backgroundColor: Colors.green,
              ),
            );
            context.go(AppRoute.homeScreen);
          } else if (state is OnSubmittingInspectionDataLoadedError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to submit: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final client = carDetails.clientDetails;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                backgroundColor: AppColor().backgroundColor,
                title: local.clientSignature,
                subTitle: formattedDateTime ?? 'Current time not available',
              ),
              vGap(12),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      // Signature Canvas
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
                              // Clear button
                              Positioned(
                                bottom: 6,
                                right: 6,
                                child: GestureDetector(
                                  onTap: _clearSignature,
                                  child: Image.asset("assets/icon/ic_delete.png", height: 34, width: 34,)
                                ),
                              ),
                              // Save button (when signature exists)
                              // if (_hasSignature)
                              //   Positioned(
                              //     bottom: 6,
                              //     right: 50,
                              //     child: GestureDetector(
                              //       onTap: _saveSignature,
                              //       child: Container(
                              //         padding: const EdgeInsets.all(6),
                              //         decoration: BoxDecoration(
                              //           color: Colors.green.shade100,
                              //           shape: BoxShape.circle,
                              //           border: Border.all(
                              //             color: Colors.green.shade300,
                              //             width: 1,
                              //           ),
                              //         ),
                              //         child: Icon(
                              //           Icons.save_outlined,
                              //           color: Colors.green.shade700,
                              //           size: 18,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // // Placeholder text
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
                              // Loading overlay
                              if (state is ClientSignatureScreenLoading)
                                Container(
                                  color: Colors.white.withOpacity(0.8),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              side: BorderSide.none,
                              onPressed: () {
                                // Show report or navigate to report screen
                                _showReportDialog();
                              },
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
                              onPressed: _isProcessing ? null : () => _showValidationDialog(context),
                              text: local.validation,
                              textStyle: MontserratStyles.montserratMediumTextStyle(
                                size: 14,
                                color: AppColor().darkYellowColor,
                              ),
                            ),
                          ),


                        ],
                      ),
                      const SizedBox(height: 12),

                      // Terms and Conditions
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
          );
        },
      ),
    );
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
    context.push(AppRoute.ownerSignatureViewScreen, extra:  widget.carDetailsModel);
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
    setState(() => _signatureController.clear());
    context.read<ClientSignatureScreenBloc>().add(ClearSignatureEvent());
  }

  void _saveSignature() {
    if (!_signatureController.isEmpty) {
    }
  }

  void _submitInspectionData() {
    context.read<ClientSignatureScreenBloc>().add(OnSubmittingInspectionDataEvent());
    context.go(AppRoute.homeScreen);
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Inspection Report'),
          content: Text('Here you can view the complete inspection report with all details.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }
}