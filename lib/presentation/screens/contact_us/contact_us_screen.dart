// Make sure this import exists
part of "contact_us_screen_route_imple.dart";

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32),
            constraints: const BoxConstraints(maxWidth: 600),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Contact Us",
                    style: MontserratStyles.montserratSemiBoldTextStyle(
                      size: 30,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    "We're happy to assist! If you need help with our mobile app or have any race-related questions, don't hesitate to reach out.",
                    textAlign: TextAlign.center,
                    style: MontserratStyles.montserratSemiBoldTextStyle(
                      size: 15,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "Write us",
                  style: MontserratStyles.montserratBoldTextStyle(
                    size: 24,
                    color: AppColor().darkCharcoalBlueColor,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInput(
                  "Subject",
                  "Enter Subject",
                  controller: subjectController,
                ),
                const SizedBox(height: 20),
                _buildInput(
                  "Message",
                  "Enter Message",
                  maxLines: 5,
                  controller: messageController,
                ),
                const SizedBox(height: 30),
                BlocConsumer<ContactUsScreenBloc, ContactUsScreenState>(
                  listener: (context, state) {
                    if (state is ContactUsScreenSuccess) {
                      CherryToast.success(
                        context,
                        state.response.message ?? "",
                      );
                      subjectController.clear();
                      messageController.clear();
                    }
                  },
                  builder: (context, state) {
                    return CustomButtonWeb(
                      isLoading: (state is ContactUsScreenLoading)
                          ? true
                          : false,
                      width: double.infinity,
                      text: "Submit",
                      onPressed: () {
                        context.read<ContactUsScreenBloc>().add(
                          SubmitContactUsEvent(
                            subject: subjectController.text.trim().toString(),
                            message: messageController.text.trim().toString(),
                          ),
                        );
                      },
                      color: AppColor().darkCharcoalBlueColor,
                      textColor: AppColor().yellowWarmColor,
                      borderRadius: 30,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    String label,
    String hintText, {
    int maxLines = 1,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: MontserratStyles.montserratSemiBoldTextStyle(
            size: 15,
            color: AppColor().darkCharcoalBlueColor,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            helperStyle: MontserratStyles.montserratRegularTextStyle(
              size: 15,
              color: AppColor().silverShadeGrayColor,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF1F2D4A)),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF1F2D4A), width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
