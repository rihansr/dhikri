import 'package:dhikri/configs/provider_config.dart';
import 'package:dhikri/configs/settings.dart';
import 'package:dhikri/helper/preference_manager.dart';
import 'package:dhikri/route_generator.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/drawables.dart';
import 'package:dhikri/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await preferenceManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: color.homePrimaryColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return ValueListenableBuilder(
      valueListenable: settings.currentLocale,
      builder: (context, Locale value, _) {
        precacheImage(AssetImage(drawable.morningAzkarIcon), context);
        precacheImage(AssetImage(drawable.eveningAzkarIcon), context);
        precacheImage(AssetImage(drawable.sunnahBeforeSleepIcon), context);
        precacheImage(AssetImage(drawable.fridaySunnahIcon), context);

        return MultiProvider(
          providers: providers,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Dhikri',
                theme: ThemeData().copyWith(
                  appBarTheme: AppBarTheme().copyWith(
                    brightness: Brightness.dark,
                  ),
                  brightness: Brightness.light,
                  backgroundColor: Colors.transparent,
                  scaffoldBackgroundColor: Colors.transparent,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                locale: value,
                localizationsDelegates: [
                  Str.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: Str.delegate.supportedLocales,
                localeListResolutionCallback:
                    Str.delegate.listResolution(fallback: Locale('bn', '')),
                initialRoute: kHomeRoute,
                onGenerateRoute: RouterGenerator.generateRoute,
              );
            },
          ),
        );
      },
    );
  }
}
