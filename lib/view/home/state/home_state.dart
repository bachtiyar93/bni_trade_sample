import 'dart:convert';

import 'package:bni_trade/core/network_service.dart';
import 'package:bni_trade/model/chartdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeState with ChangeNotifier{
  List<ChartData> btcData = [];
  List<ChartData> ethData = [];
  String selectedMarket = 'BTC-USD';
  double btcLastPrice = 0.0;
  double ethLastPrice = 0.0;
  double btcChg = 0.0;
  double ethChg = 0.0;
  double btcChgPercent = 0.0;
  double ethChgPercent = 0.0;
  TextEditingController controller= TextEditingController();

  initHome(){
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
      notifyListeners();
    });
    notifyListeners();
  }

  selectMarket(String s) {
    selectedMarket=s;
    notifyListeners();
  }
  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}