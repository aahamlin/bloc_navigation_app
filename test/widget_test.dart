// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';

import 'package:bloc_navigation_app/main.dart';
import 'package:provider/provider.dart';
import 'package:bloc_navigation_app/core/session_bloc.dart';
import 'package:bloc_navigation_app/ui/home.dart';

//class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {

// Need to instantiate provider

  testWidgets('Start Button press', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Provider.value(
      value: SessionBloc(),
      child: WidgetsApp(
        color: Colors.blue,
        home: HomeScreen(),
      ),
    ));

    expect(find.widgetWithText(FlatButton, 'Start'), findsOneWidget);
  });
}
