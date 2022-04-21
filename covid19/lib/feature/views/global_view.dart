import 'package:covid19/feature/constants/colors.dart';

import '../../core/network/network_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../bloc/global_cubit.dart';
import '../constants/strings.dart';
import '../service/global_servicee.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.icon, required this.title}) : super(key: key);

  final String title;
  Widget? icon;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              "COVID-19 ${widget.title} SUMMARY",
              style: TextStyle(color: ColorScale().textIconColor),
            ),
            centerTitle: true,
            elevation: 0),
        body: BlocProvider(
          create: (context) => CovidCubit(
            CovidService(NetworkService.instance.networkManager),
          ),
          child: BlocConsumer<CovidCubit, CovidState>(
              listener: (context, state) {},
              builder: (context, state) {
                return bodyChart(context, state);
              }),
        ),
      ),
    );
  }

  Widget bodyChart(BuildContext context, CovidState state) {
    if (state is CovidLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is CovidCompleted) {
      chartData = [
        ChartData(
            AllStrings().chData1,
            state.model?.global?.newConfirmed?.toDouble() ?? 0,
            ColorScale().chColor1),
        ChartData(
            AllStrings().chData2,
            state.model?.global?.totalConfirmed?.toDouble() ?? 0,
            ColorScale().chColor2),
        ChartData(
            AllStrings().chData3,
            state.model?.global?.newDeaths?.toDouble() ?? 0,
            ColorScale().chColor3),
        ChartData(
            AllStrings().chData4,
            state.model?.global?.totalDeaths?.toDouble() ?? 0,
            ColorScale().chColor4),
        ChartData(
            AllStrings().chData5,
            state.model?.global?.newRecovered?.toDouble() ?? 0,
            ColorScale().chColor5),
        ChartData(
            AllStrings().chData6,
            state.model?.global?.totalRecovered?.toDouble() ?? 0,
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
                RadialBarSeries<ChartData, String>(
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
