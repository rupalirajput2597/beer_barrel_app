import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../home.dart';

//Home Business Logic
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());

  List<Beer> beers = [];
  int pageNumber = 1;

  //Fetching Beer List
  fetchBeerList(BuildContext context) async {
    //emitting appropriate state for pagination
    (pageNumber == 1) ? emit(LoadingHomeState()) : emit(LoadMoreHomeState());
    try {
      DataRepository dataRepo = RepositoryProvider.of<DataRepository>(context);
      List<Beer>? results = await dataRepo.fetchBeersList(pageNumber);
      if (results == null) throw Exception(100);
      if (results.isNotEmpty) {
        beers.addAll(results);
        pageNumber += 1;
      }
      emit(DataFetchedSuccessHomeState());
    } on SocketException catch (e, s) {
      _resetPage();
      emit(ErrorHomeState(900));
    } catch (e) {
      _resetPage();
      emit(ErrorHomeState(100));
    }
  }

  //resetting page
  _resetPage() {
    pageNumber = 1;
  }
}
