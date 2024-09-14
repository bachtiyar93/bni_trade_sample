import 'package:bni_trade/view/base.dart';
import 'package:bni_trade/view/home/home.dart';
import 'package:bni_trade/view/login/login.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
Main.base: (_) => const Base(),
Main.login: (_) => const Login(),
  Main.home: (_) => const Home(),
};


class Main {
  static const String base = "/";
  static const String login = "/login";
  static const String home = '/home';

}