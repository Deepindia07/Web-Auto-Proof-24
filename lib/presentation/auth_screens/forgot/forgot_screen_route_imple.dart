library forgot_screen_route_imple.dart;

import 'dart:developer';

import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/constants/const_route_string.dart';
import 'package:auto_proof/presentation/auth_screens/forgot/bloc/forgot_screen_bloc.dart';
import 'package:auto_proof/responsive.dart';
import 'package:auto_proof/utilities/common_view_auth.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_textfields.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utilities/custom_loader.dart';

part 'forgot_screen.dart';