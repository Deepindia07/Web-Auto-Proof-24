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
  String? apiGender = "MALE";
  final genderItems = const ['Male', 'Female'];

  @override
  void initState() {
    context.read<PersonalInformationBloc>().add(GetPersonalInfoApiEvent());


    super.initState();
  }

  // normalize API or backend values (like MALE/FEMALE) to UI values
  /*  String? normalizeGender(String? value) {

      if (value == null) return null;
      switch (value.toLowerCase()) {
        case "male":
          return "MALE";
        case "female":
          return "FEMALE";
        default:
          return null;
      }


  }*/
  String? normalizeGender(String? value) {
    if (value == null) return null;
    switch (value.toUpperCase()) {
      case "MALE":
        return "Male";   // ✅ Matches dropdown items
      case "FEMALE":
        return "Female";
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // extra safety: if selectedGender is not in items, reset to null
    if (selectedGender != null && !genderItems.contains(selectedGender)) {
      selectedGender = null;
    }
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1000;
          final isTall = constraints.maxHeight >= 700;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context)
                  ? screenWidth / 10
                  : Responsive.isTablet(context)
                  ? 30
                  : 16,
              vertical: Responsive.isDesktop(context) ? 20 : 30,
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
              child: BlocConsumer<PersonalInformationBloc, PersonalInformationState>(
                listener: (context, state) {
                  if (state is GetPersonalInfoLoading) {
                    CustomLoader.showPopupLoader(context);
                  }
                  if (state is GetPersonalInfoError) {
                    CustomLoader.hidePopupLoader(context);
                  }
                  if (state is GetPersonalInfoSuccess) {
                    CustomLoader.hidePopupLoader(context);
                    final user = state.userProfile;

                    setState(() {
                      firstNameController.text = user.user?.firstName ?? "";
                      lastNameController.text = user.user?.lastName ?? "";
                      emailNameController.text = user.user?.email ?? "";
                      phoneNumberController.text = user.user?.phoneNumber ?? "";
                      addressController.text = user.user?.address ?? "";
                      selectedGender = normalizeGender(user.user?.gender);
                      selectDialCode = user.user?.countryCode ?? "";
                    });
                    print(
                      "object-     --selectedGender-----$selectedGender--${firstNameController.text.trim().toString()}",
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'My personal information',
                          textAlign: TextAlign.center,
                          style: MontserratStyles.montserratSemiBoldTextStyle(
                            size: Responsive.isDesktop(context) ? 30 : 20,
                            color: AppColor().darkCharcoalBlueColor,
                          ),
                        ),
                        const SizedBox(height: 24),

                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                borderWidth: 1,
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
                                borderWidth: 1,
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
                          borderWidth: 1,
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
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
                                items: genderItems,
                                title: 'Gender',
                                hint: 'Select Gender',
                                value: selectedGender,
                                onChanged: (val) {
                                  setState(() => selectedGender = val);
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                        CustomTextField(
                          borderWidth: 1,
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
                                      if (state is PersonalInformationSuccess) {
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
                                        if (_formKey.currentState!.validate()) {
                                          ProfileModel profile = ProfileModel(
                                            userType: "individual",
                                            firstName: firstNameController.text
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
                                           gender: (selectedGender ?? "").toUpperCase(),
                                          );
                                          print(
                                            "object-${profile.gender}----${firstNameController.text.trim().toString()}---${(selectedGender ?? "").toUpperCase()}",
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
                                      borderRadius: 7,
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
          );
        },
      ),
    );
  }
}
