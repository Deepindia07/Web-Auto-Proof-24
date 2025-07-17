library payment_screen_route_imple.dart;

import 'package:auto_proof/constants/const_route_string.dart';
import 'package:auto_proof/utilities/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide PaymentMethod;
import 'package:go_router/go_router.dart';

import '../../../constants/const_color.dart';
import '../../../utilities/custom_textstyle.dart';
import '../../widget/appBar.dart';
import 'bloc/payment_screen_bloc.dart';

part 'payment_screen.dart';