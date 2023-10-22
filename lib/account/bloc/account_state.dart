abstract class AccountState {}

class InitialAccountState extends AccountState {}

class CheckingAuthenticationState extends AccountState {}

class AuthenticatedAccountState extends AccountState {}

class UnauthenticatedAccountState extends AccountState {}

class AccountErrorState extends AccountState {}

class LogoutSuccessState extends AccountState {}
