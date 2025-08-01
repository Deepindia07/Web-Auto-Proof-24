import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/car_details_model.dart';

part 'car_details_screen_event.dart';
part 'car_details_screen_state.dart';

class CarDetailsScreenBloc extends Bloc<CarDetailsScreenEvent, CarDetailsScreenState> {
  CarDetailsModel _currentCarDetails = CarDetailsModel.empty();

  CarDetailsScreenBloc() : super(CarDetailsScreenInitial()) {
    on<UpdateCarDetailsEvent>(_onUpdateCarDetails);
    on<SaveCarDetailsEvent>(_onSaveCarDetails);
    on<ValidateFormEvent>(_onValidateForm);
  }

  void _onUpdateCarDetails(UpdateCarDetailsEvent event, Emitter<CarDetailsScreenState> emit) {
    _currentCarDetails = event.carDetails;
    emit(CarDetailsScreenLoaded(carDetails: _currentCarDetails));
  }

  void _onSaveCarDetails(SaveCarDetailsEvent event, Emitter<CarDetailsScreenState> emit) async {
    emit(CarDetailsScreenLoading());

    try {
      List<String> validationErrors = _validateCarDetails(event.carDetails);

      if (validationErrors.isNotEmpty) {
        emit(CarDetailsScreenValidationError(errors: validationErrors));
        return;
      }
      _currentCarDetails = event.carDetails;
      await Future.delayed(Duration(seconds: 1));

      emit(CarDetailsScreenSuccess(carDetails: _currentCarDetails));
    } catch (e) {
      emit(CarDetailsScreenError(message: 'Failed to save car details: ${e.toString()}'));
    }
  }

  void _onValidateForm(ValidateFormEvent event, Emitter<CarDetailsScreenState> emit) {
    List<String> validationErrors = _validateCarDetails(event.carDetails);

    if (validationErrors.isNotEmpty) {
      emit(CarDetailsScreenValidationError(errors: validationErrors));
    } else {
      emit(CarDetailsScreenLoaded(carDetails: event.carDetails));
    }
  }

  List<String> _validateCarDetails(CarDetailsModel carDetails) {
    List<String> errors = [];

    // Validate required fields
    if (carDetails.numberPlate.trim().isEmpty) {
      errors.add('Number Plate is required');
    }

    if (carDetails.brand.trim().isEmpty) {
      errors.add('Brand is required');
    }

    if (carDetails.model.trim().isEmpty) {
      errors.add('Model is required');
    }

    if (carDetails.mileage.trim().isEmpty) {
      errors.add('Mileage is required');
    }

    if (carDetails.tyreCondition.trim().isEmpty) {
      errors.add('Tyre Condition is required');
    }

    if (carDetails.kmDay.trim().isEmpty) {
      errors.add('Km/day is required');
    }

    if (carDetails.extraKm.trim().isEmpty) {
      errors.add('Extra KM is required');
    }

    if (carDetails.priceTotal.trim().isEmpty) {
      errors.add('Price Total is required');
    }

    if (carDetails.comment.trim().isEmpty) {
      errors.add('Comment is required');
    }

    // Add custom validation logic here if needed
    // For example, validate number plate format
    if (carDetails.numberPlate.isNotEmpty && !_isValidNumberPlate(carDetails.numberPlate)) {
      errors.add('Invalid number plate format');
    }

    return errors;
  }

  bool _isValidNumberPlate(String numberPlate) {
    RegExp regex = RegExp(r'^[A-Z]{2}-\d{3}-[A-Z]{2}$');
    return regex.hasMatch(numberPlate);
  }
  CarDetailsModel getCurrentCarDetails() {
    return _currentCarDetails;
  }

  void resetForm() {
    _currentCarDetails = CarDetailsModel.empty();
    add(UpdateCarDetailsEvent(carDetails: _currentCarDetails));
  }
}
