part of 'personal_information_route_imple.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? selectedGender;
  String? selectDialCode;

  @override
  void initState() {
    context.read<PersonalInformationBloc>().add(GetPersonalInfoApiEvent());
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
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context)
                  ? screenWidth / 6
                  : Responsive.isTablet(context)
                  ? 40
                  : 16,
              vertical: Responsive.isDesktop(context) ? 60 : 30,
            ),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: AppColor().backgroundColor,
                borderRadius: BorderRadius.circular(20),
                /*  boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],*/
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Responsive.isDesktop(context) ? 800 : 600,
                ),
                child: BlocConsumer<PersonalInformationBloc, PersonalInformationState>(
                  listener: (context, state) {
                    if (state is GetPersonalInfoSuccess) {
                      final user = state.userProfile;

                      setState(() {
                        firstNameController.text = user.user?.firstName ?? "";
                        lastNameController.text = user.user?.lastName ?? "";
                        emailNameController.text = user.user?.email ?? "";
                        phoneNumberController.text =
                            user.user?.phoneNumber ?? "";
                        addressController.text = user.user?.address ?? "";
                        selectedGender = user.user?.gender ?? "";
                        selectDialCode = user.user?.countryCode ?? "";
                      });
                      print(
                        "object-----${firstNameController.text.trim().toString()}",
                      );
                    }

                    if (state is GetPersonalInfoError) {
                      CherryToast.error(context, state.error);
                    }
                  },
                  builder: (context, state) {
                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'My personal information',
                            textAlign: TextAlign.center,
                            style: MontserratStyles.montserratSemiBoldTextStyle(
                              size: Responsive.isDesktop(context) ? 30 :20,
                              color: AppColor().darkCharcoalBlueColor,
                            ),
                          ),
                          const SizedBox(height: 24),

                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  borderWidth: 2,
                                  borderColor: AppColor().darkCharcoalBlueColor,
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
                                  borderWidth: 2,
                                  borderColor: AppColor().darkCharcoalBlueColor,
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
                            borderWidth: 2,
                            borderColor: AppColor().darkCharcoalBlueColor,
                            validator: InputValidators.validateEmail,
                            controller: emailNameController,
                            hintStyle:
                                MontserratStyles.montserratRegularTextStyle(
                                  size: 15,
                                  color: AppColor().silverShadeGrayColor,
                                ),
                            hintText: "Email ID",
                            labelText: "Email ID",
                          ),
                          const SizedBox(height: 16),
                          /* CustomTextField(
                        validator: InputValidators.validatePhoneNumber,
                        controller: phoneNumberController,
                        hintStyle: MontserratStyles.montserratRegularTextStyle(
                          size: 15,
                          color: AppColor().silverShadeGrayColor,
                        ),
                        hintText: "Phone Number",
                        labelText: "Phone Number",
                      ),*/
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Phone Number",
                              style:
                                  MontserratStyles.montserratSemiBoldTextStyle(
                                    size: 15,
                                    color: AppColor().darkCharcoalBlueColor,
                                  ),
                            ),
                          ),
                          PhoneNumberField(
                            initialCountryCode: selectDialCode ?? "+33",
                            color: Colors.transparent,
                            borderRadiusGeometry: BorderRadius.only(),
                            borderRadius: 10,
                            onChanged: (countryCode) {
                              log("Country: ${countryCode.name}");
                              log("Code: ${countryCode.dialCode}");
                              selectDialCode = countryCode.dialCode;
                              log(
                                "Code: ${countryCode.dialCode}-----$selectDialCode",
                              );
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
                            borderWidth: 2,
                            borderColor: AppColor().darkCharcoalBlueColor,
                            validator: InputValidators.validateAddress,
                            controller: addressController,
                            maxLines: 4,
                            hintStyle:
                                MontserratStyles.montserratRegularTextStyle(
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
                                child:
                                    BlocListener<
                                      PersonalInformationBloc,
                                      PersonalInformationState
                                    >(
                                      listener: (context, state) {
                                        if (state
                                            is PersonalInformationSuccess) {
                                          CherryToast.success(
                                            context,
                                            "Personal profile updated.",
                                          );
                                          context
                                              .read<PersonalInformationBloc>()
                                              .add(GetPersonalInfoApiEvent());
                                        }
                                      },
                                      child: CustomButtonWeb(
                                        text: 'Update',
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            print(
                                              "object-----${firstNameController.text.trim().toString()}",
                                            );
                                            ProfileModel profile = ProfileModel(
                                              userType: "individual",
                                              firstName: firstNameController
                                                  .text
                                                  .trim()
                                                  .toString(),
                                              lastName: lastNameController.text
                                                  .trim()
                                                  .toString(),
                                              email: emailNameController.text
                                                  .trim()
                                                  .toString(),
                                              phoneNumber: phoneNumberController
                                                  .text
                                                  .trim()
                                                  .toString(),
                                              countryCode: selectDialCode ?? "",
                                              /*    profileImage: firstNameController.text
                                              .trim()
                                              .toString(),*/
                                              address: addressController.text
                                                  .trim()
                                                  .toString(),
                                              rememberSettings: false,
                                              gender: selectedGender ?? "",
                                            );

                                            context
                                                .read<PersonalInformationBloc>()
                                                .add(
                                                  UpdateProfileEvent(
                                                    profile: profile,
                                                  ),
                                                );
                                          }
                                        },
                                        color: AppColor().darkCharcoalBlueColor,
                                        textColor: AppColor().yellowWarmColor,
                                        borderRadius: 10,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
