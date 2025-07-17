import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

import 'container_data.dart';

class AppSectionsData {
  static List<ContainersData> getAppSections(BuildContext context) {
    return [
      ContainersData(
        title: AppLocalizations.of(context)!.myProfile,
        icons: personIcons,
      ),
      ContainersData(
        title: AppLocalizations.of(context)!.newInspection,
        icons: docInspectionsIcons,
      ),
      ContainersData(
        title: AppLocalizations.of(context)!.checkOutList,
        icons: checkListIcons,
      ),
      ContainersData(
        title: AppLocalizations.of(context)!.checkInList,
        icons: checkListIcons,
      ),
      ContainersData(
        title: AppLocalizations.of(context)!.myTeam,
        icons: teamIcons,
      ),
      ContainersData(
        title: AppLocalizations.of(context)!.myVehicles,
        icons: carShortIcons,
      ),
      ContainersData(
        title: AppLocalizations.of(context)!.paymentHistory,
        icons:previouslyHistory,
      ),
    ];
  }
}