import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/data.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Data data = Data();

List<SingleChildWidget> providers = [
  ...independentService,
  ...universalService,
];

List<SingleChildWidget> independentService = [Provider.value(value: data)];

List<SingleChildWidget> universalService = [
  ChangeNotifierProvider<HomeBloc>(create: (context) => HomeBloc(data: data)),
];
