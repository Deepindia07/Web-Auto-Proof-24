part of 'company_screen_route_imple.dart';

class CompanyInfoScreen extends StatefulWidget {
  const CompanyInfoScreen({super.key});

  @override
  State<CompanyInfoScreen> createState() => _CompanyInfoScreenState();
}

class _CompanyInfoScreenState extends State<CompanyInfoScreen> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController vatNumberController = TextEditingController();
  TextEditingController registrationNoController = TextEditingController();
  TextEditingController shareController = TextEditingController();
  TextEditingController webSiteController = TextEditingController();
  TextEditingController termController = TextEditingController();
  TextEditingController privacyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Uint8List? _imageBytes;
  String? _imageBase64;
  GetCompanyModel? getCompanyModel;
  @override
  void initState() {
    context.read<CreateCompanyBloc>().add(GetCompanyApiEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40),
          child: Container(
            padding: const EdgeInsets.all(32),
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(),
            child: Form(
              key: _formKey,
              child: BlocConsumer<CreateCompanyBloc, CreateCompanyState>(
                listener: (context, state) {
                  if (state is GetCompanySuccess) {
                    getCompanyModel = state.getCompanyModel;
                    getModelData(
                      getCompanyModel: getCompanyModel ?? GetCompanyModel(),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "My Company Information",
                        style: MontserratStyles.montserratSemiBoldTextStyle(
                          size: 30,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Company Logo",
                                  style:
                                      MontserratStyles.montserratSemiBoldTextStyle(
                                        size: 15,
                                        color: AppColor().darkCharcoalBlueColor,
                                      ),
                                ),
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: Container(
                                    width: ResponsiveSizes(context).screenWidth,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black45),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: _imageBase64 != null
                                        ? Container(
                                            width: ResponsiveSizes(
                                              context,
                                            ).screenWidth,
                                            padding: EdgeInsets.all(5),
                                            child: Image.network(
                                              "data:image/png;base64,$_imageBase64",
                                            ),
                                          )
                                        : Center(
                                            child: Icon(
                                              Icons.cloud_upload_outlined,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      CustomTextField(
                        hintText: "Company Name",
                        labelText: "Company Name",
                        controller: companyNameController,
                        validator: InputValidators.validateCompanyName,
                      ),
                      vGap(10),
                      CustomTextField(
                        hintText: "VAT Number",
                        labelText: "VAT Number",
                        controller: vatNumberController,
                        validator: InputValidators.validateVAT,
                      ),
                      vGap(10),
                      CustomTextField(
                        hintText: "Company Registration No.",
                        labelText: "Company Registration No.",
                        controller: registrationNoController,
                        validator: InputValidators.validateCompanyRegNumber,
                      ),
                      vGap(10),
                      CustomTextField(
                        hintText: "Share Capital",
                        labelText: "Share Capital",
                        controller: shareController,
                      ),
                      vGap(10),

                      CustomTextField(
                        hintText: "https://www.",
                        labelText: "Website",
                        controller: webSiteController,
                      ),
                      vGap(10),
                      CustomTextField(
                        hintText: "https://www.",
                        labelText: "Term & Condition",
                        controller: termController,
                      ),
                      vGap(10),
                      CustomTextField(
                        hintText: "https://www.",
                        labelText: "Privacy Policy",
                        controller: privacyController,
                      ),

                      const SizedBox(height: 24),
                      // ---- Buttons
                      Row(
                        children: [
                          Expanded(
                            child:
                                BlocConsumer<
                                  CreateCompanyBloc,
                                  CreateCompanyState
                                >(
                                  listener: (context, state) {
                                    if (state is CreateCompanySuccess) {
                                      CherryToast.success(
                                        context,""
                                    /*    AppLocalizations.of(
                                          context,
                                        )!.companyInformationSuccessfully,*/
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomButtonWeb(
                                      isLoading: (state is CreateCompanyLoading)
                                          ? true
                                          : false,
                                      text: "Save",
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          context.read<CreateCompanyBloc>().add(
                                            CreateCompanyApiEvent(
                                              body: {
                                                "companyName":
                                                    companyNameController.text
                                                        .trim()
                                                        .toString(),
                                                "website": webSiteController
                                                    .text
                                                    .trim()
                                                    .toString(),
                                                "VatNumber": vatNumberController
                                                    .text
                                                    .trim()
                                                    .toString(),
                                                "companyLogo": "https://fastly.picsum.photos/id/866/500/300.jpg?hmac=gTBX2xIXKy_WSASp2ITBfmK7WFeBZyiuIumiEUmowcw",
                                                "companyRegistrationNumber":
                                                    registrationNoController
                                                        .text
                                                        .trim()
                                                        .toString(),
                                                "shareCapital": int.tryParse(
                                                  shareController.text
                                                      .trim()
                                                      .toString(),
                                                ),
                                                "termAndConditions":
                                                    termController.text
                                                        .trim()
                                                        .toString(),
                                                "companyPolicy":
                                                    privacyController.text
                                                        .trim()
                                                        .toString(),
                                              },
                                            ),
                                          );
                                        }
                                      },
                                      color: AppColor().darkCharcoalBlueColor,
                                      textColor: AppColor().yellowWarmColor,
                                      borderRadius: 30,
                                    );
                                  },
                                ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      final html.FileUploadInputElement input = html.FileUploadInputElement();
      input.accept = 'image/*';
      input.click();
      input.onChange.listen((event) {
        final files = input.files;
        if (files != null && files.isNotEmpty) {
          final reader = html.FileReader();
          reader.readAsArrayBuffer(files[0]);
          reader.onLoadEnd.listen((event) {
            setState(() {
              _imageBytes = reader.result as Uint8List;
              _imageBase64 = base64Encode(_imageBytes!);
            });
          });
        }
      });
    } else {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _imageBytes = result.files.first.bytes;
          _imageBase64 = base64Encode(_imageBytes!);
        });
      }
    }
  }

  void getModelData({required GetCompanyModel getCompanyModel}) {
    companyNameController.text = getCompanyModel.companyName ?? "";
    vatNumberController.text = getCompanyModel.vatNumber ?? "";
    registrationNoController.text =
        getCompanyModel.companyRegistrationNumber ?? "";
    shareController.text = getCompanyModel.shareCapital ?? "";
    webSiteController.text = getCompanyModel.website ?? "";
    termController.text = getCompanyModel.termAndConditions ?? "";
    privacyController.text = getCompanyModel.privacyPolicy ?? "";
  }
}
