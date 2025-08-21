part of 'inspector_create_admin_bloc.dart';

@immutable
abstract class InspectorCreateAdminEvent {}

class CreateInspectorEvent extends InspectorCreateAdminEvent {
  final Map<dynamic, String> body;
  final String adminID;


  CreateInspectorEvent({required this.body,required this.adminID, });
}

class ResetInspectorCreateState extends InspectorCreateAdminEvent {}
