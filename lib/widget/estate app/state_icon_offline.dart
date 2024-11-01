import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webandean/provider/offlineState/provider_offline_state.dart';

class SignalAPi extends StatefulWidget {
  const SignalAPi({super.key});

  @override
  State<SignalAPi> createState() => _SignalAPiState();
}

class _SignalAPiState extends State<SignalAPi> {
  late Timer _timer;
  int _signalStrength = 0;

  @override
  void initState() {
    super.initState();
    _startSignalAnimation();
  }

  void _startSignalAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // Simulamos una actualización de intensidad de señal
        _signalStrength = (_signalStrength + 1) % 2;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<OfflineStateProvider>(context);
    bool isoffline = dataProvider.isOffline;
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Icon(
        _getSignalIcon(),
        size: 15,
        color:isoffline ? Color(0xFFFF9891) : Colors.green,
      ),
    );
  }

  IconData _getSignalIcon() {
    switch (_signalStrength) {
      case 0:
        return Icons.offline_bolt;
      case 1:
        return Icons.offline_bolt_outlined;
      default:
        return Icons.offline_bolt;
    }
  }
}
