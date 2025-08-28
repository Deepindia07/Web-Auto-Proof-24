library instruction_screen_route_imple.dart;

import 'package:auto_proof/auth/data/models/get_all_inpection_list_response_model.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/constants/const_route_string.dart';
import 'package:auto_proof/presentation/screens/inpection/Instruction_screen/bloc/instruction_screen_bloc.dart';
import 'package:auto_proof/presentation/screens/inpection/car_details/car_detail_route_imple.dart';
import 'package:auto_proof/presentation/screens/inpection/client_details/bloc/client_details_screen_bloc.dart';
import 'package:auto_proof/presentation/screens/inpection/client_details/client_details_screen_route_imple.dart';
import 'package:auto_proof/presentation/screens/inpection/owner_details/bloc/owner_details_screen_bloc.dart';
import 'package:auto_proof/presentation/screens/inpection/owner_details/owner_details_screen_route_imple.dart';
import 'package:auto_proof/presentation/widget/appBar.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_container.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_toast.dart';
import 'package:auto_proof/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../constants/const_image.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utilities/custom_widgets.dart';
import '../car_details/bloc/car_details_screen_bloc.dart';
import '../car_details/model/car_details_model.dart';
import '../car_im_inpection/car_im_inpection_screen_route_imple.dart';

part 'instruction_screen.dart';