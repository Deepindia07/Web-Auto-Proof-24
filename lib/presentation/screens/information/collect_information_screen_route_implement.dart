library collect_information_screen_route_implement.dart;

import 'dart:io';

import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:auto_proof/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:auto_proof/presentation/screens/information/extension/extension.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_container.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/server/network/auth_network_imple_service.dart';
import '../../../constants/const_string.dart';
import '../../../utilities/cusom_image_picker.dart';
import '../../../utilities/custom_textfields.dart';
import '../../../utilities/custom_widgets.dart';
import '../../widget/appBar.dart';
import 'bloc/collect_information_screen_bloc.dart';

part 'collect_information_screen.dart';