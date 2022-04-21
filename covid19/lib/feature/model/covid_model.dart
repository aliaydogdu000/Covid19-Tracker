import 'dart:convert';

import 'package:vexana/vexana.dart';

CovidModel covidModelFromJson(String str) =>
    CovidModel.fromJson(json.decode(str));

String covidModelToJson(CovidModel data) => json.encode(data.toJson());

class CovidModel extends INetworkModel<CovidModel> {
  CovidModel({
    this.id,
    this.message,
    this.global,
    this.countries,
    this.date,
  });

  String? id;
  String? message;
  Global? global;
  List<Country>? countries;
  String? date;

  factory CovidModel.fromJson(Map<String, dynamic> json) => CovidModel(
        id: json["ID"],
        message: json["Message"],
        global: Global.fromJson(json["Global"]),
        countries: List<Country>.from(
            json["Countries"].map((x) => Country.fromJson(x))),
        date: json["Date"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Message": message,
        "Global": global?.toJson(),
        "Countries":
            List<dynamic>.from(countries?.map((x) => x.toJson()) ?? {}),
        "Date": date,
      };

  @override
  CovidModel fromJson(Map<String, dynamic> json) {
    return CovidModel(
      id: json["ID"],
      message: json["Message"],
      global: Global.fromJson(json["Global"]),
      countries:
          List<Country>.from(json["Countries"].map((x) => Country.fromJson(x))),
      date: json["Date"],
    );
  }
}

class Country {
  Country({
    this.id,
    this.country,
    this.countryCode,
    this.slug,
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.date,
    this.premium,
  });

  String? id;
  String? country;
  String? countryCode;
  String? slug;
  int? newConfirmed;
  int? totalConfirmed;
  int? newDeaths;
  int? totalDeaths;
  int? newRecovered;
  int? totalRecovered;
  String? date;
  Premium? premium;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["ID"],
        country: json["Country"],
        countryCode: json["CountryCode"],
        slug: json["Slug"],
        newConfirmed: json["NewConfirmed"],
        totalConfirmed: json["TotalConfirmed"],
        newDeaths: json["NewDeaths"],
        totalDeaths: json["TotalDeaths"],
        newRecovered: json["NewRecovered"],
        totalRecovered: json["TotalRecovered"],
        date: json["Date"],
        premium: Premium.fromJson(json["Premium"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Country": country,
        "CountryCode": countryCode,
        "Slug": slug,
        "NewConfirmed": newConfirmed,
        "TotalConfirmed": totalConfirmed,
        "NewDeaths": newDeaths,
        "TotalDeaths": totalDeaths,
        "NewRecovered": newRecovered,
        "TotalRecovered": totalRecovered,
        "Date": date,
        "Premium": premium?.toJson(),
      };
}

class Premium {
  Premium();

  factory Premium.fromJson(Map<String, dynamic> json) => Premium();

  Map<String, dynamic> toJson() => {};
}

class Global {
  Global({
    this.newConfirmed,
    this.totalConfirmed,
    this.newDeaths,
    this.totalDeaths,
    this.newRecovered,
    this.totalRecovered,
    this.date,
  });

  int? newConfirmed;
  int? totalConfirmed;
  int? newDeaths;
  int? totalDeaths;
  int? newRecovered;
  int? totalRecovered;
  String? date;

  factory Global.fromJson(Map<String, dynamic> json) => Global(
        newConfirmed: json["NewConfirmed"],
        totalConfirmed: json["TotalConfirmed"],
        newDeaths: json["NewDeaths"],
        totalDeaths: json["TotalDeaths"],
        newRecovered: json["NewRecovered"],
        totalRecovered: json["TotalRecovered"],
        date: json["Date"],
      );

  Map<String, dynamic> toJson() => {
        "NewConfirmed": newConfirmed,
        "TotalConfirmed": totalConfirmed,
        "NewDeaths": newDeaths,
        "TotalDeaths": totalDeaths,
        "NewRecovered": newRecovered,
        "TotalRecovered": totalRecovered,
        "Date": date,
      };
}
