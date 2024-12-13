import 'package:flutter/material.dart';

class ProgressTracker extends StatelessWidget {
  final int totalPages;
  final int pagesRead;

  ProgressTracker({required this.totalPages, required this.pagesRead});

  @override
  Widget build(BuildContext context) {
    final double progress = totalPages > 0 ? pagesRead / totalPages : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress: ${(progress * 100).toStringAsFixed(1)}%',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(1)}%',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        )
      ],
    );
  }
}
