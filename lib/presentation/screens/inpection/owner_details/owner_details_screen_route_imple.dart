library owner_details_screen_route_imple.dart;

import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:auto_proof/presentation/screens/home/screens/home_screen_route_imple.dart';
import 'package:auto_proof/presentation/screens/inpection/car_details/model/car_details_model.dart';
import 'package:auto_proof/presentation/screens/inpection/owner_details/bloc/owner_details_screen_bloc.dart';
import 'package:auto_proof/presentation/screens/team_View/bloc/team_screen_bloc.dart';
import 'package:auto_proof/presentation/screens/team_View/models/get_single_team_model.dart';
import 'package:auto_proof/utilities/custom_textfields.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../utilities/custom_button.dart';
import '../../../../utilities/custom_container.dart';
import '../../../../utilities/custom_textstyle.dart';
import '../../../../utilities/input_validation.dart';
import '../../team_View/team_screen_route_imple.dart';

part 'owner_details_screen.dart';