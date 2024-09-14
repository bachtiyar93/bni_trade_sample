import 'dart:async';
import 'dart:convert';

import 'package:bni_trade/core/network_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';

class HomeState extends ChangeNotifier{
  List<FlSpot> dataPoints = [];
  StreamController<List<FlSpot>> streamController = StreamController();
  Timer? get timer=>_timer;
  Timer? _timer;

  initHome(){
    channel.sink.add('{"action": "subscribe", "symbols": "ETH-USD"}');
    channel.stream.listen((message) {
      final parsedMessage = jsonDecode(message);
      double? timeInSeconds = parsedMessage['t'] != null ? parsedMessage['t'] / 1000 : null;
      double? price = parsedMessage['p'] != null ? double.parse(parsedMessage['p'].toString()) : null;

      if (timeInSeconds != null && price != null) {
          dataPoints.add(FlSpot(timeInSeconds, price));
          // Batasi data hanya untuk 5 menit terakhir (300 detik)
          dataPoints = dataPoints.where((point) => timeInSeconds - point.x <= 300).toList();
          notifyListeners();
      }
    });

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      streamController.add(dataPoints);
    });
    notifyListeners();
  }
}