part of 'team_screen_bloc.dart';

@immutable
abstract class TeamScreenEvent {}

class LoadTeamMembers extends TeamScreenEvent {
  final bool isRefresh;

  LoadTeamMembers({this.isRefresh = false});
}

class LoadMoreTeamMembers extends TeamScreenEvent {}

class GetSingleTeamMemberEvent extends TeamScreenEvent {
  final String inspectorId;
  GetSingleTeamMemberEvent({required this.inspectorId});
  @override
  List<Object?> get props => [inspectorId];
}

/// Update team member info event --

class UpdateTeamMemberInfoEvent extends TeamScreenEvent{
  final String inspectorId;
 final  Map<String, dynamic> body ;
  UpdateTeamMemberInfoEvent( {required this.inspectorId,required this.body,});
  @override
  List<Object> get props => [inspectorId];

}