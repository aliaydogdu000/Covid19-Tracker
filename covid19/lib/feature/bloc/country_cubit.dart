import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/covid_model.dart';
import '../service/country_service.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit(this.countryService) : super(CountryInitial()) {
    fetchCountryData();
  }
  ICountryService countryService;
  CovidModel? countryModel;
  Future<void> fetchCountryData() async {
    emit(CountryLoading());
    countryModel = await countryService.fetchCountryData();

    emit(CountryCompleted(countryModel));
  }
}

abstract class CountryState {}

class CountryInitial extends CountryState {}

class CountryCompleted extends CountryState {
  final CovidModel? model;

  CountryCompleted(this.model);
}

class CountryLoading extends CountryState {}
