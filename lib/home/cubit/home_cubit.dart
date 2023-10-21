import 'dart:io';

import 'package:beer_barrel/core/core.dart';
import 'package:beer_barrel/core/repository/data_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitialHomeState());

  List<Beer> beers = [];

  fetchBeerList(BuildContext context) async {
    emit(LoadingHomeState());
    try {
      DataRepository dataRepo = RepositoryProvider.of<DataRepository>(context);

      beers = await dataRepo.fetchBeersList(1) ?? [];

      print("beerrs -- ${beers.length}");

      emit(DataFetchedSuccessHomeState());
    } on SocketException catch (e, s) {
      print("$e: $s");
      emit(ErrorHomeState(900));
    } catch (e) {
      emit(ErrorHomeState(100));
    }
  }
}
