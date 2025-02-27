import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'router.dart';
import 'provider_setup.dart';
import 'package:bloc_navigation_app/core/database.dart';
import 'package:bloc_navigation_app/core/log_manager.dart';

void main() async {
  var logger = LogManager.getLogger('main');
  logger.i('app started');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
//          navigatorObservers: [],
        onGenerateRoute: Router.onGenerateRoute,
      ),
    );
  }
}

