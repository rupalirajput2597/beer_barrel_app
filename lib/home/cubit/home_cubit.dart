import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../home.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());

  List<Beer> beers = [];
  int pageNumber = 1;
  bool loadMore = false;

  fetchBeerList(BuildContext context) async {
    (pageNumber == 1) ? emit(LoadingHomeState()) : emit(LoadMoreHomeState());

    try {
      DataRepository dataRepo = RepositoryProvider.of<DataRepository>(context);

      List<Beer> results = await dataRepo.fetchBeersList(pageNumber) ?? [];

      if (results.isNotEmpty) {
        beers.addAll(results);
        pageNumber += 1;
        loadMore = true;
      } else {
        loadMore = false;
      }

      print("homae -- ${pageNumber}");
      emit(DataFetchedSuccessHomeState());
    } on SocketException catch (e, s) {
      print("$e: $s");
      pageNumber = 1;
      emit(ErrorHomeState(900));
    } catch (e) {
      pageNumber = 1;

      emit(ErrorHomeState(100));
    }
  }
}
