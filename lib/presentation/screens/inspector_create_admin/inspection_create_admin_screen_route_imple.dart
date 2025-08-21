library inspection_create_admin_screen_route_imple.dart;

import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:auto_proof/presentation/screens/inspector_create_admin/bloc/inspector_create_admin_bloc.dart';
import 'package:auto_proof/presentation/widget/appBar.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_container.dart';
import 'package:auto_proof/utilities/custom_dropDown.dart';
import 'package:auto_proof/utilities/custom_loader.dart';
import 'package:auto_proof/utilities/custom_textfields.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'inspection_create_admin_screen.dart';