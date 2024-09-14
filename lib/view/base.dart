import 'package:bni_trade/core/AppHelpers.dart';
import 'package:bni_trade/global_state.dart';
import 'package:bni_trade/view/color_component.dart';
import 'package:bni_trade/view/style.dart';
import 'package:flutter/material.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  GlobalState controller = AppHelpers.getState<GlobalState>();
  @override
  void initState() {
    AppHelpers.runAfterBuild(
      Future.delayed(const Duration(seconds: 2), () {
        controller.setScreen();
        controller.setDeviceOS();
        controller.moveToHome();
      }),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Col.darkBlue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('BNI Trade', style: AppStyles.headingL.bold.mainButton,),
            Icon(Icons.monetization_on, color: Col.mainButtonColor, size: 200,)
          ],
        ),
      ),
    );
  }
}
