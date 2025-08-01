library vehicles_screen_route_imple.dart;

import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:auto_proof/presentation/screens/vehicles_screen/bloc/vehicles_screen_bloc.dart';
import 'package:auto_proof/presentation/widget/appBar.dart';
import 'package:auto_proof/utilities/custom_loader.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/data/models/vehicle_list_response_model.dart';
import '../../../utilities/custom_button.dart';
import '../../../utilities/custom_container.dart';
import '../../../utilities/custom_widgets.dart';

part 'vehicles_screen.dart';