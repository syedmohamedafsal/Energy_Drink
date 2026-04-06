import 'package:flutter/material.dart';

class Drink {
  final String name;
  final String path;
  final Color bgColor;
  final Color textColor;
  final Color highlightColor;
  final Color accentColor;
  final Color buttonTextColor;
  final Color arcColor;
  final Color iconBgColor;
  final Color iconColor;

  const Drink({
    required this.name,
    required this.path,
    required this.bgColor,
    required this.textColor,
    required this.highlightColor,
    required this.accentColor,
    required this.buttonTextColor,
    required this.arcColor,
    required this.iconBgColor,
    required this.iconColor,
  });
}
