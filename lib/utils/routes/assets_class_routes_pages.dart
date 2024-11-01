
import 'package:flutter/material.dart';
class RoutesLocalStorage {
  Widget icon;
  String title;
  Widget path;
  String? content;
  List<dynamic>? lisdata;
  RoutesLocalStorage(
  {required this.icon, required this.title, required this.path, this.content, this.lisdata});
}


class ChartData {
  final String action;
  final double percentage;
  final Color color;

  ChartData(this.action, this.percentage, this.color);
}


