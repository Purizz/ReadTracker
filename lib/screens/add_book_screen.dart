import 'package:flutter/material.dart';
import '../services/open_library_service.dart';
import '../models/books.dart';

class AddBookScreen extends StatefulWidget {
  final Function(Book) onAddBook;

  AddBookScreen({required this.onAddBook});

  @override
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _pagesController = TextEditingController();
  final _searchController = TextEditingController();
  final _openLibraryService = OpenLibraryService();

  bool _isLoading = false;
  List<Map<String, dynamic>> _searchResults = [];

  void _searchBooks() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final results = await _openLibraryService.searchBooks(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addSelectedBook(Map<String, dynamic> bookData) {
    final newBook = Book(
      title: bookData['title'],
      author: bookData['author'],
      totalPages: bookData['pageCount'] ?? 0,
      pagesRead: 0, id: '',
    );
    widget.onAddBook(newBook);
    Navigator.pop(context); // Close the add book screen
  }

  void _addBookManually() {
    if (_titleController.text.isEmpty || _authorController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all required fields.')),
      );
      return;
    }

    final newBook = Book(
      title: _titleController.text,
      author: _authorController.text,
      totalPages: int.tryParse(_pagesController.text) ?? 0,
      pagesRead: 0, id: '',
    );

    widget.onAddBook(newBook);
    Navigator.pop(context); // Close the add book screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for a book',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchBooks,
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Search Results
            if (_isLoading) Center(child: CircularProgressIndicator()),
            if (_searchResults.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final book = _searchResults[index];
                  final coverUrl =
                  _openLibraryService.getCoverUrl(book['coverId']);

                  return ListTile(
                    leading: coverUrl.isNotEmpty
                        ? Image.network(coverUrl, width: 50, fit: BoxFit.cover)
                        : Icon(Icons.book),
                    title: Text(book['title']),
                    subtitle: Text(book['author']),
                    trailing: Text(
                      book['pageCount'] > 0
                          ? '${book['pageCount']} pages'
                          : 'Unknown pages',
                    ),
                    onTap: () => _addSelectedBook(book),
                  );
                },
              ),

            SizedBox(height: 24.0),
            Divider(),
            SizedBox(height: 16.0),

            // Manual Book Entry
            Text(
              'Add Book Manually',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            TextField(
              controller: _pagesController,
              decoration: InputDecoration(labelText: 'Total Pages'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _addBookManually,
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}
