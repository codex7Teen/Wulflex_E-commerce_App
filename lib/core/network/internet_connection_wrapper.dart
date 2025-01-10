import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:wulflex/core/network/no_network_screen.dart';

class InternetConnectionWrapper extends StatefulWidget {
  final Widget child;

  const InternetConnectionWrapper({
    super.key,
    required this.child,
  });

  @override
  State<InternetConnectionWrapper> createState() => _InternetConnectionWrapperState();
}

class _InternetConnectionWrapperState extends State<InternetConnectionWrapper> {
  bool isConnectedToInternet = true;
  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
  }

  void _checkInternetConnection() {
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      log('Internet status: $event');
      setState(() {
        isConnectedToInternet = event == InternetStatus.connected;
      });
    });
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isConnectedToInternet ? widget.child : const NoNetworkScreen();
  }
}