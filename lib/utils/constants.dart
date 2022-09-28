import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';

List<TabItem> tabItems = List.of([
  TabItem(Icons.home, "Home", Colors.blue, labelStyle: TextStyle(fontWeight: FontWeight.normal)),
  TabItem(Icons.search, "Search", Colors.orange, labelStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
  TabItem(Icons.layers, "Reports", Colors.red),
  TabItem(Icons.notifications, "Notifications", Colors.cyan),
]);