import 'dart:async';
import 'dart:ui';

import 'package:esferasoft/provider/home_provider.dart';
import 'package:esferasoft/theme/light_theme.dart';
import 'package:esferasoft/utill/app_constants.dart';
import 'package:esferasoft/view/screen/home.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'di_container.dart' as di;
import 'helper/route_helper.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
    ],
    child: const MyApp(isWeb: kIsWeb,),
  ));
}

class MyApp extends StatefulWidget {
  final bool isWeb;
  const MyApp({super.key, required this.isWeb});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    RouteHelper.setupRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      onGenerateRoute: RouteHelper.router.generator,
      navigatorKey: navigatorKey,
      theme: light,
      locale: Locale('en'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      scrollBehavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
            PointerDeviceKind.stylus,
            PointerDeviceKind.unknown
          }),
      home: HomeScreen(),
    );
  }
}

