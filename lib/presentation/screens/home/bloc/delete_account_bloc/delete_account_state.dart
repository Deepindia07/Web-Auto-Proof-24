part of 'delete_account_bloc.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();
}

final class DeleteAccountInitial extends DeleteAccountState {
  @override
  List<Object> get props => [];
}


final class DeleteAccountLoading extends DeleteAccountState {
  @override
  List<Object> get props => [];
}

final class DeleteAccountSuccess extends DeleteAccountState {
  @override
  List<Object> get props => [];
}

final class DeleteAccountError extends DeleteAccountState {
  @override
  List<Object> get props => [];
}

