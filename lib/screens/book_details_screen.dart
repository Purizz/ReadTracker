import 'package:flutter/material.dart';
import '../models/books.dart';

class BookDetailsScreen extends StatefulWidget {
  final Book book;
  final Function(Book updatedBook) onUpdateBook;

  BookDetailsScreen({required this.book, required this.onUpdateBook});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late TextEditingController _pagesReadController;

  @override
  void initState() {
    super.initState();
    _pagesReadController =
        TextEditingController(text: widget.book.pagesRead.toString());
  }

  @override
  void dispose() {
    _pagesReadController.dispose();
    super.dispose();
  }

  void _updatePagesRead() {
    final int pagesRead = int.tryParse(_pagesReadController.text) ?? 0;

    if (pagesRead <= widget.book.totalPages) {
      setState(() {
        widget.book.pagesRead = pagesRead;
      });
      widget.onUpdateBook(widget.book); // Callback ke layar utama
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Progress updated!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pages read cannot exceed total pages!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${widget.book.title}', style: TextStyle(fontSize: 18)),
            Text('Author: ${widget.book.author}', style: TextStyle(fontSize: 16)),
            Text('Total Pages: ${widget.book.totalPages}',
                style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            TextField(
              controller: _pagesReadController,
              decoration: InputDecoration(
                labelText: 'Pages Read',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updatePagesRead,
              child: Text('Update Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
