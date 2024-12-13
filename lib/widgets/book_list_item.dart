import 'package:flutter/material.dart';
import '../models/books.dart';
import '../screens/book_details_screen.dart';

class BookListItem extends StatelessWidget {
  final Book book;

  BookListItem({required this.book, required void Function(dynamic updatedBook) onEdit});

  get selectedBook => null;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(book.title),
        subtitle: Text('Author: ${book.author}'),
        trailing: Text('${book.pagesRead}/${book.totalPages}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsScreen(
                  book: book, // Pass the correct book object here
                  onUpdateBook: (updatedBook) {
                    // Update the book in your list
                  },
                ),
              ),
            );
          },
      ),
    );
  }
}
