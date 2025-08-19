import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/presentation/screens/home/screens/home_screen_route_imple.dart';
import 'package:auto_proof/presentation/screens/team_View/bloc/team_screen_bloc.dart';
import 'package:auto_proof/presentation/screens/team_View/models/get_single_team_model.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTeamDetailsScreen extends StatefulWidget {
  final String inspectorId;
  final void Function(ScreenType type, {String? inspectorId}) onScreenChange;
  const MyTeamDetailsScreen({super.key, required this.inspectorId, required this.onScreenChange});

  @override
  State<MyTeamDetailsScreen> createState() => _MyTeamDetailsScreenState();
}

class _MyTeamDetailsScreenState extends State<MyTeamDetailsScreen> {
  GetSingleTeamMemberModel? getSingleTeamMemberModel;
  Inspector? inspector;
  bool isEditing = false;
  TextEditingController gmailController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  @override
  void initState() {
    context.read<TeamScreenBloc>().add(
      GetSingleTeamMemberEvent(inspectorId: widget.inspectorId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Dynamic padding and font scaling
    double horizontalPadding = screenWidth * 0.05;
    double labelFontSize = screenWidth * 0.014;
    double valueFontSize = screenWidth * 0.014;

    return Scaffold(
      backgroundColor: AppColor().backgroundColor,
      body: Center(
        child: Container(
          width: screenWidth > 900 ? 800 : screenWidth * 0.7,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding / 1.2,
            vertical: 20,
          ),

          child: SingleChildScrollView(
            child: BlocConsumer<TeamScreenBloc, TeamScreenState>(
              listener: (context, state) {
                if (state is GetSingleTeamMemberSuccess) {
                  getSingleTeamMemberModel = state.getSingleTeamMemberModel;
                  inspector = state.getSingleTeamMemberModel.inspector;
                  gmailController.text = inspector?.email ?? "";
                  phoneNoController.text = inspector?.phoneNumber ?? "";
                }
                if (state is UpdateTeamMemberInfoSuccess) {
                  context.read<TeamScreenBloc>().add(
                    GetSingleTeamMemberEvent(inspectorId: widget.inspectorId),
                  );
                }
              },
              builder: (context, state) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Team Profile",
                        style: MontserratStyles.montserratSemiBoldTextStyle(
                          size: 30,
                          color: AppColor().darkCharcoalBlueColor,
                        ),
                      ),
                      SizedBox(height: 20),
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage(profileImageCopy),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF9CA3AF),
                            height: 1.4,
                          ),
                          children: [
                            TextSpan(
                              text: 'Name: ',
                              style: MontserratStyles.montserratMediumTextStyle(
                                color: AppColor().darkCharcoalBlueColor,
                                size: 20,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${inspector?.firstName} ${inspector?.lastName}",
                              style: MontserratStyles.montserratNormalTextStyle(
                                color: AppColor().darkCharcoalBlueColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20),
                      buildRow(
                        "Gmail:",
                        inspector?.email ?? "",
                        labelFontSize,
                        valueFontSize,
                        controller: gmailController,
                        isEditing: isEditing,
                      ),
                      Divider(color: AppColor().silverShadeGrayColor),
                      buildRow(
                        "Phone Number",
                        inspector?.phoneNumber ?? "",
                        labelFontSize,
                        valueFontSize,
                        controller: phoneNoController,
                        isEditing: isEditing,
                      ),
                      Divider(color: AppColor().silverShadeGrayColor),
                      buildRow(
                        "Inspection",
                        "${getSingleTeamMemberModel?.inspectionStats?.totalInspections ?? ""}",
                        labelFontSize,
                        valueFontSize,
                        controller: gmailController,
                        isEditing: false,
                      ),

                      ///upcoming
                      /*    Divider(color: AppColor().silverShadeGrayColor),
                      buildRow(
                        "Upcoming",
                        "${getSingleTeamMemberModel?.inspectionStats?.totalInspections ?? ""}",
                        labelFontSize,
                        valueFontSize,
                        controller: gmailController,
                        isEditing: false,
                      ),*/
                      Divider(color: AppColor().silverShadeGrayColor),
                      buildRow(
                        "Completed",
                        "${getSingleTeamMemberModel?.inspectionStats?.totalCompleted ?? ""}",
                        labelFontSize,
                        valueFontSize,
                        controller: gmailController,
                        isEditing: false,
                      ),
                      Divider(color: AppColor().silverShadeGrayColor),
                      buildRow(
                        "Ongoing",
                        "${getSingleTeamMemberModel?.inspectionStats?.totalOngoing ?? ""}",
                        labelFontSize,
                        valueFontSize,
                        controller: gmailController,
                        isEditing: false,
                      ),
                      Divider(color: AppColor().silverShadeGrayColor),

                      Row(
                        children: [
                          Expanded(
                            child: CustomButtonWeb(
                              isLoading:
                                  (state is UpdateTeamMemberInfoLoading) ||
                                      (state is GetSingleTeamMemberLoading)
                                  ? true
                                  : false,
                              text: isEditing ? "Update" : "Edit",

                              onPressed: () {
                                if (isEditing == false) {
                                  print(
                                    "Updated Gmail: ${gmailController.text}",
                                  );
                                  print(
                                    "Updated Phone: ${phoneNoController.text}",
                                  );
                                  setState(() => isEditing = true);
                                } else {
                                  context.read<TeamScreenBloc>().add(
                                    UpdateTeamMemberInfoEvent(
                                      inspectorId: widget.inspectorId,
                                      body: {
                                        "email": gmailController.text
                                            .trim()
                                            .toString(),
                                        "phoneNumber": phoneNoController.text
                                            .trim()
                                            .toString(),
                                      },
                                    ),
                                  );
                                  setState(() => isEditing = false);
                                }
                              },
                              color: AppColor().darkCharcoalBlueColor,
                              textColor: AppColor().yellowWarmColor,
                              borderRadius: 10,
                            ),
                          ),
                          hGap(30),
                          Expanded(
                            child: CustomButtonWeb(
                              text: "Previous",
                              onPressed: () {
                                widget.onScreenChange(ScreenType.myTeam);
                              },
                              color: AppColor().darkCharcoalBlueColor,
                              textColor: AppColor().yellowWarmColor,
                              borderRadius: 10,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(
    String label,
    String value,
    double labelSize,
    double valueSize, {
    bool isEditing = false,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label
          Expanded(
            child: Text(
              label,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                size: labelSize,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
          ),

          // Value or Editable field
          Expanded(
            child: isEditing
                ? SizedBox(
                    height: 40, // keep height compact
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.end,
                      style: MontserratStyles.montserratRegularTextStyle(
                        size: valueSize,
                        color: AppColor().darkCharcoalBlueColor,
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10, // keep vertical padding small
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                : Text(
                    value,
                    textAlign: TextAlign.end,
                    style: MontserratStyles.montserratRegularTextStyle(
                      size: valueSize,
                      color: AppColor().darkCharcoalBlueColor,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  /* Widget buildRow(
    String label,
    String value,
    double labelSize,
    double valueSize,
    TextEditingController controller,
    bool isEditing,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 16,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              readOnly: !isEditing,
              textAlign: TextAlign.end,
              style: MontserratStyles.montserratRegularTextStyle(
                size: valueSize,
                color: AppColor().darkCharcoalBlueColor,
              ),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          */ /* Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: MontserratStyles.montserratRegularTextStyle(
                size: 16,
                color: AppColor().darkCharcoalBlueColor,
              ),
            ),
          ),*/ /*
        ],
      ),
    );
  }*/
}
