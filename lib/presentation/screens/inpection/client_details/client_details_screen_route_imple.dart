library client_details_screen_route_imple.dart;

import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:auto_proof/presentation/screens/inpection/car_details/model/car_details_model.dart';
import 'package:auto_proof/presentation/screens/inpection/client_details/bloc/client_details_screen_bloc.dart' hide UpdateDriverLicenseEvent, UpdateDriverIdEvent;
import 'package:auto_proof/presentation/screens/inpection/client_details/datasource/client_details_model.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utilities/custom_button.dart';
import '../../../../utilities/custom_container.dart';
import '../../../../utilities/custom_switch_button.dart';
import '../../../../utilities/custom_textfields.dart';
import '../../../../utilities/custom_textstyle.dart';
import '../../../../utilities/custom_widgets.dart';
import '../owner_details/bloc/owner_details_screen_bloc.dart';

part 'client_details_screen.dart';
