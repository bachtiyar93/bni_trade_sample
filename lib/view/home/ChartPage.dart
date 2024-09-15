

import 'dart:convert';

import 'package:bni_trade/core/network_service.dart';
import 'package:bni_trade/model/chartdata.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  List<ChartData> btcData = [];
  List<ChartData> ethData = [];
  String selectedMarket = 'BTC-USD';
  double btcLastPrice = 0.0;
  double ethLastPrice = 0.0;
  double btcChg = 0.0;
  double ethChg = 0.0;
  double btcChgPercent = 0.0;
  double ethChgPercent = 0.0;

  @override
  void initState() {
    super.initState();
    channel.sink.add('{"action": "subscribe", "symbols": "BTC-USD, ETH-USD"}');
    channel.stream
        .doOnData((data) => print('Data diterima: $data')) // Log data yang diterima
        .throttleTime(const Duration(seconds: 1))
        .listen((data) {
      print('Data setelah throttle: $data'); // Log data setelah throttle
      final json = jsonDecode(data);
      final symbol = json['s'];
      final price = double.parse(json['p'] ?? '0');
      final time = DateTime.fromMillisecondsSinceEpoch(json['t'] ?? 0);
      final chg = double.parse(json['dd'] ?? '0');
      final chgPercent = double.parse(json['dc'] ?? '0');

      setState(() {
        if (symbol == 'BTC-USD') {
          btcData.add(ChartData(time, price));
          btcLastPrice = price;
          btcChg = chg;
          btcChgPercent = chgPercent;
        } else if (symbol == 'ETH-USD') {
          ethData.add(ChartData(time, price));
          ethLastPrice = price;
          ethChg = chg;
          ethChgPercent = chgPercent;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Market: $selectedMarket'),
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(),
              primaryYAxis: NumericAxis(),
              series: <ChartSeries>[
                LineSeries<ChartData, DateTime>(
                  dataSource: selectedMarket == 'BTC-USD' ? btcData : ethData,
                  xValueMapper: (ChartData data, _) => data.time,
                  yValueMapper: (ChartData data, _) => data.price,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedMarket = 'BTC-USD';
                  });
                },
                child: const Text('BTC Market'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedMarket = 'ETH-USD';
                  });
                },
                child: const Text('ETH Market'),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('BTC-USD'),
                  subtitle: Text('Last Price: $btcLastPrice'),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Chg: $btcChg'),
                      Text('Chg%: $btcChgPercent%'),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('ETH-USD'),
                  subtitle: Text('Last Price: $ethLastPrice'),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Chg: $ethChg'),
                      Text('Chg%: $ethChgPercent%'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}