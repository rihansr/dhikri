import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/model/adhkar_model.dart';
import 'package:dhikri/pages/details_page.dart';
import 'package:dhikri/pages/home_page.dart';
import 'package:dhikri/pages/items_page.dart';
import 'package:dhikri/routes/routes.dart';
import 'package:flutter/material.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    List<dynamic>? args = settings.arguments as List<dynamic>?;

    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Routes.itemsPage:
        return MaterialPageRoute(
            builder: (_) => ItemsPage(
                  homeBloc: args![0] as HomeBloc,
                  azkar: args[1] as Adhkar,
                ));
      case Routes.detailsPage:
        return MaterialPageRoute(
            builder: (_) => DetailsPage(
                  homeBloc: args![0] as HomeBloc,
                  itemPos: args[1] as int,
                  item: args[2] as AdhkarItem,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text("Invalid Route!!"),
            ),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
