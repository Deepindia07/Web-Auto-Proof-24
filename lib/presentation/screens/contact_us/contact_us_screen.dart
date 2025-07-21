// Make sure this import exists
part of "contact_us_screen_route_imple.dart";

class ContactUsScreen extends StatelessWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const ContactUsScreen({super.key, required this.isBacked, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactUsScreenBloc>(
      create: (context) => ContactUsScreenBloc(),
      child: ContactUsScreenView(isBacked: isBacked, onBack: onBack),
    );
  }
}

class ContactUsScreenView extends StatefulWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const ContactUsScreenView({super.key, required this.isBacked, required this.onBack});

  @override
  State<ContactUsScreenView> createState() => _ContactUsScreenViewState();
}

class _ContactUsScreenViewState extends State<ContactUsScreenView> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Column(
        children: [
          CustomAppBar(
            onBackPressed: widget.onBack,
            isBacked: widget.isBacked,
            backgroundColor: AppColor().backgroundColor,
            title: localizations.contactUsTitle,
          ),
          Expanded(child: _mainScreenView(context, localizations)),
        ],
      ),
    );
  }

  Widget _mainScreenView(BuildContext context, AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            CustomContainer(
              backgroundColor: AppColor().backgroundColor,
              padding: const EdgeInsets.all(16),
              child: Text(
                localizations.contactUsInfo,
                style: MontserratStyles.montserratMediumTextStyle(
                  size: 18,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              ),
            ),
            Text(
              localizations.writeUs,
              style: MontserratStyles.montserratBoldTextStyle(
                size: 28,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
            _buildCustomTextWidgetView(
              context,
              localizations.subjectLabel,
              localizations.subjectHint,
              _subjectController,
              1,
            ),
            _buildCustomTextWidgetView(
              context,
              localizations.messageLabel,
              localizations.messageHint,
              _messageController,
              10,
            ),
            CustomButton(
              side: BorderSide.none,
              onPressed: () {
                // Handle submit
              },
              text: localizations.submitButton,
              width: double.infinity,
              textStyle: MontserratStyles.montserratMediumTextStyle(
                size: 14,
                color: AppColor().darkYellowColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTextWidgetView(
      BuildContext context,
      String? title,
      String? hintText,
      TextEditingController controller,
      int maxLine,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          title!,
          style: MontserratStyles.montserratMediumTextStyle(
            size: 18,
            color: AppColor().darkCharcoalBlueColor,
          ),
        ),
        CustomTextField(
          controller: controller,
          borderRadius: 12,
          hintText: hintText,
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
            size: 16,
            color: AppColor().silverShadeGrayColor,
          ),
          fillColor: AppColor().backgroundColor,
          maxLines: maxLine,
        ),
      ],
    );
  }
}
