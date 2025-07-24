library home_screen_route_imple.dart;

import 'dart:io';

import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/constants/const_route_string.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:auto_proof/l10n/app_localizations.dart';
import 'package:auto_proof/presentation/screens/contact_us/contact_us_screen_route_imple.dart';
import 'package:auto_proof/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:auto_proof/presentation/screens/notification/notification_screen_route_imple.dart';
import 'package:auto_proof/presentation/screens/reports_screen/reports_screen_route_imple.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_container.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/data/models/user_response_model.dart';
import '../../widget/drawer.dart';
import '../information/collect_information_screen_route_implement.dart';
import 'data/container_data.dart';
import 'data/data_container.dart';
import 'data/data_source.dart';

part 'home_screen.dart';