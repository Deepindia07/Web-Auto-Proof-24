part of 'team_screen_bloc.dart';

@immutable
abstract class TeamScreenEvent {}

class LoadTeamMembers extends TeamScreenEvent {
  final bool isRefresh;

  LoadTeamMembers({this.isRefresh = false});
}

class LoadMoreTeamMembers extends TeamScreenEvent {}