part of 'owner_details_screen_route_imple.dart';

class OwnerDetailsScreen extends StatelessWidget {
  const OwnerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OwnerDetailsScreenBloc(),
      child: OwnerDetailsScreenView(),
    );
  }
}

class OwnerDetailsScreenView extends StatefulWidget {
  const OwnerDetailsScreenView({super.key});

  @override
  State<OwnerDetailsScreenView> createState() => _OwnerDetailsScreenViewState();
}

class _OwnerDetailsScreenViewState extends State<OwnerDetailsScreenView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose(){
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          child: _buildInformationSection(),
        ),
      )
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Row(
          children: [
            Text(
              'Information',
              style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor, size: 18),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
            Spacer(),
            CustomButton(
              side: BorderSide.none,
              onPressed: (){},
              borderRadius: 12,
              text: "Import Information",
              textStyle: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkYellowColor,size: 14),
            )
          ],
        ),
        Divider(color: AppColor().lightSilverGrayColor,),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'First name',
                hintText: "First name",
                controller: _firstNameController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Last name',
                hintText: 'Last name',
                controller: _lastNameController,
                isRequired: true,
              ),
            ),
          ],
        ),
        Divider(color: AppColor().lightSilverGrayColor,),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Mobile No.',
                hintText: "1234567890",
                controller: _firstNameController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Last name',
                hintText: 'Last name',
                controller: _lastNameController,
                isRequired: true,
              ),
            ),
          ],
        ),
        Divider(color: AppColor().lightSilverGrayColor,),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Address.',
                hintText: "123 Anywhere St, Any City, ST 12345",
                controller: _firstNameController,
                isRequired: true,
              ),
            ),
          ],
        ),
        Divider(color: AppColor().lightSilverGrayColor,),
        _checkLists(
          label: "Checklists",
          title: "I checked and took picture of the original driver’s license. ( Copy not accepted )",
          isRequired: true,
          value: true
        ),
        Divider(color: AppColor().lightSilverGrayColor,),
        _checkLists(
            label: "Checklists",
            title: "I checked and took picture of the original driver’s ID. ( Copy not accepted )",
            isRequired: true,
            value: true
        ),
        vGap(20)
      ],
    );
  }
}

Widget _checkLists({
  String?label,
  String?title,
  bool? value,
  bool isRequired = false
}
){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 10,
    children: [
      Row(
        children: [
          Text(
            label!,
            style: MontserratStyles.montserratMediumTextStyle(color: AppColor().darkCharcoalBlueColor,size: 18),
          ),
          if (isRequired)
            Text(
              ' *',
              style: TextStyle(color: Colors.red,fontSize: 18),
            ),
        ],
      ),
      Text(
        title!,
        style: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().darkCharcoalBlueColor,size: 14),
      ),
      CustomRectangularSwitch(
          width: 80,
          height: 40,
          inactiveColor: Colors.red,
          activeColor: Colors.green,
          value: value!,
          onChanged: (ttp){

      } )
  ],
  );
}

Widget _buildTextField({
  required String label,
  required TextEditingController controller,
  String? hintText,
  bool isRequired = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            label,
            style: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().darkCharcoalBlueColor,size: 14),
          ),
          if (isRequired)
            Text(
              ' *',
              style: TextStyle(color: Colors.red,fontSize: 18),
            ),
        ],
      ),
      SizedBox(height: 8),
      CustomTextField(
        fillColor: AppColor().backgroundColor,
        controller: controller,
        hintText: hintText,
        hintStyle: MontserratStyles.montserratSemiBoldTextStyle(color: AppColor().silverShadeGrayColor.withOpacity(0.5),size: 14),
        borderRadius: 8,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)
      )
      // TextFormField(
      //   controller: controller,
      //   decoration: InputDecoration(
      //     hintText: hintText,
      //     hintStyle: TextStyle(color: Colors.grey[400]),
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
