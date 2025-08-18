part of 'team_screen_bloc.dart';

@immutable
abstract class TeamScreenState {}

class TeamScreenInitial extends TeamScreenState {}

class TeamScreenLoading extends TeamScreenState {}

class TeamScreenLoaded extends TeamScreenState {
  final List<GetTeamUserData> teamMembers;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int currentPage;

  TeamScreenLoaded({
    required this.teamMembers,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
  });

  TeamScreenLoaded copyWith({
   List<GetTeamUserData>? teamMembers,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? currentPage,
  }) {
    return TeamScreenLoaded(
      teamMembers: teamMembers ?? this.teamMembers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class TeamScreenError extends TeamScreenState {
  final String message;

  TeamScreenError(this.message);
}
