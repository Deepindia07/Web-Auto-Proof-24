library car_detail_route_imple.dart;

import 'dart:io';

import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/presentation/screens/inpection/car_details/bloc/car_details_screen_bloc.dart';
import 'package:auto_proof/utilities/cusom_image_picker.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_container.dart';
import 'package:auto_proof/utilities/custom_dropDown.dart';
import 'package:auto_proof/utilities/custom_textfields.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:mime/mime.dart";

import '../../../../auth/server/default_db/sharedprefs_method.dart';
import '../../../../constants/const_string.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utilities/custom_switch_button.dart';
import 'model/car_details_model.dart';

part 'car_details_screen.dart';