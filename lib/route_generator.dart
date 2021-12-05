import 'package:dhikri/blocs/home_bloc.dart';
import 'package:dhikri/model/adhkar_model.dart';
import 'package:dhikri/pages/details_page.dart';
import 'package:dhikri/pages/home_page.dart';
import 'package:dhikri/pages/items_page.dart';
import 'package:dhikri/pages/web_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Routes
const String kHomeRoute = '/';
const String kItemsRoute = '/itemsPage';
const String kDetailsRoute = '/detailsPage';
const String kWebPageRoute = '/webPage';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    List<dynamic> args = settings.arguments;

    switch (settings.name) {
      case kHomeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case kItemsRoute:
        return MaterialPageRoute(
            builder: (_) => ItemsPage(
                  homeBloc: args[0] as HomeBloc,
                  azkar: args[1] as Adhkar,
                ));
      case kDetailsRoute:
        return MaterialPageRoute(
            builder: (_) => DetailsPage(
                  homeBloc: args[0] as HomeBloc,
                  itemPos: args[1] as int,
                  item: args[2] as AdhkarItem,
                ));
      case kWebPageRoute:
        return MaterialPageRoute(
          builder: (_) => WebPage(args == null ? null : args[0] as String),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text("Invalid Route!!"),
            ),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
