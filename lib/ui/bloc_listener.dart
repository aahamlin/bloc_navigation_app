import 'dart:async';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:bloc_navigation_app/core/bloc_base.dart';
import 'package:bloc_navigation_app/core/session_bloc.dart';
import 'package:bloc_navigation_app/core/session_model.dart';

import 'package:bloc_navigation_app/core/log_manager.dart';

class BlocListener<B extends BlocBase<T>, T> extends StatefulWidget {

  final Widget child;
  final void Function(BuildContext context, dynamic state) listener;
  final B bloc;

  BlocListener({Key key,
    @required Widget this.child,
    @required this.listener,
    @required this.bloc}) : super(key: key);

  @override
  _BlocListenerState createState() => _BlocListenerState();
}

class _BlocListenerState<B extends BlocBase<T>, T>
    extends State<BlocListener<B, T>> {

  Logger logger;
  StreamSubscription<T> _subscription;
  T _previousState;
  B _bloc;

  @override
  void initState() {
    super.initState();
    logger = LogManager.getLogger('BlocListener');
    logger.d('initState');
    _bloc = widget.bloc ?? Provider.of<B>(context);
    _previousState = _bloc?.currentState;
    _subscribe();
  }

  @override
  void dispose() {
    logger.d('dispose');
    _unsubscribe();
    super.dispose();
  }


  @override
  void didUpdateWidget(BlocListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    final Stream<T> oldStream =
      oldWidget.bloc?.stream ?? Provider.of<B>(context).stream;
    final Stream<T> currentStream = widget.bloc?.stream ?? oldStream;
    if (oldStream != currentStream) {
      logger.d('oldStream != currentStream');
      if (_subscription != null) {
        _unsubscribe();
        _bloc = widget.bloc ?? Provider.of<B>(context);
        _previousState = _bloc?.currentState;
      }
      _subscribe();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.d('didChangeDependencies');
  }

  _subscribe() {
    if (_bloc?.stream != null) {
      _subscription = _bloc.stream.listen((T event) {
        // todo: add conditional compare values?
        widget.listener(context, event);
        _previousState = event;
      });
      logger.d('subscribed');
    }
  }

  _unsubscribe() {
    if (_subscription != null) {
      _subscription.cancel();
      logger.d('unsubscribed');
      _subscription = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

}