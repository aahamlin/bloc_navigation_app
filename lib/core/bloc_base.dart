import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class BlocBase<T> {

  StreamController<T> _controller = StreamController<T>.broadcast();

  StreamSink<T> get _inSink => _controller.sink;

  Stream<T> get stream => _controller.stream;

  T _state;

  T get currentState => _state;

  void add(T event) {
    _inSink.add(event);
    _state = event;
  }

  @mustCallSuper
  void dispose() {
    _controller.close();
  }

}