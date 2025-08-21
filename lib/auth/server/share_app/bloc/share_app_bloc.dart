import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'share_app_event.dart';
part 'share_app_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  ShareBloc() : super(ShareInitial()) {
    on<ShareAppEvent>(_onShareApp);
  }

  Future<void> _onShareApp(ShareAppEvent event, Emitter<ShareState> emit) async {
    emit(ShareLoading());

    try {
      String defaultMessage = 'Check out this amazing app! Download it now and join thousands of satisfied users.';
      String playStoreLink = 'https://play.google.com/store/apps/details?id=com.yourcompany.yourapp';
      String appStoreLink = 'https://apps.apple.com/app/your-app/id123456789';
      String shareMessage = event.customMessage ?? defaultMessage;
      shareMessage += '\n\n📱 Android: $playStoreLink\n🍎 iOS: $appStoreLink';

      // Share the content
      // final result = await SharePlus.instance.share();

      // Handle the result
      // switch (result.status) {
      //   case ShareResultStatus.success:
      //     emit(const ShareSuccess('App shared successfully!'));
      //     break;
      //   case ShareResultStatus.dismissed:
      //     emit(ShareInitial());
      //     break;
      //   case ShareResultStatus.unavailable:
      //     emit(const ShareError('Sharing is not available on this device'));
      //     break;
      // }
    } catch (e) {
      emit(ShareError('Failed to share app: ${e.toString()}'));
    }
  }
}
