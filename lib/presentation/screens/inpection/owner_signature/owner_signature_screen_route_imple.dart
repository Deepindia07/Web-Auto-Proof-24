library owner_signature_screen_route_imple.dart;

import 'package:auto_proof/constants/const_color.dart';
import 'package:auto_proof/presentation/widget/appBar.dart';
import 'package:auto_proof/utilities/custom_button.dart';
import 'package:auto_proof/utilities/custom_textstyle.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';

import '../../../../l10n/app_localizations.dart';
import '../car_details/model/car_details_model.dart';
import '../client_singature/bloc/client_signature_screen_bloc.dart';
import 'datasource/model.dart';

part 'owner_signature_screen.dart';