import 'package:agile_crafts_task/injectors.dart';
import 'package:agile_crafts_task/src/core/config/size/size.dart';
import 'package:agile_crafts_task/src/core/database/open_box.dart';
import 'package:agile_crafts_task/src/core/router/go_router.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/context.dart';
import 'package:agile_crafts_task/src/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Opening Hive box
  await OpenBox.openBox();
  // Initializing service locator
  await initializeServiceLocator(); 

  runApp(ProviderScope(child: const MyApp()));
}



void configEasyLoading(BuildContext context) {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.transparent
    ..boxShadow = const <BoxShadow>[]
    ..indicatorColor = Colors.teal
    ..progressColor = Colors.teal
    ..textColor = Colors.white
    ..textStyle = const TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold)
    ..dismissOnTap = false
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black.withValues(alpha: 0.8)
    ..indicatorWidget = const SizedBox(
      height: 70.0,
      width: 70.0,
      child: SpinKitThreeBounce(color: Colors.teal, size: 30.0),
    )
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Agile Crafts',
      routerConfig: goRouter,
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(
        builder: (ctx, child) {
          topBarSize = ctx.padding.top;
          bottomViewPadding = ctx.padding.bottom;
          return MediaQuery(
            data: ctx.mq.copyWith(devicePixelRatio: 1.0, textScaler: const TextScaler.linear(1.0)),
            child: child!,
          );
        },
      ),
    );
  }
}
