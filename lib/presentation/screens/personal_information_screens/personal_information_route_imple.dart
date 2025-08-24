library personal_information_route_imple.dart;


import 'dart:developer';

import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/presentation/screens/personal_information_screens/bloc/personal_information_bloc/personal_information_bloc.dart';
import 'package:auto_proof/presentation/screens/personal_information_screens/models/personal_information_api_model.dart';
import 'package:auto_proof/responsive.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_loader.dart';
import 'package:auto_proof/utilities/custom_textfields.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:auto_proof/utilities/input_validation.dart';
import 'package:auto_proof/utilities/phone_number_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utilities/custom_dropDown.dart';

part 'personal_information_screen.dart';
