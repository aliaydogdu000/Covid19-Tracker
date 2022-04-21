import 'package:covid19/feature/constants/strings.dart';

import '../model/covid_model.dart';
import 'package:vexana/vexana.dart';

abstract class ICovidService {
  final INetworkManager networkManager;
  ICovidService(this.networkManager);
  Future<CovidModel?> fetchData();
}

class CovidService extends ICovidService {
  CovidService(INetworkManager networkManager) : super(networkManager);

  @override
  Future<CovidModel?> fetchData() async {
    final response = await networkManager.send<CovidModel, CovidModel>(
        AllStrings().apiUrl,
        parseModel: CovidModel(),
        method: RequestType.GET);
    return response.data;
  }
}
