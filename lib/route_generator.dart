import 'package:barcode_scanner/src/bloc/bloc_provider.dart';

import 'package:barcode_scanner/src/ui/pages/user/login.dart';
import 'package:barcode_scanner/src/ui/pages/user/result.dart';
import 'package:barcode_scanner/src/ui/pages/user/scanner.dart';

import 'src/app.dart';

import 'package:barcode_scanner/src/ui/pages/other_module/MainPageNavigator.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final ScreenArguments args = settings.arguments as ScreenArguments;
    switch (settings.name) {
      case RouteNames.LOGIN:
        return MaterialPageRoute(
            builder: (_) => RouteAwareWidget(RouteNames.LOGIN, child: Login()));
      case RouteNames.SPLASH:
        return MaterialPageRoute(
            builder: (_) =>
                RouteAwareWidget(RouteNames.SPLASH, child: BarCodeScanner()));
      case RouteNames.MAINPAGE:
        return MaterialPageRoute(
            builder: (_) => RouteAwareWidget(RouteNames.MAINPAGE,
                child: Result(data: args.data)));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class RouteNames {
  static const String SPLASH = "/welcome";
  static const String MAINPAGE = "/MainPage";
  static const String LOGIN = "/Login";
}
