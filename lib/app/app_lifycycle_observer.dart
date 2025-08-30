import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/helpers/helper_methods.dart';

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;

  const AppLifecycleObserver({required this.child, super.key});

  @override
  State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
  final StreamController<AppLifecycleState> lifecycleController =
      StreamController<AppLifecycleState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    lifecycleController.close();
    super.dispose();
  }

  // Print current app life_cycle (inactive - hidden - paused - resumed)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    lifecycleController.sink.add(state);
    devLog('lifecycleController: ${state.name}');
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<Stream<AppLifecycleState>>.value(
      value: lifecycleController.stream,
      child: widget.child,
    );
  }
}
