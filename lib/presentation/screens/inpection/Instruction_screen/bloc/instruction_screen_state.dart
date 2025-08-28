part of 'instruction_screen_bloc.dart';

@immutable
abstract class InstructionScreenState {}

class InstructionScreenInitial extends InstructionScreenState {}

class InstructionScreenLoading extends InstructionScreenState {}

class InstructionScreenLoaded extends InstructionScreenState {
  final GetAllInspectionListResponseModel inspectionList;
  final String? selectedInspectionId;

  InstructionScreenLoaded({
    required this.inspectionList,
    this.selectedInspectionId,
  });

  InstructionScreenLoaded copyWith({
    GetAllInspectionListResponseModel? inspectionList,
    String? selectedInspectionId,
  }) {
    return InstructionScreenLoaded(
      inspectionList: inspectionList ?? this.inspectionList,
      selectedInspectionId: selectedInspectionId ?? this.selectedInspectionId,
    );
  }
}

class InstructionScreenError extends InstructionScreenState {
  final String error;

  InstructionScreenError(this.error);
}