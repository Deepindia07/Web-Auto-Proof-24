library instruction_screen_route_imple.dart;

import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_route_string.dart';
import 'package:auto_proof/presentation/screens/inpection/Instruction_screen/bloc/instruction_screen_bloc.dart';
import 'package:auto_proof/presentation/screens/inpection/car_details/car_detail_route_imple.dart';
import 'package:auto_proof/presentation/screens/inpection/client_details/client_details_screen_route_imple.dart';
import 'package:auto_proof/presentation/screens/inpection/owner_details/owner_details_screen_route_imple.dart';
import 'package:auto_proof/presentation/widget/appBar.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_container.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../constants/const_image.dart';
import '../../../../utilities/custom_widgets.dart';
import '../car_im_inpection/car_im_inpection_screen_route_imple.dart';

part 'instruction_screen.dart';