part of 'inspection_create_admin_screen_route_imple.dart';

class InspectionCreateAdminScreen extends StatelessWidget {
  const InspectionCreateAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InspectionCreateAdminScreenView();
  }
}

class InspectionCreateAdminScreenView extends StatefulWidget {
  const InspectionCreateAdminScreenView({super.key});

  @override
  State<InspectionCreateAdminScreenView> createState() => _InspectionCreateAdminScreenViewState();
}

class _InspectionCreateAdminScreenViewState extends State<InspectionCreateAdminScreenView> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _selectedCountryCode = '+33';
  final FocusNode _phoneNumberFocusNode = FocusNode();
  bool _isPhoneNumberFocused = false;
  final selectGenderType = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            backgroundColor: AppColor().backgroundColor,
              title: "Add Inspector"),
          Expanded(child: _buildPersonalInformationForm())
        ],
      ),
    );
  }

  Widget _buildPersonalInformationForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 15,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  hint: AppLocalizations.of(context)!.firstName,
                  label: AppLocalizations.of(context)!.firstName,
                  controller: _firstNameController,
                  validator: (value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return AppLocalizations.of(context)!.firstNameRequired;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _buildTextField(
                  hint: AppLocalizations.of(context)!.lastName,
                  label: AppLocalizations.of(context)!.lastName,
                  controller: _lastNameController,
                  validator: (value) {
                    if (value == null || value
                        .trim()
                        .isEmpty) {
                      return AppLocalizations.of(context)!.lastNameRequired;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),

          _buildTextField(
            label: AppLocalizations.of(context)!.email,
            hint: AppLocalizations.of(context)!.email,
            controller: _emailController,
            validator: (value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return AppLocalizations.of(context)!.emailRequired;
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(
                  value)) {
                return AppLocalizations.of(context)!.emailInvalid;
              }
              return null;
            },
          ),
          _buildTextField(
            prefix: CustomContainer(
              height: 50,
              width: 80,
              border: Border.all(
                width: 2,
                color: _isPhoneNumberFocused
                    ? AppColor().darkCharcoalBlueColor
                    : AppColor().silverShadeGrayColor,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8)
              ),
              backgroundColor: AppColor().backgroundColor,
              padding: EdgeInsets.all(8),
              child: CountryCodePicker(
                onChanged: (CountryCode countryCode) {
                  setState(() {
                    _selectedCountryCode = countryCode.toString();
                  });
                  print("Selected Country: ${countryCode.name}");
                  print("Selected Code: ${countryCode.dialCode}");
                },
                initialSelection: _selectedCountryCode
                    .replaceAll('+', '')
                    .isEmpty ? 'US' : null,
                favorite: ['+1', '+91', '+44'],
                showCountryOnly: true,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
                textStyle: TextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                  fontSize: 16,
                ),
                dialogTextStyle: TextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                ),
                searchStyle: TextStyle(
                  color: AppColor().darkCharcoalBlueColor,
                ),
                searchDecoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  hintText: AppLocalizations.of(context)!.searchCountry,
                  hintStyle: TextStyle(
                    color: AppColor().darkCharcoalBlueColor.withOpacity(0.6),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: AppColor().darkCharcoalBlueColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                        color: AppColor().darkCharcoalBlueColor),
                  ),
                ),
                dialogBackgroundColor: AppColor().backgroundColor,
                barrierColor: Colors.black54,
                dialogSize: Size(MediaQuery
                    .of(context)
                    .size
                    .width * 0.8,
                    MediaQuery
                        .of(context)
                        .size
                        .height * 0.6),
                builder: (countryCode) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (countryCode != null)
                        Image.asset(
                          countryCode.flagUri!,
                          package: 'country_code_picker',
                          width: 24,
                          height: 18,
                          fit: BoxFit.fill,
                        ),
                      hGap(5),
                      Text(
                        countryCode!.dialCode ?? '',
                        style: TextStyle(
                          color: AppColor().darkCharcoalBlueColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            label: AppLocalizations.of(context)!.phoneNumber,
            hint: AppLocalizations.of(context)!.phoneHint,
            controller: _phoneController,
            focusNode: _phoneNumberFocusNode,
            validator: (value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return AppLocalizations.of(context)!.phoneRequired;
              }
              if (value.length < 10) {
                return AppLocalizations.of(context)!.phoneInvalid;
              }
              return null;
            },
          ),

          _buildDropdownField(
              label: 'Select Gender',
              value: selectGenderType,
              dropValue: '',
              items: [
                RadioDropdownOption(value: "Male", label: "Male"),
                RadioDropdownOption(value: "Female", label: "Female"),
              ],
              onChanged: (String? value) =>
                  setState(() => selectGenderType == value),
              isRequired: true
          ),
          _buildTextField(
            label: AppLocalizations.of(context)!.address,
            hint: AppLocalizations.of(context)!.addressHint,
            controller: _addressController,
            validator: (value) {
              if (value == null || value
                  .trim()
                  .isEmpty) {
                return AppLocalizations.of(context)!.addressHint;
              }
              return null;
            },
          ),
          vGap(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButtonView(onTap: () {}, text: "Cancel"),
              _buildButtonView(onTap: () {}, text: "Create")
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    Widget? prefix,
    FocusNode? focusNode,
    String? Function(String?)? validator,
  }) {
    return CustomTextField(
      controller: controller,
      focusNode: focusNode,
      labelText: "$label *",
      labelStyle: MontserratStyles.montserratSemiBoldTextStyle(
          color: AppColor().darkCharcoalBlueColor, size: 14),
      hintText: hint,
      hintStyle:  MontserratStyles.montserratSemiBoldTextStyle(
          color: AppColor().silverShadeGrayColor, size: 14),
      prefixIcon: prefix,
      fillColor: AppColor().backgroundColor,
      filled: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildButtonView({
    required VoidCallback? onTap,
    required String? text
}){
    return CustomButton(
      padding: EdgeInsets.symmetric(horizontal: 60),
      onPressed: onTap,
        text: text!);
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required String dropValue,
    required List<RadioDropdownOption> items,
    required ValueChanged<String?> onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                  color: AppColor().darkCharcoalBlueColor, size: 14),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        SizedBox(height: 8),
        RadioDropdownField(
          value: value,
          options: items,
          onChanged: (value){
            setState(() {
              value = value;
            });
          },
        )
        // DropdownButtonFormField<String>(
        //   value: value,
        //   onChanged: onChanged,
        //   items: items.map((String item) {
        //     return DropdownMenuItem<String>(
        //       value: item,
        //       child: Text(item),
        //     );
        //   }).toList(),
        //   decoration: InputDecoration(
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(8),
        //       borderSide: BorderSide(color: Colors.grey[300]!),
        //     ),
        //     enabledBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(8),
        //       borderSide: BorderSide(color: Colors.grey[300]!),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(8),
        //       borderSide: BorderSide(color: Colors.blue),
        //     ),
        //     contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //   ),
        // ),
      ],
    );
  }
}


