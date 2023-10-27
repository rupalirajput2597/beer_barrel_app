import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../home.dart';

//Home Business Logic
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._dataRepository) : super(InitialHomeState());

  final DataRepository _dataRepository;

  List<Beer> beers = [];
  int pageNumber = 1;

  //Fetching Beer List
  fetchBeerList(BuildContext context) async {
    //emitting appropriate state for pagination
    (pageNumber == 1) ? emit(LoadingHomeState()) : emit(LoadMoreHomeState());
    try {
      List<Beer> results = await _dataRepository.fetchBeersList(pageNumber);
      if (results.isNotEmpty) {
        beers.addAll(results);
        pageNumber += 1;
      }
      emit(DataFetchedSuccessHomeState());
    } on SocketException catch (e, s) {
      resetPage();
      emit(ErrorHomeState(900));
    } catch (e) {
      resetPage();
      emit(ErrorHomeState(100));
    }
  }

  //resetting page
  resetPage() {
    pageNumber = 1;
  }
}
