import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_details_event.dart';
part 'card_details_state.dart';

class CardDetailsBloc extends Bloc<CardDetailsEvent, CardDetailsState> {
  CardDetailsBloc() : super(CardDetailsInitial()) {
    on<CardDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
