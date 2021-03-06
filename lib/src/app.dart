import 'package:barcode_scanner/src/bloc/utility/AppConfig.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scanner/src/bloc/utility/AppConfig.dart';

import '../route_generator.dart';
import 'ui/ui_constants/theme/AppColors.dart';
import 'package:flutter/services.dart';

class RouteObservers {
  static RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
}

class App extends StatefulWidget {
  static BuildContext? rootContext;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            fontFamily: 'Roboto',
            primaryColor: Colors.white,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Color(0xFFFFFFFF),
            accentColor: AppColors(context).mainColor(1),
            focusColor: AppColors(context).accentColor(1),
            hintColor: AppColors.timberWolf,
            canvasColor: Colors.transparent,
            unselectedWidgetColor: AppColors(context).mainColor(1),
            textTheme: TextTheme(
              //used as drawer items
              headline1: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'RobotoCondensed',
                fontSize: AppConfig.of(context).appWidth(5),
                // color: AppColors.black,
              ),
              //used as main headline items
              headline2: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'RobotoCondensed',
                fontSize: AppConfig.of(context).appWidth(7),
              ),
              //used as item text 1
              headline3: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: AppConfig.of(context).appWidth(4),
                fontWeight: FontWeight.w600,
              ),
              //used as item text 2
              headline4: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: AppConfig.of(context).appWidth(4.3),
                fontWeight: FontWeight.w400,
              ),
              //used as item description
              headline5: TextStyle(
                fontFamily: 'Roboto',
                fontSize: AppConfig.of(context).appWidth(3.2),
                fontWeight: FontWeight.w400,
              ),
              headline6: TextStyle(
                fontFamily: 'Roboto',
                fontSize: AppConfig.of(context).appWidth(7),
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              subtitle1: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors(context).mainColor(1)),
              subtitle2: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: AppConfig.of(context).appWidth(4.5),
                  fontWeight: FontWeight.w300,
                  color: AppColors(context).secondColor(0.7)),
              bodyText1: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: AppConfig.of(context).appWidth(5),
                  fontWeight: FontWeight.w400,
                  color: AppColors(context).secondColor(0.6)),
              bodyText2: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'RobotoCondensed',
                  fontSize: AppConfig.of(context).appWidth(4.2),
                  color: AppColors(context).secondColor(1)),
            ),
          ),
          child: child!,
        );
      },

      supportedLocales: [Locale('en', 'US')],
      initialRoute: RouteNames.LOGIN,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        RouteObservers.routeObserver,
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class RouteAwareWidget extends StatefulWidget {
  final String name;
  final Widget? child;

  RouteAwareWidget(this.name, {@required this.child});

  @override
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    RouteObservers.routeObserver
        .subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    RouteObservers.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    print('didPush ${widget.name}');
    App.rootContext = context;
  }

  @override
  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {
    print('didPopNext ${widget.name}');
    App.rootContext = context;
  }

  @override
  Widget build(BuildContext context) => widget.child!;
}
