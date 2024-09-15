import 'package:bni_trade/view/home/ChartPage.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BNI Trade Chart'),
      ),
      body: ChartPage(),
    );
  }
}

