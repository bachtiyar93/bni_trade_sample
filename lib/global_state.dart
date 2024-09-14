import 'dart:developer';
import 'dart:io';

import 'package:bni_trade/core/AppHelpers.dart';
import 'package:bni_trade/model/screen.dart';
import 'package:bni_trade/routes.dart';
import 'package:bni_trade/view/home/state/home_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class GlobalState extends ChangeNotifier {
  ScreenSize? screen;
  String deviceOS = "";
  bool logedin = false;
  bool isSkip = false;

  setDeviceOS() {
    deviceOS = Platform.operatingSystem;
    AppHelpers.setShow(deviceOS);
    notifyListeners();
  }

  setScreen() {
    screen = ScreenSize(
        width: MediaQuery.of(AppHelpers.navigation.currentContext!).size.width,
        height:
        MediaQuery.of(AppHelpers.navigation.currentContext!).size.height);
    notifyListeners();
  }

  void moveToHome() {
    HomeState local = AppHelpers.getState<HomeState>(listen: false);
    local.initHome();
    AppHelpers.navigation.openPageNamedNoNav(Main.home);
  }
}
