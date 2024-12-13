import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenLibraryService {
  Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    final url = 'https://openlibrary.org/search.json?q=$query';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List books = data['docs'];

      return books.map((book) {
        return {
          'title': book['title'] ?? 'No Title',
          'author': (book['author_name'] ?? ['Unknown Author']).join(', '),
          'pageCount': book['number_of_pages_median'] ?? 0,
          'coverId': book['cover_i'], // Digunakan untuk menampilkan gambar
        };
      }).toList();
    } else {
      throw Exception('Failed to fetch books');
    }
  }

  String getCoverUrl(int? coverId) {
    if (coverId == null) return '';
    return 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'; // Ukuran gambar medium
  }
}
