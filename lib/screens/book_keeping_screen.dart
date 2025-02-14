import 'package:flutter/material.dart';
import 'package:xpensr/core/constants/record.dart';
import 'package:xpensr/core/dto/record_dto.dart';
import 'package:xpensr/widgets/record_card.dart';

/// User can enter their expense and gain in here
class BookKeepingScreen extends StatefulWidget {
  const BookKeepingScreen({super.key});

  @override
  State<BookKeepingScreen> createState() {
    return _BookKeepingScreenState();
  }
}

class _BookKeepingScreenState extends State<BookKeepingScreen> {
  final List<RecordDto> _testRecords = [
    RecordDto.twd(amount: -30, type: RecordType.gifts, title: 'Chrismas Gift', date: DateTime.now()),
    RecordDto.twd(amount: 50, type: RecordType.salary, title: 'Chrismas Gift', date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _testRecords.length,
              itemBuilder: (BuildContext ctx, int idx) =>
                  RecordCard(recordDto: _testRecords[idx]),
            ),
          )
        ],
      ),
    );
  }
}
