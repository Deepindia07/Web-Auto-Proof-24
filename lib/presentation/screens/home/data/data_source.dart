import 'package:auto_proof/constants/const_image.dart';

import 'container_data.dart';

class AppSectionsData {
  static List<ContainersData> getAppSections() {
    return [
      ContainersData(
        title: "My Profile",
        icons: personIcons,
      ),
      ContainersData(
        title: "New Inspection",
        icons: docInspectionsIcons,
      ),
      ContainersData(
        title: "Check-Out List",
        icons: checkListIcons,
      ),
      ContainersData(
        title: "Check-In List",
        icons: checkListIcons,
      ),
      ContainersData(
        title: "My Team",
        icons: teamIcons,
      ),
      ContainersData(
        title: "My Vehicls",
        icons: carShortIcons,
      ),
      ContainersData(
        title: "Previous History",
        icons:previouslyHistory,
      ),
    ];
  }
}