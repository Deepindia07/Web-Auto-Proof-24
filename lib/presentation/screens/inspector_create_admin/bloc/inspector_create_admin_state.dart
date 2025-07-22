part of 'inspector_create_admin_bloc.dart';

@immutable
abstract class InspectorCreateAdminState {}

class InspectorCreateAdminInitial extends InspectorCreateAdminState {}

class InspectorCreateAdminLoading extends InspectorCreateAdminState {}

class InspectorCreateAdminSuccess extends InspectorCreateAdminState {
  final PostInspectorRoleResponseModel response;

  InspectorCreateAdminSuccess({required this.response});
}

class InspectorCreateAdminError extends InspectorCreateAdminState {
  final String error;

  InspectorCreateAdminError({required this.error});
}
