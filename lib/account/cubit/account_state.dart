//Account state
import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {}

class InitialAccountState extends AccountState {
  @override
  List<Object?> get props => [];
}

class CheckingAuthenticationState extends AccountState {
  @override
  List<Object?> get props => [];
}

class AuthenticatedAccountState extends AccountState {
  @override
  List<Object?> get props => [];
}

class UnauthenticatedAccountState extends AccountState {
  @override
  List<Object?> get props => [];
}

class AccountErrorState extends AccountState {
  final String? errorMessage;
  AccountErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class LogoutSuccessState extends AccountState {
  @override
  List<Object?> get props => [];
}
