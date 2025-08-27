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
  bool _isPicking = false;
  String? _imageBase64;
  String? previewBase64;
  GetCompanyModel? getCompanyModel;

  String? _fileName;
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

                                ///-------company logo----------------
                                GestureDetector(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: Container(
                                    width: ResponsiveSizes(context).screenWidth,
                                    height:
                                        80, // ⬅️ increased so image is visible
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black45),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: _imageBytes != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.memory(
                                              _imageBytes!,
                                              fit: BoxFit
                                                  .cover, // ⬅️ scales image nicely
                                              width: double
                                                  .infinity, // ⬅️ expand full width
                                              height: double
                                                  .infinity, // ⬅️ expand full height
                                            ),
                                          )
                                        : Center(
                                            child: Icon(
                                              Icons.cloud_upload_outlined,
                                            ),
                                          ),
                                  ),
                                ),
                                ///// back up -------------
                                /* GestureDetector(
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
                                    child: _imageBytes != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.memory(
                                              _imageBytes!,
                                              height: 200,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Center(
                                            child: Icon(
                                              Icons.cloud_upload_outlined,
                                            ),
                                          ),
                                  ),
                                ),*/
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
                                        context,
                                        AppLocalizations.of(
                                          context,
                                        )!.companyInformationSuccessfully,
                                      );
                                    }
                                    if (state is CreateCompanyError) {
                                      CherryToast.error(context, state.error);
                                    }
                                  },
                                  builder: (context, state) {
                                    return CustomButtonWeb(
                                      isLoading: (state is CreateCompanyLoading)
                                          ? true
                                          : false,
                                      text:
                                          (getCompanyModel == null ||
                                              getCompanyModel!.companyId ==
                                                  null)
                                          ? "Save"
                                          : "Update",
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (getCompanyModel == null ||
                                              getCompanyModel?.companyId ==
                                                  null) {
                                            // 👉 CREATE
                                            context.read<CreateCompanyBloc>().add(
                                              CreateCompanyApiEvent(
                                                body: {
                                                  "companyName":
                                                      companyNameController.text
                                                          .trim(),
                                                  "website": webSiteController
                                                      .text
                                                      .trim(),
                                                  "VatNumber":
                                                      vatNumberController.text
                                                          .trim(),
                                                  "companyLogo": previewBase64,
                                                  "companyRegistrationNumber":
                                                      registrationNoController
                                                          .text
                                                          .trim(),
                                                  "shareCapital": int.tryParse(
                                                    shareController.text.trim(),
                                                  ),
                                                  "termAndConditions":
                                                      termController.text
                                                          .trim(),
                                                  "privacyPolicy":
                                                      privacyController.text
                                                          .trim(),
                                                },
                                              ),
                                            );
                                          } else {
                                            // 👉 UPDATE
                                            context.read<CreateCompanyBloc>().add(
                                              UpdateCompanyApiEvent(
                                                body: {
                                                  "companyName":
                                                      companyNameController.text
                                                          .trim(),
                                                  "website": webSiteController
                                                      .text
                                                      .trim(),
                                                  "VatNumber":
                                                      vatNumberController.text
                                                          .trim(),
                                                  "companyLogo": previewBase64,
                                                  "companyRegistrationNumber":
                                                      registrationNoController
                                                          .text
                                                          .trim(),
                                                  "shareCapital": int.tryParse(
                                                    shareController.text.trim(),
                                                  ),

                                                  "termAndConditions":
                                                      termController.text
                                                          .trim(),
                                                  "privacyPolicy":
                                                      privacyController.text
                                                          .trim(),
                                                },
                                              ),
                                            );
                                          }
                                        }
                                      },

                                      color: AppColor().darkCharcoalBlueColor,
                                      textColor: AppColor().yellowWarmColor,
                                      borderRadius: 7,
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

  Future<Uint8List> compressImage(Uint8List inputBytes) async {
    final image = img.decodeImage(inputBytes);
    if (image == null) return inputBytes;
    final resized = img.copyResize(image, width: 800);
    final compressed = img.encodeJpg(resized, quality: 70);
    return Uint8List.fromList(compressed);
  }

  Future<void> _pickImage() async {
    if (_isPicking) return; // ✅ Prevent multiple triggers
    _isPicking = true;

    try {
      Uint8List? bytes = await ImagePickerWeb.getImageAsBytes();
      final info = await ImagePickerWeb.getImageInfo();
      String? name = info?.fileName;

      if (bytes != null) {
        Uint8List compressed = await compressImage(bytes);
        String base64Full = base64Encode(compressed);

        setState(() {
          _imageBytes = compressed;
          _fileName = name ?? "image.jpg";
          _imageBase64 = base64Full;
        });

        // ✅ Print only first & last 50 chars for readability
        if (base64Full.length > 100) {
          previewBase64 =
              "${base64Full.substring(0, 50)}...${base64Full.substring(base64Full.length - 50)}";

          debugPrint("_imageBytes length: ${_imageBytes!.lengthInBytes} bytes");
          debugPrint("_fileName: $_fileName");
          debugPrint("_imageBase64 (preview): $previewBase64");
        } else {
          debugPrint("_imageBase64: $base64Full");
        }
      }
    } catch (e) {
      debugPrint("Image picking failed: $e");
    } finally {
      _isPicking = false; // ✅ Allow again
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
