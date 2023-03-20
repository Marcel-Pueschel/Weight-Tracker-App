import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:weight_tracker/application/weight/observer/observer_bloc.dart';
import 'package:weight_tracker/domain/entities/utils/char_data.dart';
import 'package:weight_tracker/domain/entities/weight/weight.dart';
import 'package:weight_tracker/injection.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  List<ChartData> weightListToChartData(List<Weight> weightList) {
    List<ChartData> charData = [];
    for (var weight in weightList) {
      charData.add(ChartData(
        date: weight.date,
        weight: weight.weight,
        color: Colors.blue,
      ));
    }

    return charData;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final observerBloc = sl<ObserverBloc>()..add(ObserveAllEvent());

    return BlocProvider<ObserverBloc>(
      create: (context) => observerBloc,
      child: BlocBuilder<ObserverBloc, ObserverState>(
        builder: (context, state) {
          if (state is ObserverInitial) {
            return Container();
          } else if (state is ObserverLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: themeData.colorScheme.secondary,
              ),
            );
          } else if (state is ObserverFailure) {
            return const Center(
              child: Text("Observer Failure"),
            );
          } else if (state is ObserverSuccess) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: SfCartesianChart(
                      title: ChartTitle(text: "Weight Chart"),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      primaryXAxis: DateTimeAxis(
                        intervalType: DateTimeIntervalType.days,
                        autoScrollingDelta: 28,
                      ),
                      primaryYAxis: NumericAxis(
                        labelFormat: "{value} KG",
                        anchorRangeToVisiblePoints: false,
                      ),
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePinching: true,
                        enableDoubleTapZooming: true,
                        enablePanning: true,
                        zoomMode: ZoomMode.x,
                        maximumZoomLevel: 0.5,
                      ),
                      series: <ChartSeries<ChartData, DateTime>>[
                        LineSeries<ChartData, DateTime>(
                          name: "Weight",
                          dataSource: weightListToChartData(state.weightList),
                          markerSettings: const MarkerSettings(isVisible: true),
                          xValueMapper: (ChartData data, _) => data.date,
                          yValueMapper: (ChartData data, _) => data.weight,
                          enableTooltip: true,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
