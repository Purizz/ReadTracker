import 'package:flutter/material.dart';
import '../models/books.dart';

class EndedBooksScreen extends StatelessWidget {
  final List<Book> endedBooks;

  EndedBooksScreen({required this.endedBooks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Finished Books')),
      body: endedBooks.isEmpty
          ? Center(child: Text('No finished books yet!'))
          : ListView.builder(
        itemCount: endedBooks.length,
        itemBuilder: (context, index) {
          final book = endedBooks[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text('Author: ${book.author}'),
          );
        },
      ),
    );
  }
}

