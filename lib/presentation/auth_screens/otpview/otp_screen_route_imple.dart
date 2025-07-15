library otp_screen_route_imple.dart;

import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/constants/const_route_string.dart';
import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../utilities/custom_textstyle.dart';
import '../../../utilities/custom_loader.dart';
import 'bloc/otp_view_bloc.dart';

part 'otp_screen.dart';