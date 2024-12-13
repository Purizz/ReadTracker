import 'package:flutter/material.dart';
import '../models/books.dart';
import 'add_book_screen.dart';
import 'book_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Book> _books = [
    Book(title: 'Book 1', author: 'Author 1', totalPages: 200, id: ''),
    Book(title: 'Book 2', author: 'Author 2', totalPages: 300, id: ''),
  ];

  void _addBook(Book newBook) {
    setState(() {
      _books.add(newBook);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Books'),
        actions: [
          IconButton(
            icon: Icon(Icons.add), // Tombol Add Book
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookScreen(onAddBook: _addBook),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _books.length,
        itemBuilder: (context, index) {
          final book = _books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text('${book.pagesRead}/${book.totalPages} pages read'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailsScreen(
                    book: book,
                    onUpdateBook: (updatedBook) {
                      setState(() {
                        _books[index] = updatedBook;
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
