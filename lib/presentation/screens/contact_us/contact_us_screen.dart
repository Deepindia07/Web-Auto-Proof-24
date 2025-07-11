part of "contact_us_screen_route_imple.dart";

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactUsScreenBloc>(
      create: (context) => ContactUsScreenBloc(),
      child: ContactUsScreenView(),
    );
  }
}

class ContactUsScreenView extends StatefulWidget {
  const ContactUsScreenView({super.key});

  @override
  State<ContactUsScreenView> createState() => _ContactUsScreenViewState();
}

class _ContactUsScreenViewState extends State<ContactUsScreenView> {
  final TextEditingController  _subjectController = TextEditingController();
  final TextEditingController  _messageController = TextEditingController();

  @override
  void dispose(){
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            // onBackPressed: (){
            //   context.go(AppRoute.homeScreen);
            // },
            backgroundColor: AppColor().backgroundColor,
              title: "Contact us"
          ),

          Expanded(child: _mainScreenView(context))
        ],
      ),
    );
  }

  Widget _mainScreenView(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            CustomContainer(
              backgroundColor: AppColor().backgroundColor,
              padding: EdgeInsets.all(16),
              child: Text("We're happy to assist! If you need help with our mobile app or have any race-related questions, don't hesitate to reach out.",
                style: MontserratStyles.montserratMediumTextStyle(size: 18,color: AppColor().darkCharcoalBlueColor),),
            ),
        
            Text("Write us",
              style: MontserratStyles.montserratBoldTextStyle(size: 28,color: AppColor().darkCharcoalBlueColor),),
        
            _buildCustomTextWidgetView(
                context,
              "Subject",
              "Enter Subject",
              _subjectController,
              1
            ),
            _buildCustomTextWidgetView(
                context,
              "Message",
              "Enter Message",
              _messageController,
              10
            ),
            CustomButton(
              side: BorderSide.none,
              onPressed: (){
        
              },
                text: "Submit",
             width: double.infinity,
            textStyle: MontserratStyles.montserratMediumTextStyle(size: 14,color: AppColor().darkYellowColor),)
          ],
        ),
      ),
    );
  }

  _buildCustomTextWidgetView(
      BuildContext context,
      String? title,
      String? hintText,
      TextEditingController controller,
      int maxLine
      ){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(title!,style: MontserratStyles.montserratMediumTextStyle(size: 18,color: AppColor().darkCharcoalBlueColor),),
        CustomTextField(
          controller: controller,
          borderRadius: 12,
          hintText: hintText,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(size: 16,color: AppColor().silverShadeGrayColor),
          fillColor: AppColor().backgroundColor,
          maxLines: maxLine,
        )
      ],
    );
  }
}
