import 'package:bni_trade/global_state.dart';
import 'package:bni_trade/view/home/state/HomeState.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => GlobalState()),
  ChangeNotifierProvider(create: (_) => HomeState()),

];