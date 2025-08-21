part of 'create_company_bloc.dart';

abstract class CreateCompanyEvent extends Equatable {
  const CreateCompanyEvent();
}

class CreateCompanyApiEvent extends CreateCompanyEvent {
  final Map<String, dynamic> body;


  CreateCompanyApiEvent({required this.body,});
  @override
  List<Object?> get props => [body];
}

///-------get company model
///

class GetCompanyApiEvent extends CreateCompanyEvent {
  @override
  List<Object?> get props => [];
}


///--------
class UpdateCompanyApiEvent extends CreateCompanyEvent{
  final Map<String, dynamic> body;
  UpdateCompanyApiEvent({required this.body});
  @override
  List<Object?> get props => [body];
}