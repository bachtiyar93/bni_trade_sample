import 'package:bni_trade/core/AppHelpers.dart';
import 'package:bni_trade/view/home/state/home_state.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    HomeState local = AppHelpers.getState<HomeState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<ChartData>>(
          stream: local.streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            double currentTime = local.dataPoints.isNotEmpty ? local.dataPoints.last.time : 0;
            double minY = snapshot.data!.map((e) => e.price).reduce((a, b) => a < b ? a : b);
            double maxY = snapshot.data!.map((e) => e.price).reduce((a, b) => a > b ? a : b);
            double yMargin = (maxY - minY) * 0.1; // 10% margin
            double interval = (maxY - minY) / 7;
            if (interval == 0) {
              interval = 1; // Set default interval if calculated interval is zero
            }

            return SfCartesianChart(
              primaryXAxis: NumericAxis(
                interval: 60, // Interval setiap menit
                title: AxisTitle(text: 'Time (minutes)'),
                majorGridLines: const MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                axisLabelFormatter: (AxisLabelRenderDetails details) {
                  num value = details.value;

                  // Ubah timestamp ke DateTime
                  var dateTime = DateTime.fromMillisecondsSinceEpoch(value.toInt() * 60000);

                  // Hitung selisih waktu
                  var difference = DateTime.now().difference(dateTime);
                  if (value > currentTime) {
                    return ChartAxisLabel('now', const TextStyle(color: Colors.black));
                  } else if (value >= currentTime - 300) {
                    return ChartAxisLabel('5m', const TextStyle(color: Colors.black));
                  } else if (value >= currentTime - 240) {
                    return ChartAxisLabel('4m', const TextStyle(color: Colors.black));
                  } else if (value >=currentTime - 180) {
                    return ChartAxisLabel('3m', const TextStyle(color: Colors.black));
                  } else if (value >= currentTime - 120) {
                    return ChartAxisLabel('2m', const TextStyle(color: Colors.black));
                  } else if (value >= currentTime - 60) {
                    return ChartAxisLabel('1m', const TextStyle(color: Colors.black));
                  } else {
                    return ChartAxisLabel('', const TextStyle(color: Colors.black));}
                },
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(text: 'Price'),
                majorGridLines: const MajorGridLines(width: 0),
                interval: interval,
              ),
              series: <ChartSeries>[
                LineSeries<ChartData, double>(
                  dataSource: snapshot.data!,
                  xValueMapper: (ChartData data, _) => data.time,
                  yValueMapper: (ChartData data, _) => data.price,
                  color: Colors.blue,
                  width: 2,
                ),
              ],
              crosshairBehavior: CrosshairBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
                lineType: CrosshairLineType.both,
                lineWidth: 1,
                lineDashArray: [5, 5],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.time, this.price);
  final double time;
  final double price;
}