import 'package:auto_proof/auth/data/models/get_all_inpection_list_response_model.dart';
import 'package:auto_proof/auth/server/default_db/sharedprefs_method.dart';
import 'package:auto_proof/auth/server/network/auth_network_imple_service.dart';
import 'package:auto_proof/constants/const_string.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'team_screen_event.dart';
part 'team_screen_state.dart';

class TeamScreenBloc extends Bloc<TeamScreenEvent, TeamScreenState> {
  final AuthenticationApiCall apiRepository;
  static const int _limit = 10;

  TeamScreenBloc({required this.apiRepository}) : super(TeamScreenInitial()) {
    on<LoadTeamMembers>(_onLoadTeamMembers);
    on<LoadMoreTeamMembers>(_onLoadMoreTeamMembers);
  }

  Future<void> _onLoadTeamMembers(
      LoadTeamMembers event,
      Emitter<TeamScreenState> emit,
      ) async {
    if (event.isRefresh && state is TeamScreenLoaded) {
      emit((state as TeamScreenLoaded).copyWith(isLoadingMore: true));
    } else {
      emit(TeamScreenLoading());
    }

    try {
      final result = await apiRepository.getAllInspectionListApiCall(
        dataBody: {'page': 1, 'limit': _limit},
      );

      if (result.isSuccess && result.data.isNotEmpty) {
        final List<GetTeamUserData> allTeamMembers = result.data;
        if (allTeamMembers.isNotEmpty) {
          final companyIdValue = allTeamMembers.first.companyId?.toString();
          if (companyIdValue != null && companyIdValue.isNotEmpty) {
            await SharedPrefsHelper.instance.setString(
                companyId, companyIdValue);
          }
          print("companyId: ${SharedPrefsHelper.instance.getString(companyId)}");
        }
        emit(TeamScreenLoaded(
          teamMembers: allTeamMembers,
          hasReachedMax: allTeamMembers.length < _limit,
          currentPage: 1,
        ));
      } else {
        final errorMessage = result.isFailure
            ? result.error
            : (result.data.isEmpty ? 'No team members found' : 'Unknown error occurred');
        emit(TeamScreenError(errorMessage));
      }
    } catch (error) {
      emit(TeamScreenError('Failed to load team members: $error'));
    }
  }

  Future<void> _onLoadMoreTeamMembers(
      LoadMoreTeamMembers event,
      Emitter<TeamScreenState> emit,
      ) async {
    if (state is! TeamScreenLoaded) return;

    final currentState = state as TeamScreenLoaded;
    if (currentState.hasReachedMax || currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.currentPage + 1;
      final result = await apiRepository.getAllInspectionListApiCall(
        dataBody: {'page': nextPage, 'limit': _limit},
      );

      if (result.isSuccess && result.data.isNotEmpty) {
        final List<GetTeamUserData> newTeamMembers = result.data;
        final allTeamMembers = List<GetTeamUserData>.from(currentState.teamMembers)
          ..addAll(newTeamMembers);

        emit(TeamScreenLoaded(
          teamMembers: allTeamMembers,
          hasReachedMax: newTeamMembers.length < _limit,
          isLoadingMore: false,
          currentPage: nextPage,
        ));
      } else {
        emit(currentState.copyWith(
          isLoadingMore: false,
          hasReachedMax: true,
        ));
      }
    } catch (error) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }
}

