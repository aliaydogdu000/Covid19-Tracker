import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/covid_model.dart';
import '../service/global_servicee.dart';

class CovidCubit extends Cubit<CovidState> {
  CovidCubit(this.covidService) : super(CovidInitial()) {
    fetchData();
  }
  ICovidService covidService;
  CovidModel? covidModel;
  Future<void> fetchData() async {
    emit(CovidLoading());
    covidModel = await covidService.fetchData();

    emit(CovidCompleted(covidModel));
  }
}

abstract class CovidState {}

class CovidInitial extends CovidState {}

class CovidCompleted extends CovidState {
  final CovidModel? model;

  CovidCompleted(this.model);
}

class CovidLoading extends CovidState {}
