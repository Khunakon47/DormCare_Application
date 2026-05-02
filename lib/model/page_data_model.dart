import 'package:flutter/material.dart';

class PageDataModel {
  const PageDataModel({
    required this.title,
    required this.screen,
    this.actions,
  });
  
  final String title;
  final Widget screen;
  final List<Widget>? actions;
}