library change_password_screen_route_imple.dart;

import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/server/network/auth_network_imple_service.dart';
import '../../../constants/const_color.dart';
import '../../../constants/const_image.dart';
import '../../../responsive.dart';
import '../../../utilities/custom_button.dart';
import '../../../utilities/custom_loader.dart';
import '../../../utilities/custom_textfields.dart';
import '../../../utilities/custom_textstyle.dart';
import '../../../utilities/custom_toast.dart';
import '../../../utilities/custom_widgets.dart';
import '../../../utilities/input_validation.dart';
import 'bloc/change_password_screen_bloc.dart';

part 'change_password_screen.dart';