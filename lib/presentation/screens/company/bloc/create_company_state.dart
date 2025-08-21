part of 'create_company_bloc.dart';

abstract class CreateCompanyState extends Equatable {
  const CreateCompanyState();
}

final class CreateCompanyInitial extends CreateCompanyState {
  @override
  List<Object> get props => [];
}

final class CreateCompanyLoading extends CreateCompanyState {
  @override
  List<Object> get props => [];
}

final class CreateCompanySuccess extends CreateCompanyState {
  @override
  List<Object> get props => [];
}

final class CreateCompanyError extends CreateCompanyState {
  final String error;
  const CreateCompanyError({required this.error});
  @override
  List<Object> get props => [error];
}

///-------get company model
///
final class GetCompanyLoading extends CreateCompanyState {
  @override
  List<Object> get props => [];
}

final class GetCompanySuccess extends CreateCompanyState {
  GetCompanyModel getCompanyModel;
  GetCompanySuccess({required this.getCompanyModel});
  @override
  List<Object> get props => [getCompanyModel];
}

final class GetCompanyError extends CreateCompanyState {
  final String error;
  const GetCompanyError({required this.error});
  @override
  List<Object> get props => [error];
}

//---
final class UpdateCompanyLoading extends CreateCompanyState {
  @override
  List<Object> get props => [];
}

final class UpdateCompanySuccess extends CreateCompanyState {
  @override
  List<Object> get props => [];
}

final class UpdateCompanyError extends CreateCompanyState {
  final String error;
  const UpdateCompanyError({required this.error});
  @override
  List<Object> get props => [];
}
