import 'package:covid19/feature/constants/strings.dart';
import 'package:covid19/feature/model/covid_model.dart';
import 'package:vexana/vexana.dart';

abstract class ICountryService {
  final INetworkManager networkManager;
  ICountryService(this.networkManager);
  Future<CovidModel?> fetchCountryData();
}

class CountryService extends ICountryService {
  CountryService(INetworkManager networkManager) : super(networkManager);

  @override
  Future<CovidModel?> fetchCountryData() async {
    final response = await networkManager.send<CovidModel, CovidModel>(
        AllStrings().apiUrl,
        parseModel: CovidModel(),
        method: RequestType.GET);
    return response.data;
  }
}
