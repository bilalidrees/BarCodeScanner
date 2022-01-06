//@dart=2.9
import 'package:flutter/material.dart';
import 'package:barcode_scanner/src/app.dart';
import 'package:barcode_scanner/src/provider_locale_data.dart';
import 'package:barcode_scanner/src/resource/networkConstant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EnvironmentConfig.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();

  var configuredApp = EnvironmentConfig(
    child: MultiProvider(
      providers: [
        FutureProvider(
            create: (context) => SharedPreferences.getInstance(), lazy: false),
        ChangeNotifierProxyProvider<SharedPreferences, RecentlyPlayed>(
          create: (context) =>
              RecentlyPlayed(context.read<SharedPreferences>()),
          update: (context, pref, recent) => RecentlyPlayed(pref),
        ),
      ],
      child: App(),
    ),
  );
  runApp(configuredApp);
}
