library company_screen_route_imple.dart;

import 'dart:convert';
import 'package:auto_proof/presentation/screens/company/bloc/create_company_bloc.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:auto_proof/utilities/input_validation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker_web/image_picker_web.dart';
import '../../../constants/const_color.dart';
import '../../../utilities/custom_textfields.dart';
import '../../../utilities/custom_textstyle.dart';
import '../../../utilities/responsive_screen_sizes.dart';
import 'models/get_company_model.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img; // compression
part 'company_screen.dart';
