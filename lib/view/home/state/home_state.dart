import 'dart:async';
import 'dart:convert';

import 'package:bni_trade/core/network_service.dart';
import 'package:bni_trade/view/home/home.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class HomeState extends ChangeNotifier{
  List<ChartData> dataPoints = [];
  StreamController<List<ChartData>> streamController = StreamController();
  Timer? get timer=>_timer;
  Timer? _timer;

  initHome(){
    channel.sink.add('{"action": "subscribe", "symbols": "ETH-USD"}');
    channel.stream.listen((message) {
      final parsedMessage = jsonDecode(message);
      double? timeInSeconds = parsedMessage['t'] != null ? parsedMessage['t'] / 60000 : null;
      double? price = parsedMessage['p'] != null ? double.parse(parsedMessage['p'].toString()) : null;

      if (timeInSeconds != null && price != null) {
          dataPoints.add(ChartData(timeInSeconds, price));
          // Batasi data hanya untuk 5 menit terakhir (300 detik)
          dataPoints = dataPoints.where((point) => timeInSeconds - point.time <= 300).toList();
          notifyListeners();
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      streamController.add(dataPoints);
    });
    notifyListeners();
  }
}