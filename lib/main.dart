import 'package:dhikri/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:dhikri/configs/provider_config.dart';
import 'package:dhikri/configs/settings.dart';
import 'package:dhikri/helper/navigation_service.dart';
import 'package:dhikri/helper/preference_manager.dart';
import 'package:dhikri/routes/route_generator.dart';
import 'package:dhikri/values/colors.dart';
import 'package:dhikri/values/drawables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await preferenceManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: color.primary,
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
                scaffoldMessengerKey: navigator.scaffoldMessengerKey,
                navigatorKey: navigator.navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Dhikri',
                theme: ThemeData().copyWith(
                  brightness: Brightness.light,
                  scaffoldBackgroundColor: Colors.transparent,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                locale: value,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                initialRoute: Routes.homePage,
                onGenerateRoute: RouterGenerator.generateRoute,
              );
            },
          ),
        );
      },
    );
  }
}
