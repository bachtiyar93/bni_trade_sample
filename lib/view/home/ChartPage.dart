import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:bni_trade/model/chartdata.dart';
import 'package:bni_trade/view/home/state/home_state.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<HomeState>(
                  builder: (context, local, child) {
                    return Text('Market: ${local.selectedMarket}');
                  },
                ),
                Consumer<HomeState>(
                  builder: (context, local, child) {
                    return Text('Speed update: 1 seconds');
                  },
                ),
              ],
            ),

            Expanded(
              child: Consumer<HomeState>(
                builder: (context, local, child) {
                  return SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    primaryYAxis: NumericAxis(),
                    series: <ChartSeries>[
                      LineSeries<ChartData, DateTime>(
                        dataSource: local.selectedMarket == 'BTC-USD' ? local.btcData : local.ethData,
                        xValueMapper: (ChartData data, _) => data.time,
                        yValueMapper: (ChartData data, _) => data.price,
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => context.read<HomeState>().selectMarket('BTC-USD'),
                  child: const Text('BTC Market'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => context.read<HomeState>().selectMarket('ETH-USD'),
                  child: const Text('ETH Market'),
                ),
              ],
            ),
            Expanded(
              child: Consumer<HomeState>(
                builder: (context, local, child) {
                  return ListView(
                    children: [
                      ListTile(
                        title: const Text('BTC-USD'),
                        subtitle: Text('Last Price: ${local.btcLastPrice}'),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Chg: ${local.btcChg}'),
                            Text('Chg%: ${local.btcChgPercent}%'),
                          ],
                        ),
                      ),
                      ListTile(
                        title: const Text('ETH-USD'),
                        subtitle: Text('Last Price: ${local.ethLastPrice}'),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Chg: ${local.ethChg}'),
                            Text('Chg%: ${local.ethChgPercent}%'),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

