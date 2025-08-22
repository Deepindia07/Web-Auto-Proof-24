part of "team_screen_route_imple.dart";

class AddInspectorScreen extends StatefulWidget {
  final String companyId;  // 👈 add this

  const AddInspectorScreen({super.key, required this.companyId});

  @override
  State<AddInspectorScreen> createState() => _AddInspectorScreenState();
}

class _AddInspectorScreenState extends State<AddInspectorScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedGender;
  String? selectDialCode;
  String? adminId;

  @override
  void initState() {

    adminId = SharedPrefsHelper.instance.getString(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1000;
          final isTall = constraints.maxHeight >= 700;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 100 : 30),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColor().backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Add Inspector',
                        textAlign: TextAlign.center,
                        style: MontserratStyles.montserratSemiBoldTextStyle(
                          size: 30,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: firstNameController,
                              validator: InputValidators.validateFirstName,
                              hintText: "First Name",
                              labelText: "First Name",
                              hintStyle:
                                  MontserratStyles.montserratRegularTextStyle(
                                    size: 15,
                                    color: AppColor().silverShadeGrayColor,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              validator: InputValidators.validateLastName,
                              controller: lastNameController,
                              hintStyle:
                                  MontserratStyles.montserratRegularTextStyle(
                                    size: 15,
                                    color: AppColor().silverShadeGrayColor,
                                  ),
                              hintText: "Last Name",
                              labelText: "Last Name",
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      CustomTextField(
                        validator: InputValidators.validateEmail,
                        controller: emailNameController,
                        hintStyle: MontserratStyles.montserratRegularTextStyle(
                          size: 15,
                          color: AppColor().silverShadeGrayColor,
                        ),
                        hintText: "Email ID",
                        labelText: "Email ID",
                      ),
                      const SizedBox(height: 16),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Phone Number",
                          style: MontserratStyles.montserratSemiBoldTextStyle(
                            size: 15,
                            color: AppColor().darkCharcoalBlueColor,
                          ),
                        ),
                      ),
                      PhoneNumberField(
                        color: Colors.transparent,
                        borderRadiusGeometry: BorderRadius.only(),
                        borderRadius: 10,
                        onChanged: (countryCode) {
                          selectDialCode = countryCode.dialCode;
                        },
                        controller: phoneNumberController,
                        isVerified: false,
                        onVerify: () {},
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropdownNew(
                              items: ['Male', 'Female'],
                              title: 'Gender',
                              hint: 'Select Gender',
                              value: selectedGender,
                              width: screenWidth,
                              onChanged: (val) =>
                                  setState(() => selectedGender = val),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        validator: InputValidators.validateAddress,
                        controller: addressController,
                        maxLines: 4,
                        hintStyle: MontserratStyles.montserratRegularTextStyle(
                          size: 15,
                          color: AppColor().silverShadeGrayColor,
                        ),
                        hintText: "Enter Address",
                        labelText: "Address",
                      ),

                      vGap(10),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButtonWeb(
                              text: 'Create',
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<InspectorCreateAdminBloc>().add(
                                    CreateInspectorEvent(
                                      body: {
                                        "firstName": firstNameController.text
                                            .trim()
                                            .toString(),
                                        "lastName": lastNameController.text
                                            .trim()
                                            .toString(),
                                        "email": emailNameController.text
                                            .trim()
                                            .toString(),
                                        "phoneNumber": phoneNumberController
                                            .text
                                            .trim()
                                            .toString(),
                                        "countryCode": selectDialCode ?? "",
                                        "address": addressController.text
                                            .trim()
                                            .toString(),
                                        "companyId":
                                            widget.companyId,
                                      },
                                      adminID: adminId ?? "",
                                    ),
                                  );
                                }
                              },
                              color: AppColor().darkCharcoalBlueColor,
                              textColor: AppColor().yellowWarmColor,
                              borderRadius: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> callWelcomeApi() async {
    try {
      var dio = Dio();

      final response = await dio.get("https://192.168.1.1:3002/api/welcome");

      if (response.statusCode == 200) {
        print("✅ Success: ${json.encode(response.statusCode)}");
        print("✅ Message: ${json.encode(response.statusMessage)}");
        print("✅ Data: ${response.data}");
      } else {
        print("❌ Error: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      print("🚨 Dio Error: ${e.response?.data ?? e.message}");
    } catch (e) {
      print("🚨 Unexpected Error: $e");
    }
  }
}
