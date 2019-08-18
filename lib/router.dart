import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/running.dart';
import 'ui/complete.dart';

import 'package:bloc_navigation_app/core/log_manager.dart';

class Router {

  static final Logger logger = LogManager.getLogger('Router');

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    logger.d('onGenerateRoute: $settings');
    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case '/running':
        return MaterialPageRoute(builder: (context) => RunningScreen());
      case '/complete':
        return MaterialPageRoute(builder: (context) => CompleteScreen());
      default:
        return MaterialPageRoute(builder: (context) => UnknownRouteScreen());
    }
  }
}

class UnknownRouteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Sorry! Page missing.'),
              ],
            )
        )
    );
  }
}