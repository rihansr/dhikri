import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/data.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...independentService,
  ...universalService,
];

List<SingleChildWidget> independentService = [Provider.value(value: local)];

List<SingleChildWidget> universalService = [
  ChangeNotifierProvider<HomeBloc>(create: (context) => HomeBloc()),
];
