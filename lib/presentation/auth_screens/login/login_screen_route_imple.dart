library login_screen_route_imple.dart;

import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_route_string.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_textfields.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../constants/const_image.dart';
import '../../../../utilities/custom_textstyle.dart';
import '../../../utilities/custom_loader.dart';
import '../../../utilities/custom_toast.dart';
import 'bloc/login_screen_bloc.dart';


part 'login_screen.dart';