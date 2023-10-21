abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class DataFetchedSuccessHomeState extends HomeState {}

class ErrorHomeState extends HomeState {
  final int statusCode;
  ErrorHomeState(this.statusCode);
}
