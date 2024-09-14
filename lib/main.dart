import 'package:bni_trade/core/AppHelpers.dart';
import 'package:bni_trade/view/color_component.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await Hive.initFlutter();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      builder: (context, child) {
        return OKToast(
          child: MaterialApp(
            title: 'MASA',
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            navigatorKey: AppHelpers.navigation.navigatorKey,
            scaffoldMessengerKey: AppHelpers.navigation.messengerKey,
            navigatorObservers: [BotToastNavigatorObserver()],
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                // background: Colors.white,
                surfaceTint: Colors.white,
              ),
              fontFamily: 'Inter',
              textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Inter'),
              // bottomSheetTheme: const BottomSheetThemeData(
              //     backgroundColor: Colors.transparent),
              tabBarTheme: const TabBarTheme(
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
              ),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: Col.blue500,
                selectionColor: Col.blue500.withOpacity(0.2),
                selectionHandleColor: Col.blue500,
              ),
              useMaterial3: true,
            ),
            initialRoute: Main.base,
            routes: {
              Main.base: (_) => const Base(),
              Main.login: (_) => const Login(),
            },
          ),
        );
      },
    );
  }
}

class Main {
  static const String base = "/";
  static const String login = "/login";
  static const String home = '/home';

}
