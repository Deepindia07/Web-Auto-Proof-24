part of 'instruction_screen_bloc.dart';

@immutable
abstract class InstructionScreenEvent {}

class FetchInspectionListEvent extends InstructionScreenEvent {}

class SelectInspectionEvent extends InstructionScreenEvent {
  final String inspectionId;

  SelectInspectionEvent(this.inspectionId);
}