library team_screen_route_imple.dart;



import 'dart:convert';

import 'package:auto_proof/auth/data/models/get_all_inpection_list_response_model.dart';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_image.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:auto_proof/presentation/screens/inspector_create_admin/bloc/inspector_create_admin_bloc.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_dropDown.dart';
import 'package:auto_proof/utilities/custom_textfields.dart';
import 'package:auto_proof/utilities/input_validation.dart';
import 'package:auto_proof/utilities/phone_number_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/server/default_db/sharedprefs_method.dart';
import '../../../utilities/custom_textstyle.dart';
import '../../../utilities/custom_toast.dart';
import '../../../utilities/custom_widgets.dart';
import '../home/screens/home_screen_route_imple.dart';
import 'bloc/team_screen_bloc.dart';

part 'team_screen.dart';
part 'add_inspector_screen.dart';