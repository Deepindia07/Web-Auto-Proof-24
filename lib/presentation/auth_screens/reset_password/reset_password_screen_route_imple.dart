library reset_password_screen_route_imple.dart;

import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_route_string.dart';
import 'package:auto_proof/utilities/custom_loader.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/const_color.dart';
import '../../../../constants/const_image.dart';
import '../../../../utilities/custom_button.dart';
import '../../../../utilities/custom_textfields.dart';
import '../../../../utilities/custom_textstyle.dart';
import '../../../../utilities/custom_widgets.dart';
import 'bloc/reset_password_screen_bloc.dart';

part 'reset_password_screen.dart';