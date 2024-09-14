import 'package:bni_trade/core/AppHelpers.dart';
import 'package:bni_trade/view/home/state/home_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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
        child: StreamBuilder<List<FlSpot>>(
          stream: local.streamController.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            double minY = snapshot.data!.map((e) => e.y).reduce((a, b) => a < b ? a : b);
            double maxY = snapshot.data!.map((e) => e.y).reduce((a, b) => a > b ? a : b);
            double yMargin = (maxY - minY) * 0.1; // 10% margin
            double interval = (maxY - minY) / 7;
            if (interval == 0) {
              interval = 1; // Set default interval if calculated interval is zero
            }

            double currentTime = local.dataPoints.isNotEmpty ? local.dataPoints.last.x : 0;

            return LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: snapshot.data!,
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 1,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
                minY: minY - yMargin,
                maxY: maxY + yMargin,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return const FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: interval,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toStringAsFixed(2));
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value == currentTime) {
                          return Text('${value/60000..toStringAsFixed(0)}');
                        } else if (value == currentTime - 60) {
                          return const Text('1m');
                        } else if (value == currentTime - 120) {
                          return const Text('2m');
                        } else if (value == currentTime - 180) {
                          return const Text('3m');
                        } else if (value == currentTime - 240) {
                          return const Text('4m');
                        } else if (value == currentTime - 300) {
                          return const Text('5m');
                        } else {
                          return Text('');
                        }
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
