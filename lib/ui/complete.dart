import 'package:flutter/material.dart';
import 'package:bloc_navigation_app/core/log_manager.dart';

class CompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var logger = LogManager.getLogger('CompleteScreen');
    logger.d('Building complete screen');

    return Scaffold(
      appBar: AppBar(
        title: Text('Complete'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Complete!'),
          ],
        )
      )
    );
  }
}