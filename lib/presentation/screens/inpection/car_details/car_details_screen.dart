part of "car_detail_route_imple.dart";

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CarDetailsScreenBloc>(
      create: (context) => CarDetailsScreenBloc(),
      child: CarDetailsScreenView(),
    );
  }
}

class CarDetailsScreenView extends StatefulWidget {
  const CarDetailsScreenView({super.key});

  @override
  State<CarDetailsScreenView> createState() => _CarDetailsScreenViewState();
}

class _CarDetailsScreenViewState extends State<CarDetailsScreenView> {
  final _formKey = GlobalKey<FormState>();
  final _numberPlateController = TextEditingController(text: 'HR6699');
  final _tyreConditionsController = TextEditingController(text: 'Good');
  final _brandController = TextEditingController(text: 'i10');
  final _modelController = TextEditingController(text: '2022');
  final _mileageController = TextEditingController(text: '00-000-00');
  final _kmDayController = TextEditingController(text: '00');
  final _extraKmController = TextEditingController();
  final _priceTotalController = TextEditingController(text: '56€');
  final _commentController = TextEditingController();

  String selectedGasType = 'Diesel';
  String selectedGasLevel = '1/8';
  String selectedTyreCondition = 'Good';

  bool softPackYes = true;
  bool spareWheelYes = true;
  bool phoneOlderYes = true;
  bool gpsYes = true;
  bool chargingPortYes = true;
  bool carPapersYes = true;

  @override
  void dispose() {
    _numberPlateController.dispose();
    _brandController.dispose();
    _tyreConditionsController.dispose();
    _modelController.dispose();
    _mileageController.dispose();
    _kmDayController.dispose();
    _extraKmController.dispose();
    _priceTotalController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor().backgroundColor,
      body: SingleChildScrollView(
        // padding: EdgeInsets.all(5),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInformationSection(),
              SizedBox(height: 24),
              _buildChecklistSection(),
              SizedBox(height: 24),
              _buildCommentSection(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInformationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   decoration: BoxDecoration(
            //     color: Color(0xFF2C3E50),
            //     borderRadius: BorderRadius.circular(20),
            //   ),
            //   child: Text(
            //     'Import Information',
            //     style: TextStyle(
            //       color: Colors.orange,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: AppColor().lightSilverGrayColor,),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Number Plate',
                controller: _numberPlateController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Brand',
                controller: _brandController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Model',
                controller: _modelController,
                isRequired: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: AppColor().lightSilverGrayColor,),
        SizedBox(height: 16),
        // Second row: Mileage, Gas Type, Gas Level
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Mileage',
                controller: _mileageController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildDropdownField(
                label: 'Gas Type',
                value: selectedGasType,
                items: [
                  RadioDropdownOption(value: 'ds', label: 'Diesel'),
                  RadioDropdownOption(value: 'pl', label: 'Petrol'),
                  RadioDropdownOption(value: 'ec', label: 'Electric'),
                  RadioDropdownOption(value: 'hd', label: 'Hybrid'),
                ],
                onChanged: (value) => setState(() => selectedGasType = value!),
                isRequired: true, dropValue: 'Diesel',
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildDropdownField(
                label: 'Gas Level',
                value: selectedGasLevel,
                items: [
                  RadioDropdownOption(value: 'emp', label: 'Empty'),
                  RadioDropdownOption(value: 'pl', label: '1/8'),
                  RadioDropdownOption(value: 'ec', label: '2/8'),
                  RadioDropdownOption(value: 'h1d', label: '3/8'),
                  RadioDropdownOption(value: '2', label: 'Half'),
                  RadioDropdownOption(value: 'h2d', label: '5/8'),
                  RadioDropdownOption(value: 'h3d', label: '6/8'),
                  RadioDropdownOption(value: 'h4d', label: '7/8'),
                  RadioDropdownOption(value: 'h5d', label: 'Full'),
                ],
                onChanged: (value) => setState(() => selectedGasLevel = value!),
                isRequired: true, dropValue: '1/8',
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: AppColor().lightSilverGrayColor,),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Tyre Condition',
                controller: _tyreConditionsController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Km/day',
                controller: _kmDayController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Extra KM (€)',
                controller: _extraKmController,
                hintText: '€',
                isRequired: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(color: AppColor().lightSilverGrayColor,),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildTextField(
                label: 'Price Total (€)',
                controller: _priceTotalController,
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildFileUploadField(
                label: 'Up.insurance',
                onTap: () {
                  // Handle file upload
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildImageField(
                label: 'Insrance.jpg',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChecklistSection() {
    return Column(
      children: [
        Divider(color: AppColor().lightSilverGrayColor,),
        SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Checklist',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _buildSwitchField(
                label: 'Softy Pack',
                value: softPackYes,
                onChanged: (value) => setState(() => softPackYes = value),
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: _buildSwitchField(
                label: 'Spare Wheel',
                value: spareWheelYes,
                onChanged: (value) => setState(() => spareWheelYes = value),
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: _buildSwitchField(
                label: 'Phone older',
                value: phoneOlderYes,
                onChanged: (value) => setState(() => phoneOlderYes = value),
                isRequired: true,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        // Second row: GPS, Charging Port, Car Papers
        Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildSwitchField(
                label: 'GPS',
                value: gpsYes,
                onChanged: (value) => setState(() => gpsYes = value),
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildSwitchField(
                label: 'Charging Port',
                value: chargingPortYes,
                onChanged: (value) => setState(() => chargingPortYes = value),
                isRequired: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: _buildSwitchField(
                label: 'Car Papers',
                value: carPapersYes,
                onChanged: (value) => setState(() => carPapersYes = value),
                isRequired: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Comment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
        SizedBox(height: 16),
        CustomTextField(
          controller: _commentController,
          maxLines: 3,
          fillColor: Colors.white,
          hintText: "Enter Comments",
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(size: 14, color: AppColor().silverShadeGrayColor),

        )

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
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        SizedBox(height: 8),
        CustomTextField(
          controller:controller,
          hintText: hintText,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(size: 14, color: AppColor().silverShadeGrayColor),
          fillColor: AppColor().backgroundColor,
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
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
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

  Widget _buildSwitchField({
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
        SizedBox(height: 8),
        CustomRectangularSwitch(
          value: value,
          width: 80,
          height: 40,
          inactiveColor: Colors.red,
          activeColor: Colors.green,
          onChanged: onChanged,
        )
      ],
    );
  }

  Widget _buildFileUploadField({
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        CustomContainer(
          backgroundColor: AppColor().backgroundColor,
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
          border: Border.all(color: AppColor().darkCharcoalBlueColor.withOpacity(0.2)),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 32,
              color: Colors.grey[400],
            ),
            SizedBox(height: 8),
            Text(
              'Drop the file',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
            ),
          ],
        ),
        )
        // GestureDetector(
        //   onTap: onTap,
        //   child: Container(
        //     height: 100,
        //     decoration: BoxDecoration(
        //       border: Border.all(color: Colors.grey[300]!),
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Icon(
        //           Icons.cloud_upload_outlined,
        //           size: 32,
        //           color: Colors.grey[400],
        //         ),
        //         SizedBox(height: 8),
        //         Text(
        //           'Drop the file',
        //           style: TextStyle(
        //             color: Colors.grey[400],
        //             fontSize: 12,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildImageField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[50],
          ),
          child: Center(
            child: Icon(
              Icons.image_outlined,
              size: 32,
              color: Colors.grey[400],
            ),
          ),
        ),
      ],
    );
  }

}