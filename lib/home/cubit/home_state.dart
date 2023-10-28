//Home States
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {}

class InitialHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadingHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadMoreHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}

class DataFetchedSuccessHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}

class ErrorHomeState extends HomeState {
  final int statusCode;
  ErrorHomeState(this.statusCode);

  @override
  List<Object?> get props => [statusCode];
}
