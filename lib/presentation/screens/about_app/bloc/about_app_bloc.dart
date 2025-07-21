import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'about_app_event.dart';
part 'about_app_state.dart';

class AboutAppBloc extends Bloc<AboutAppEvent, AboutAppState> {
  AboutAppBloc() : super(AboutAppLoading()) {
    on<LoadAppInfo>(_onLoadAppInfo);
  }

  Future<void> _onLoadAppInfo(
      LoadAppInfo event, Emitter<AboutAppState> emit) async {
    try {
      final info = await PackageInfo.fromPlatform();
      print("App Version ====>> ${info.version}");
      emit(AboutAppLoaded(version: info.version));
    } catch (e) {
      print("PackageInfo error: $e"); // Add this line to see the actual error
      emit(AboutAppError("Failed to load app info: ${e.toString()}"));
    }
  }
}
