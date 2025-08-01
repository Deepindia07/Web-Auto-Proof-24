// Make sure this import exists
part of "contact_us_screen_route_imple.dart";

class ContactUsScreen extends StatelessWidget {
  final bool? isBacked;
  final VoidCallback? onBack;
  const ContactUsScreen({super.key, required this.isBacked, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactUsScreenBloc>(
      create: (context) => ContactUsScreenBloc(
        apiRepository: AuthenticationApiCall(), // Inject your repository
      ),
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final subject = _subjectController.text.trim();
      final message = _messageController.text.trim();

      context.read<ContactUsScreenBloc>().add(
        SubmitContactUsEvent(
          subject: subject,
          message: message,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: BlocListener<ContactUsScreenBloc, ContactUsScreenState>(
        listener: (context, state) {
          if (state is ContactUsScreenSuccess) {
            CherryToast.success(context, state.response.message.toString());
          } else if (state is ContactUsScreenError) {
            CherryToast.error(context, state.errorMessage);
          }
        },
        child: Column(
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
      ),
    );
  }

  Widget _mainScreenView(BuildContext context, AppLocalizations localizations) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              CustomContainer(
                backgroundColor: AppColor().backgroundColor,
                child: Text(
                  localizations.contactUsInfo,
                  style: MontserratStyles.montserratLitleBoldTextStyle(
                    size: 16,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
              ),
              vGap(10),
              Text(
                localizations.writeUs,
                style: MontserratStyles.montserratBoldTextStyle(
                  size: 20,
                  color: AppColor().darkCharcoalBlueColor,
                ),
              ),
              vGap(5),
              _buildCustomTextWidgetView(
                context,
                localizations.subjectLabel,
                localizations.subjectHint,
                _subjectController,
                1,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return  'Subject is required';
                  }
                  if (value.trim().length < 3) {
                    return 'Subject must be at least 3 characters';
                  }
                  return null;
                },
              ),
              vGap(10),
              _buildCustomTextWidgetView(
                context,
                localizations.messageLabel,
                localizations.messageHint,
                _messageController,
                5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return  'Message is required';
                  }
                  if (value.trim().length < 10) {
                    return 'Message must be at least 10 characters';
                  }
                  return null;
                },
              ),
              vGap(20),
              BlocBuilder<ContactUsScreenBloc, ContactUsScreenState>(
                builder: (context, state) {
                  final isLoading = state is ContactUsScreenLoading;

                  return CustomButton(
                    side: BorderSide.none,
                    onPressed: isLoading ? null : _submitForm,
                    text: isLoading
                        ? localizations.submitButton
                        : localizations.submitButton,
                    width: double.infinity,
                    textStyle: MontserratStyles.montserratMediumTextStyle(
                      size: 14,
                      color: isLoading
                          ? AppColor().silverShadeGrayColor
                          : AppColor().darkYellowColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTextWidgetView(
      BuildContext context,
      String? title,
      String? hintText,
      TextEditingController controller,
      int maxLine, {
        String? Function(String?)? validator,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          title!,
          style: MontserratStyles.montserratMediumTextStyle(
            size: 14,
            color: AppColor().darkCharcoalBlueColor,
          ),
        ),
        TextFormField(
          controller: controller,
          maxLines: maxLine,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
              size: 16,
              color: AppColor().silverShadeGrayColor,
            ),
            fillColor: AppColor().backgroundColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor().silverShadeGrayColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor().silverShadeGrayColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor().darkYellowColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}

