import 'package:flutter/material.dart';

/// User can enter their expense and gain in here
class BookKeepingScreen extends StatefulWidget {
  const BookKeepingScreen({super.key});

  @override
  State<BookKeepingScreen> createState() {
    return _BookKeepingScreenState();
  }
}

class _BookKeepingScreenState extends State<BookKeepingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Text('temp') // ListView.builder(itemBuilder: itemBuilder),
      ),
    );
  }
}
