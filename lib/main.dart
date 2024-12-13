import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_book_screen.dart';
import 'screens/book_details_screen.dart';

void main() => runApp(ReadTrackerApp());

class ReadTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Read Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(), // Set HomeScreen sebagai layar utama
    );
  }
}
