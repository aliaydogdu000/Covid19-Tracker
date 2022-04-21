import 'package:covid19/feature/constants/colors.dart';
import 'package:covid19/feature/constants/strings.dart';

import '../../core/network/network_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../bloc/country_cubit.dart';
import '../service/country_service.dart';

class CountryPage extends StatefulWidget {
  CountryPage({Key? key, required this.index, this.icon, required this.title})
      : super(key: key);

  final String title;
  Widget? icon;
  int index;

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  TooltipBehavior? _tooltipBehavior;
  List<ChartData> chartData = [];

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: ColorScale().appBar,
            leading: IconButton(
              icon: widget.icon ?? const SizedBox(),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "COVID-19 ${widget.title.toUpperCase()} SUMMARY",
              style: TextStyle(color: ColorScale().textIconColor),
            ),
            centerTitle: true,
            elevation: 0),
        body: BlocProvider(
          create: (context) => CountryCubit(
            CountryService(NetworkService.instance.networkManager),
          ),
          child: BlocConsumer<CountryCubit, CountryState>(
              listener: (context, state) {},
              builder: (context, state) {
                return bodyChart(context, state);
              }),
        ),
      ),
    );
  }

  Widget bodyChart(BuildContext context, CountryState state) {
    if (state is CountryLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CountryCompleted) {
      chartData = [
        ChartData(
            AllStrings().chData1,
            state.model?.countries?[widget.index].newConfirmed?.toDouble() ?? 0,
            ColorScale().chColor1),
        ChartData(
            AllStrings().chData2,
            state.model?.countries?[widget.index].totalConfirmed?.toDouble() ??
                0,
            ColorScale().chColor2),
        ChartData(
            AllStrings().chData3,
            state.model?.countries?[widget.index].newDeaths?.toDouble() ?? 0,
            ColorScale().chColor3),
        ChartData(
            AllStrings().chData4,
            state.model?.countries?[widget.index].totalDeaths?.toDouble() ?? 0,
            ColorScale().chColor4),
        ChartData(
            AllStrings().chData5,
            state.model?.countries?[widget.index].newRecovered?.toDouble() ?? 0,
            ColorScale().chColor5),
        ChartData(
            AllStrings().chData6,
            state.model?.countries?[widget.index].totalRecovered?.toDouble() ??
                0,
            ColorScale().chColor6),
      ];
      return Column(
        children: [
          Expanded(
            child: SfCircularChart(
              legend: Legend(
                  position: LegendPosition.bottom,
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                  pointColorMapper: (ChartData data, _) => data.color,
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  enableTooltip: true,
                )
              ],
            ),
          ),
        ],
      );
    } else {
      return Text(AllStrings().error);
    }
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
